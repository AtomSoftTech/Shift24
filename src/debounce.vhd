----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:37:56 08/24/2011 
-- Design Name: 
-- Module Name:    debounce - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use UNISIM.VComponents.all;

entity debounce is
    Port ( clock : in  STD_LOGIC;
			  button : in  STD_LOGIC;
           state : out  STD_LOGIC);
end debounce;

architecture Behavioral of debounce is

	signal count : STD_LOGIC_VECTOR (24 downto 0);
	signal btn : std_logic := '0';
begin

process (clock,button) is begin  -- Process these signals
	
   if (rising_edge(clock)) then	 	 -- Wait for the clock to be high (rising edge)
		if(button = '1') then
			btn <= '1';
		end if;
		
      if(btn = '1') then	 			 -- If we are not ready then debounce. This happens after a button is pressed.
			count <= count + 1;			 -- Add 1 to our count variable
			if(count = 6400000) then 	 -- 200ms delay  (1s /32MHz = 31.25ns) (200ms / 31.25ns = 6400000 )
				state <= '1';
				count <= (others => '0');
				btn <= '0';
			end if;
		else
			state <= '0';
  		end if;				
   end if;
end process;
	

end Behavioral;

