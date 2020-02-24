--------------------------------------------
-- Module Name: top_bcd_display
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity top_bcd_display is
port (
		io_swt_a : inout std_logic_vector(7 downto 0);
        clk_in : in std_logic;
        led : out std_logic_vector(7 downto 0);
        seg_led_out : out std_logic_vector(6 downto 0);
        sed_led1_en : out std_logic
	);
end top_bcd_display;

architecture behavior of top_bcd_display is

    -- internal net for outputs from pulldown module
    signal pd_swa_out : std_logic_vector(7 downto 0);

    signal bin_num_input : std_logic_vector(3 downto 0);

    -- pull-down component
	component pulldown
		port (
        	in_swt : inout std_logic_vector(7 downto 0);
        	clk : in std_logic;
			swt_state : out std_logic_vector(7 downto 0)
		);
    end component;
    
    -- 7-segment display component
    component seven_seg_display
        port (
            bin_input : inout std_logic_vector(3 downto 0);
		    segment_output : out std_logic_vector(6 downto 0)
        );
    end component;

    begin
        -- enable led1 segment display
        sed_led1_en <= '0';

        -- wire DIP switches with the correct binary position into the 7-seg display
        bin_num_input(0) <= pd_swa_out(3); -- DIP1 (MSB)
        bin_num_input(1) <= pd_swa_out(2);
        bin_num_input(2) <= pd_swa_out(1);
        bin_num_input(3) <= pd_swa_out(0); -- DIP4 (LSB)

        -- wire pulldown component (SWTA switches)
        swta_pd: pulldown port map(io_swt_a, clk_in, pd_swa_out);
        
        -- wire 7-segment display DIP switch A -> input, LED1 segment display -> output
        led1_disp: seven_seg_display port map(
            bin_input => bin_num_input(3 downto 0),
            segment_output => seg_led_out
        );

end behavior;
		

