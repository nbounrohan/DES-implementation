library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity s7_box is
    port(
        data_in: in std_logic_vector(0 to 5);
        data_out: out std_logic_vector(0 to 3)
    );
end s7_box;

architecture behavior of s7_box is

    type s7box is array(0 to 3, 0 to 15) of integer range 0 to 15;
    constant box: s7box := (
        (4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1),
        (13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6),
        (1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2),
        (6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12)
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
