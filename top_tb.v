`timescale 1ns / 1ps
module top_tb ();
    reg rf;
    reg test;

    top t (
        .RF  (rf),
        .TEST(test)
    );

    initial begin
        #1000000 $finish;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_tb);
    end
endmodule
