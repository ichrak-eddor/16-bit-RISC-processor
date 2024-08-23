library ieee;
use ieee.std_logic_1164.all;

entity bascule is
  port ( 
    clk   : in  std_logic;
    rst   : in  std_logic;
    D     : in  std_logic;
    Q     : out std_logic
  );
end entity;

architecture arch of bascule is
  signal Q_internal : std_logic;
begin
  process(clk, rst)
  begin
    if rst = '1' then
      Q_internal <= '0'; 
    elsif rising_edge(clk) then
      Q_internal <= D;    
    end if;
  end process;

  Q <= Q_internal;
end architecture;

