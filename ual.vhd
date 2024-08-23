library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is 
port(
op: in std_logic_vector (3 downto 0);
i1: in std_logic_vector (15 downto 0);
i2: in std_logic_vector (15 downto 0);
o: out std_logic_vector (15 downto 0);
st: out std_logic_vector (3 downto 0));
end alu;

architecture arch of alu is
signal result: std_logic_vector(16 downto 0);
signal carry:std_logic:='0';
begin
  process(i1,i2,result)
 begin
  case (op) is
  when "0000" => result <= '0' & (i1 and i2);
  when "0001" => result <= '0' & (i1 or i2);
  when "0010" => result <= '0' & (i1 xor i2);
  when "0011" => result <= '0' & not (i2);
  when "0100" => 
       result <= std_logic_vector(signed('0' & i1) + signed ('0' & i2));
       if result(16)='1' then
        carry<='1';
       else 
        carry<='0';
       end if;
  when "0101" => 
       result <= std_logic_vector(signed('0' & i1) - signed ('0' & i2)); 
       if result(16)='1' then
        carry<='1';
       else 
        carry<='0';
       end if;

    
  when "0110" => result <= std_logic_vector(shift_left( unsigned('0' & i1), to_integer (signed ('0' & i2)))); 

 when "0111" => result <= std_logic_vector(shift_right( unsigned('0' & i1), to_integer (signed ('0' & i2))));



  when "1010"| "1000" => result <= '0' & i2;
  when "1011"|"1001" => result <= '0' & i1;
  when "1100" => result <= std_logic_vector(signed('0' & i1) +signed('0' & i2)) ;
  when "1101" => result <= std_logic_vector(signed('0' & i1) -signed('0' & i2)) ;
  when "1110"|"1111" => result <=  i2;
  

  when others => null;
  end case;
  
    
  end process; 
 carry<='1' when (result(16)='1') else '0';   
 o<=result(15 downto 0);   
 st(3)<= '1' when result = (16 downto 0 => '0') else '0';   --zero flag if result=0 donc 1 sinon 0
 st(2)<= result(15);   --si neg 1 si pos 0
 st(1)<= carry;--carry value
 st(0) <= '1' when (((signed(i1) < 0) and (signed(result(15 downto 0)) > 0)) or
                   ((signed(i1) > 0) and (signed(result(15 downto 0)) < 0)) or
                   ((signed(result(15 downto 0)) > 0) and (signed(i1) < 0) and (signed(i2) < 0)) or
                   ((signed(result(15 downto 0)) < 0) and (signed(i1) > 0) and (signed(i2) > 0)) or
                   ((signed(result(15 downto 0)) > 0) and (signed(i1) < 0) and (signed(i2) > 0)) or
                   ((signed(result(15 downto 0)) < 0) and (signed(i1) > 0) and (signed(i2) < 0)))
         else '0';


end arch;  