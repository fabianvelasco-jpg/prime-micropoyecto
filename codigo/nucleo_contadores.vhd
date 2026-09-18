library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity nucleo_contadores is
    port (
        clk, resed, inicio, sw_direccion : in std_logic;
        switches_limite    : in std_logic_vector(5 downto 0);
        uni, dec, cen, cic : out integer range 0 to 9
    );
end entity;

architecture cerebro of nucleo_contadores is
    signal cuenta_actual : unsigned(9 downto 0);
    signal cuenta_ciclos : integer range 0 to 9;
    signal limite_real   : unsigned(9 downto 0);
begin

    -- Conexión concurrente: pasamos el switch de 6 bits al ancho interno de 10 bits
    limite_real <= resize(unsigned(switches_limite), 10);

    process (clk, resed)
    begin
        if resed = '1' then
            if sw_direccion = '1' then
                cuenta_actual <= (others => '0');   -- ascendente arranca en 0
            else
                cuenta_actual <= limite_real;        -- descendente arranca en el límite
            end if;
            cuenta_ciclos <= 0;

        elsif clk'event and clk = '1' then
            if inicio = '1' then

                if sw_direccion = '1' then
                    -- ===== MODO ASCENDENTE =====
                    if cuenta_actual = limite_real then
                        cuenta_actual <= (others => '0');
                        if cuenta_ciclos = 9 then
                            cuenta_ciclos <= 0;
                        else
                            cuenta_ciclos <= cuenta_ciclos + 1;
                        end if;
                    else
                        cuenta_actual <= cuenta_actual + 1;
                    end if;

                else
                    -- ===== MODO DESCENDENTE =====
                    if cuenta_actual = 0 then
                        cuenta_actual <= limite_real;
                        if cuenta_ciclos = 9 then
                            cuenta_ciclos <= 0;
                        else
                            cuenta_ciclos <= cuenta_ciclos + 1;
                        end if;
                    else
                        cuenta_actual <= cuenta_actual - 1;
                    end if;

                end if;

            end if;
        end if;
    end process;

    -- Separación matemática de los dígitos para los displays
    uni <= to_integer(cuenta_actual) mod 10;
    dec <= (to_integer(cuenta_actual) / 10) mod 10;
    cen <= (to_integer(cuenta_actual) / 100) mod 10;
    cic <= cuenta_ciclos;

end architecture;