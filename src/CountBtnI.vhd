----------------------------------------------------------------------------------
-- Company: 		 AtomSoftTech
-- Engineer: 		 Jason Lopez
-- 
-- Create Date:    21:13:39 08/23/2011 
-- Design Name:    CountBtn
-- Tool versions:  ISE Webpack 13.2
-- Description: 	 Count Up and show on PORT C
--
-- Dependencies:   CountBtn.ucf
--
-- Revision 0.01 - File Created
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CountBtnI is
    Port ( clk : in  STD_LOGIC; -- Our Input Clock
			  rst : in  STD_LOGIC; -- Our Input Reset
			  btnU : in STD_LOGIC;  -- Our Input Button
			  btnD : in STD_LOGIC;  -- Our Input Button
           DB : out  STD_LOGIC_VECTOR (15 downto 0) -- Our Output LEDs
			 );
end CountBtnI;

architecture Behavioral of CountBtnI is
					  -- Make ready after time (debounce)
	COMPONENT debounce
	PORT(
		clock : IN std_logic;
		button : IN std_logic;          
		state : OUT std_logic
		);
	END COMPONENT;
	
	signal btnDown : STD_LOGIC;
	signal btnUp : STD_LOGIC;
	signal state : STD_LOGIC_VECTOR (15 downto 0);
	
begin
	UpBtn: debounce PORT MAP(
		clock => clk,
		button => btnU,
		state => btnUp
	);
	DownBtn: debounce PORT MAP(
		clock => clk,
		button => btnD,
		state => btnDown
	);
	
process (clk,rst,state) is begin  -- Process these signals
   if rst = '0' then					 	 -- If Reset is LOW then RESET our variable, state and LEDs to 0
		state <= (others => '0');
   elsif (rising_edge(clk)) then	 	 -- Wait for the clock to be high (rising edge)
		if(btnUp = '1') then
			state <= state + 1;
		elsif(btnDown = '1') then
			state <= state - 1;
  		end if;				
   end if;
	
	DB <= state;						 	 -- Output the current state without regard to edge of clock
end process;

end Behavioral;

