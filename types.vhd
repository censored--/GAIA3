library IEEE;
use IEEE.std_logic_1164.all;

package types is

  -- cache

  type cpu_out_type is record
    we   : std_logic;
    re   : std_logic;
    val  : std_logic_vector(31 downto 0);
    addr : std_logic_vector(31 downto 0);
  end record;

  type cache_out_type is record
    stall : std_logic;
    rx : std_logic_vector(31 downto 0);
  end record;

  -- icache (to be removed)

  type icache_out_type is record
    rx : std_logic_vector(31 downto 0);
  end record;

  type icache_in_type is record
    addr : std_logic_vector(31 downto 0);
  end record;

  -- sram

  type sram_out_type is record
    rx : std_logic_vector(31 downto 0);
  end record;

  type sram_in_type is record
    addr : std_logic_vector(31 downto 0);
    we : std_logic;
    re : std_logic;
    tx : std_logic_vector(31 downto 0);
  end record;

  component cpu is
    port (
      clk        : in  std_logic;
      rst        : in  std_logic;
      icache_out : in  icache_out_type;
      icache_in  : out icache_in_type;
      cache_out  : in  cache_out_type;
      cpu_out    : out cpu_out_type);
  end component;

  component cache is
    port (
      clk       : in  std_logic;
      rst       : in  std_logic;
      cpu_out   : in  cpu_out_type;
      cache_out : out cache_out_type;
      sram_out   : in  sram_out_type;
      sram_in    : out sram_in_type);
  end component;

  component icache is
    port (
      clk        : in  std_logic;
      icache_in  : in  icache_in_type;
      icache_out : out icache_out_type);
  end component;

  component sram is
    port (
      clk     : in    std_logic;
      sram_in  : in    sram_in_type;
      sram_out : out   sram_out_type;
      ZD      : inout std_logic_vector(31 downto 0);
      ZDP     : inout std_logic_vector(3 downto 0);
      ZA      : out   std_logic_vector(19 downto 0);
      XWA     : out   std_logic);
  end component;

end package;
