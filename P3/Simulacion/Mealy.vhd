----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:43:44 09/06/2019 
-- Design Name: 
-- Module Name:    Mealy - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mealy is
    Port ( ENTRADA : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           MCLK : in  STD_LOGIC;
           SALIDA : out  STD_LOGIC);
end Mealy;

architecture RTL of Mealy is
	type estados is (S1,S0,S2,S3);
	signal edo_pres,edo_sig: estados;
begin
--Proceso asignar estados
process(MCLK,RESET)
	begin
		if(RESET='1') then
			edo_pres<=S0;
		elsif(rising_edge(MCLK)) then 
			edo_pres<=edo_sig;
		end if;
end process;
--Proceso manejo esntradas/salidas
process(edo_pres,ENTRADA)
	begin
		case edo_pres is
			when S0=>	
				if (ENTRADA = '0') then 
					SALIDA <='0';
					edo_sig<=S1;
				else
					SALIDA <='1';
					edo_sig <=S2;
				end if;			
			when S1=>	
				if (ENTRADA = '1') then 
					SALIDA <='0';
					edo_sig<=S1;
				else
					SALIDA <='0';
					edo_sig <=S3;
				end if;
			when S2=>	
				if (ENTRADA = '1') then 
					SALIDA <='0';
					edo_sig<=S3;
				else
					SALIDA <='1';
					edo_sig <=S2;
				end if;
			when S3=>	
				if (ENTRADA = '1') then 
					SALIDA <='1';
					edo_sig<=S0;
				else
					SALIDA <='1';
					edo_sig <=S3;
				end if;
			end case;
end process;
end RTL;