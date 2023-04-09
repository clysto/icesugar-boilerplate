module top (
    output reg RF,
    output reg TEST
);
    // clk 6MHz
    wire clk;
    SB_HFOSC #(
        .CLKHF_DIV("0b11")
    ) u_hfosc (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF  (clk)
    );

    reg [ 7:0] counter0 = 0;
    reg [31:0] counter1 = 0;

    assign TEST = clk;

    always @(posedge clk) begin
        // 产生一个500KHz的信号
        if (counter1 >= 1000) begin
            counter1 <= 0;
        end else begin
            counter1 <= counter1 + 1;
        end

        if (counter0 >= 23) begin
            counter0 <= 0;
        end else begin
            counter0 <= counter0 + 1;
        end

        if (counter0 >= 11) begin
            if (counter1 >= 500) begin
                RF <= 1;
            end else begin
                RF <= 0;
            end
        end else begin
            RF <= 0;
        end
    end
endmodule
