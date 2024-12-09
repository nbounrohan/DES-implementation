library ieee;
use ieee.std_logic_1164.all;

entity f is
    port(
        data_in  : in  std_logic_vector(0 to 31);
        key      : in  std_logic_vector(0 to 47);
        data_out : out std_logic_vector(0 to 31)
    );
end f;

architecture behavior of f is

    -- Component Declarations
    component expand
        port(
            data_in  : in  std_logic_vector(0 to 31);
            data_out : out std_logic_vector(0 to 47)
        );
    end component;

    component xor_48_bits
        port(
            data_in  : in  std_logic_vector(0 to 47);
            key      : in  std_logic_vector(0 to 47);
            data_out : out std_logic_vector(0 to 47)
        );
    end component;

    component s_box
        port(
            data_in  : in  std_logic_vector(0 to 47);
            data_out : out std_logic_vector(0 to 31)
        );
    end component;

    component permutation_p
        port(
            data_in  : in  std_logic_vector(0 to 31);
            data_out : out std_logic_vector(0 to 31)
        );
    end component;

    -- Internal Signals
    signal expanded_data   : std_logic_vector(0 to 47);
    signal xored_data_key  : std_logic_vector(0 to 47);
    signal s_boxed_data    : std_logic_vector(0 to 31);

begin

    -- Expand Component
    c1: expand
        port map(
            data_in  => data_in,
            data_out => expanded_data
        );

    -- XOR Component
    c2: xor_48_bits
        port map(
            data_in  => expanded_data,
            key      => key,
            data_out => xored_data_key
        );

    -- S-Box Component
    c3: s_box
        port map(
            data_in  => xored_data_key,
            data_out => s_boxed_data
        );

    -- Permutation P Component
    c4: permutation_p
        port map(
            data_in  => s_boxed_data,
            data_out => data_out
        );

end behavior;
