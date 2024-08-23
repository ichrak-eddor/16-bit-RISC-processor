library ieee;
use ieee.std_logic_1164.all;

entity mux1 is
  port ( sel : in  std_logic;
         in0  : in  std_logic_vector(15 downto 0);
         in1 : in  std_logic_vector(15 downto 0);
output : out  std_logic_vector(15 downto 0));
end entity;



architecture arch of mux1 is 
begin 

process(in0,in1,sel)

begin

if (sel='0') then
output<= in0;

elsif (sel='1') then
output<= in1; 


end if; 
end process;
end architecture; 









------------------

library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
  port ( sel_out : in  std_logic_vector(1 downto 0);
         in0  : in  std_logic_vector(15 downto 0);
         in1 : in  std_logic_vector(15 downto 0);
         in2 : in  std_logic_vector(15 downto 0);
output : out  std_logic_vector(15 downto 0));
end entity;



architecture arch of mux2 is 
begin 

process(in0,in1,in2,sel_out)

begin
    case sel_out is
      when "00" =>
        output <= in1;
      when "10" =>
        output <= in0;
      when "01" =>
        output <= in2;
      when others =>
        output <= (others => 'X'); -- handle undefined case
    end case;
end process;


end architecture; 


