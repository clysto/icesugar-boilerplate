`timescale 1ns / 1ps
module SB_HFOSC #(
    parameter CLKHF_DIV = "0b00"
) (
    input CLKHFPU,  // Power up
    input CLKHFEN,  // Output enable
    output reg CLKHF = 1'b0  // Output
);

    reg clk_48mhz = 0;
    reg [1:0] cnt = 2'b00;  // 2位计数器
    reg [1:0] div = 2'b00;  // 2位分频器

    always @(posedge clk_48mhz or posedge clk_48mhz) begin
        if (CLKHFPU && CLKHFEN) begin // 只有在CLKHFPU和CLKHFEN都为高电平时，才会生成输出信号CLKHF
            cnt <= cnt + 1;
            if (cnt == div) begin
                CLKHF <= ~CLKHF;
                cnt   <= 2'b00;
            end
        end else begin // 在CLKHFPU或CLKHFEN为低电平时，输出信号CLKHF被禁用并且被保持为低电平
            cnt   <= 2'b00;
            CLKHF <= 1'b0;
        end
    end

    // 分频器
    initial begin
        case (CLKHF_DIV)
            "0b00":  div = 2'b00;  // 不分频
            "0b01":  div = 2'b01;  // 2分频
            "0b01":  div = 2'b10;  // 4分频
            "0b11":  div = 2'b11;  // 8分频
            default: div = 2'b00;  // 默认为不分频
        endcase
    end

    // 48 MHz的时钟延时实现
    always #10.417 clk_48mhz <= ~clk_48mhz;
endmodule
