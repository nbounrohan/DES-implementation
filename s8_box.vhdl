library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity s8_box is
    port(
        data_in: in std_logic_vector(0 to 5);
        data_out: out std_logic_vector(0 to 3)
    );
end s8_box;

architecture behavior of s8_box is

    type s8box is array(0 to 3, 0 to 15) of integer range 0 to 15;
    constant box: s8box := (
        (13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7),
        (1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2),
        (7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8),
        (2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11)
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
