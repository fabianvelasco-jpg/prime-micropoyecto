library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.paquete_herramientas.all; -- Importamos las herramientas- del paquete que teniamos antes, o sea ese de paquete que tienes de archivo

entity sistema_maestro is
    port (
        reloj_50Mhz : in std_logic;
        boton_resed : in std_logic;
        sw_inicio   : in std_logic;
		  sw_direccion : in std_logic;
        sw_limite   : in std_logic_vector(5 downto 0);
        disp_uni, disp_dec, disp_cen, disp_ciclos : out std_logic_vector(6 downto 0) -- Salidas a los 4 displays físicos
    );
end entity;

architecture estructural of sistema_maestro is
    -- Cables internos para conectar los bloques (Signals)
    signal cable_reloj_1hz : std_logic;
    signal num_u, num_d, num_c, num_ciclos : integer range 0 to 5;

begin
    -- 1. Instanciamos el divisor
    U1_Divisor : divisor_1hz port map (
        clk_50Mhz => reloj_50Mhz, 
        resed     => boton_resed, 
        clk_1Hz   => cable_reloj_1hz
    );

    -- 2. Instanciamos el cerebro contador
    U2_Nucleo : nucleo_contadores port map (
        clk             => cable_reloj_1hz,
        resed           => boton_resed,
		  sw_direccion    => sw_direccion,
        inicio          => sw_inicio,
        switches_limite => sw_limite,
        uni => num_u, dec => num_d, cen => num_c, cic => num_ciclos
    );

    -- 3. Uso concurrente de la FUNCIÓN del paquete para los 4 displays
    disp_uni    <= decodificar_7seg(num_u);
    disp_dec    <= decodificar_7seg(num_d);
    disp_cen    <= decodificar_7seg(num_c);
    disp_ciclos <= decodificar_7seg(num_ciclos);

end architecture;
