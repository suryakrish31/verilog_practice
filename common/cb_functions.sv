// -----------------------------------------------------------------------------
// Project      : Verilog Practice
// Date         : 2026-09-15
// Designer     : Surya Rangavajhala
// Module Name  : NA
// Description  : Various Commonly used functions
// Revision     : 1.0
// Notes        : Add design notes here
// -----------------------------------------------------------------------------

function automatic int clog2(input int value);
    int result;
    begin
        result = 0;
        while (value > 1) begin
            value = value >> 1;
            result++;
        end
        return result;
    end
endfunction
