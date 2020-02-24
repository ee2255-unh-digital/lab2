--------------------------------------------
-- Module Name: top_bcd2_display
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity top_bcd2_display is
port (
		io_swt_a : inout std_logic_vector(7 downto 0);
        clk_in : in std_logic;
        led : out std_logic_vector(7 downto 0);
        seg_led_out : out std_logic_vector(6 downto 0);
        sed_led1_en : out std_logic
	);
end top_bcd2_display;

architecture behavior of top_bcd2_display is

    -- internal net for outputs from pulldown module
    signal pd_swa_out : std_logic_vector(7 downto 0);

    -- pull-down component
	component pulldown
		port (
        	in_swt : inout std_logic_vector(7 downto 0);
        	clk : in std_logic;
			swt_state : out std_logic_vector(7 downto 0)
		);
    end component;
    

    begin
        -- wire pulldown component (SWTA switches)
        swta_pd: pulldown port map(io_swt_a, clk_in, pd_swa_out);

end behavior;
		

