library ieee;
use ieee.std_logic_1164.all;

entity subkey_production is
   generic(
    shifting_parameter: in std_logic_vector(0 to 1) := "01"  -- Default value "01"
);

    port(   
        left_key_in: in std_logic_vector(0 to 27);
        right_key_in: in std_logic_vector(0 to 27);

        subkey: out std_logic_vector(0 to 47);
        left_key_out: out std_logic_vector(0 to 27);
        right_key_out: out std_logic_vector(0 to 27)
    );
end subkey_production;

architecture behavior of subkey_production is

    component left_shift_by_1
        port(
            data_in: in std_logic_vector(0 to 27);
            data_out: out std_logic_vector(0 to 27)
        );
    end component;

    component left_shift_by_2
        port(
            data_in: in std_logic_vector(0 to 27);
            data_out: out std_logic_vector(0 to 27)
        );
    end component;

    component key_permutation_2 is
        port(
            left_half: in std_logic_vector(0 to 27);
            right_half: in std_logic_vector(0 to 27);
            permuted_key: out std_logic_vector(0 to 47)
        );
    end component;

    signal left_half_shifted: std_logic_vector(0 to 27);
    signal right_half_shifted: std_logic_vector(0 to 27);

begin

    -- Apply the shift based on shifting_parameter
    shift_by_1: if (shifting_parameter = "01") generate
        s11: left_shift_by_1 port map(
            data_in => left_key_in,
            data_out => left_half_shifted
        );

        s12: left_shift_by_1 port map(
            data_in => right_key_in,
            data_out => right_half_shifted
        );
    end generate shift_by_1;

    shift_by_2: if (shifting_parameter = "10") generate
        s21: left_shift_by_2 port map(
            data_in => left_key_in,
            data_out => left_half_shifted
        );

        s22: left_shift_by_2 port map(
            data_in => right_key_in,
            data_out => right_half_shifted
        );
    end generate shift_by_2;

    -- Error case if invalid shifting parameter is used
    error_case: if (shifting_parameter = "00" or shifting_parameter = "11") generate
        assert false report "Error selecting valid shift amount in subkey generation";
    end generate error_case;

    -- Key permutation step to generate the subkey
    s3: key_permutation_2 port map(
        left_half => left_half_shifted,
        right_half => right_half_shifted,
        permuted_key => subkey
    );

    -- Outputs after shifting
    left_key_out <= left_half_shifted;
    right_key_out <= right_half_shifted;

end behavior;
