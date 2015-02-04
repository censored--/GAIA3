library IEEE;
use IEEE.std_logic_1164.all;

library UNISIM;
use UNISIM.VComponents.all;

use work.types.all;

entity top is

  port (
    MCLK1  : in    std_logic;
    XRST   : in    std_logic;
    RS_TX  : out   std_logic;
    RS_RX  : in    std_logic;
    ZD     : inout std_logic_vector(31 downto 0);
    ZDP    : inout std_logic_vector(3 downto 0);
    ZA     : out   std_logic_vector(19 downto 0);
    XE1    : out   std_logic;
    E2A    : out   std_logic;
    XE3    : out   std_logic;
    XZBE   : out   std_logic_vector(3 downto 0);
    XGA    : out   std_logic;
    XWA    : out   std_logic;
    XZCKE  : out   std_logic;
    ZCLKMA : out   std_logic_vector(1 downto 0);
    ADVA   : out   std_logic;
    XFT    : out   std_logic;
    XLBO   : out   std_logic;
    ZZA    : out   std_logic);

end entity top;

architecture Behavioral of top is

  signal iclk, clk : std_logic := '0';

  signal rst : std_logic;

  signal icache_in  : icache_in_type;
  signal icache_out : icache_out_type;
  signal cpu_out    : cpu_out_type;
  signal cache_out  : cache_out_type;
  signal mem_out    : mem_out_type;
  signal mem_in     : mem_in_type;

begin   -- architecture Behavioral

  ib: IBUFG port map (
    i => MCLK1,
    o => iclk);

  bg: BUFG port map (
    i => iclk,
    o => clk);

  rst <= not XRST;

  cpu_1: entity work.cpu
    port map (
      clk        => clk,
      rst        => rst,
      icache_out => icache_out,
      icache_in  => icache_in,
      cache_out  => cache_out,
      cpu_out    => cpu_out);

  cache_1: entity work.cache
    port map (
      clk       => clk,
      rst       => rst,
      cpu_out   => cpu_out,
      cache_out => cache_out,
      mem_out   => mem_out,
      mem_in    => mem_in);

  icache_1: entity work.icache
    port map (
      clk        => clk,
      icache_in  => icache_in,
      icache_out => icache_out);

  mem_1: entity work.mem
    port map (
      clk     => clk,
      mem_in  => mem_in,
      mem_out => mem_out,
      ZD      => ZD,
      ZDP     => ZDP,
      ZA      => ZA,
      XWA     => XWA);

  RS_TX <= '1';

  XE1       <= '0';
  E2A       <= '1';
  XE3       <= '0';
  XZBE      <= "0000";
  XGA       <= '0';
  XZCKE     <= '0';
  ZCLKMA(0) <= clk;
  ZCLKMA(1) <= clk;
  ADVA      <= '0';
  XFT       <= not '0';
  XLBO      <= '1';
  ZZA       <= '0';

end architecture Behavioral;
