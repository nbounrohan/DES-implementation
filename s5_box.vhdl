library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity s5_box is
    port(
        data_in: in std_logic_vector(0 to 5);
        data_out: out std_logic_vector(0 to 3)
    );
end s5_box;

architecture behavior of s5_box is

    type s5box is array(0 to 3, 0 to 15) of integer range 0 to 15;
    constant box: s5box := (
        (2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9),
        (14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6),
        (4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14),
        (11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3)
    );

begin

    process(data_in)
        variable row: std_logic_vector(0 to 1);
        variable column: std_logic_vector(0 to 3);
        variable data_out_decimal: integer range 0 to 15;

    begin
        column := data_in(1 to 4);
        row := data_in(0) & data_in(5);
        data_out_decimal := box(to_integer(unsigned(row)), to_integer(unsigned(column)));
        data_out <= std_logic_vector(to_unsigned(data_out_decimal, data_out'length));

    end process;

end behavior;
