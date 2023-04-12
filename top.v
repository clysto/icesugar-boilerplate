module top (
    output reg PMOD2_0,
    output reg PMOD2_1,
    output reg PMOD2_2,
    output reg PMOD2_3,
    output reg PMOD2_4,
    output reg PMOD2_5,
    output reg PMOD2_6,
    output reg PMOD2_7
);
    reg [7:0] counter0 = 0;
    reg [31:0] counter1 = 0;

    // clk 6MHz
    wire clk;
    SB_HFOSC #(
        .CLKHF_DIV("0b11")
    ) u_hfosc (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF  (clk)
    );

    always @(posedge clk) begin
        if (counter0 >= 23) begin
            counter0 <= 0;
        end else begin
            counter0 <= counter0 + 1;
        end
        if (counter0 >= 11) begin
            PMOD2_4 <= 0;
        end else begin
            PMOD2_4 <= 1;
        end
    end

    always @(posedge clk) begin
        if (counter1 >= 599999) begin
            counter1 <= 0;
        end else begin
            counter1 <= counter1 + 1;
        end
        if (counter1 >= 299999) begin
            PMOD2_0 <= 1;
            PMOD2_5 <= 1;
        end else begin
            PMOD2_0 <= 0;
            PMOD2_5 <= 0;
        end
    end

endmodule
