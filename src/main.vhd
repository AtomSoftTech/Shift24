----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:25:42 08/25/2011 
-- Design Name: 
-- Module Name:    main - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity shift24 is
    Port ( Clock : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           SDI : in  STD_LOGIC;
           PDO : out  STD_LOGIC_VECTOR (23 downto 0);
           LAT : in  STD_LOGIC); 
end shift24;

architecture Behavioral of shift24 is
	signal PDO_temp : STD_LOGIC_VECTOR (23 downto 0);
begin

	process(Clock,Reset,SDI,LAT,PDO_temp)
	begin
		if(Reset = '1')then
			PDO_temp <= (others => '0');
		elsif(rising_edge(Clock))then
			PDO_temp <= PDO_temp(22 downto 0) & SDI;
		end if;
		
		if(LAT = '1')then
			PDO <= PDO_temp;
		end if;
	end process;

end Behavioral;

