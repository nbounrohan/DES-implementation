library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity s4_box is
    port(
        data_in: in std_logic_vector(0 to 5);
        data_out: out std_logic_vector(0 to 3)
    );
end s4_box;

architecture behavior of s4_box is

    type s4box is array(0 to 3, 0 to 15) of integer range 0 to 15;
    constant box: s4box := (
        (7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15),
        (13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9),
        (10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4),
        (3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14)
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
