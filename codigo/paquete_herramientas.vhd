library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package paquete_herramientas is
    -- 1. Declaración de los bloques que usaremos
    component divisor_1hz is
        port (clk_50Mhz, resed : in std_logic; clk_1Hz : out std_logic);
    end component;

    component nucleo_contadores is
        port (
            clk, resed, inicio, sw_direccion : in std_logic;
            switches_limite    : in std_logic_vector(5 downto 0);
            uni, dec, cen, cic : out integer range 0 to 9
        );
    end component;

    -- 2. Declaración de la FUNCIÓN decodificadora
    function decodificar_7seg (digito : integer) return std_logic_vector;
end paquete_herramientas;

-- Implementación de la función (El "Procedimiento" interno)
package body paquete_herramientas is
    function decodificar_7seg (digito : integer) return std_logic_vector is
        variable salida : std_logic_vector(6 downto 0);
    begin
        case digito is
            when 0 => salida := "1000000"; -- Muestra 0
            when 1 => salida := "1111001"; -- Muestra 1
            when 2 => salida := "0100100"; -- Muestra 2
            when 3 => salida := "0110000"; -- Muestra 3
            when 4 => salida := "0011001"; -- Muestra 4
            when 5 => salida := "0010010"; -- Muestra 5
            when 6 => salida := "0000010"; -- Muestra 6
            when 7 => salida := "1111000"; -- Muestra 7
            when 8 => salida := "0000000"; -- Muestra 8
            when 9 => salida := "0010000"; -- Muestra 9
            when others => salida := "1111111"; -- Apagado de seguridad
        end case;
        return salida;
    end function;
end paquete_herramientas;
