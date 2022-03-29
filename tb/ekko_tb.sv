`timescale 1ns / 1ps



module ekko_tb;

reg clk = 1'b0;
reg rst = 1'b0;
wire [3:0]leds;
wire tdo;
wire sda;
wire scl;

initial begin 
    #20
    rst = 1;
end

ekko_top uut(
    .IO_CLK(clk),
    .IO_RST_N(rst),
    .LED(leds),
    .JTAG_TCK(1'b0),
    .JTAG_TMS(1'b0),
    .JTAG_TRST_N(1'b1),
    .JTAG_TDI(1'b0),
    .JTAG_TDO(tdo),
    .JTAG_RESET_N(1'b1),
    .SCL(scl),
    .SDA(sda)
);

always #10 clk = ~clk;

endmodule
