`timescale 1 ns / 1 ps

`include "axi_bus.sv"

module timer_axi_slave_v1_0 #(
    parameter integer C_S00_AXI_DATA_WIDTH	= 32,
    parameter integer C_S00_AXI_ADDR_WIDTH	= 5
)(
    input  wire   clk,
    input  wire   rst,
    output wire   timer_irq,
    AXI_BUS.Slave timer_slave
);

// Instantiation of Axi Bus Interface S00_AXI
timer_axi_slave_v1_0_S00_AXI #( 
    .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
) timer_axi_inst (
    .S_AXI_ACLK(clk),
    .S_AXI_ARESETN(rst),
    .S_AXI_AWADDR(timer_slave.aw_addr),
    .S_AXI_AWPROT(timer_slave.aw_prot),
    .S_AXI_AWVALID(timer_slave.aw_valid),
    .S_AXI_AWREADY(timer_slave.aw_ready),
    .S_AXI_WDATA(timer_slave.w_data),
    .S_AXI_WSTRB(timer_slave.w_strb),
    .S_AXI_WVALID(timer_slave.w_valid),
    .S_AXI_WREADY(timer_slave.w_ready),
    .S_AXI_BRESP(timer_slave.b_resp),
    .S_AXI_BVALID(timer_slave.b_valid),
    .S_AXI_BREADY(timer_slave.b_ready),
    .S_AXI_ARADDR(timer_slave.ar_addr),
    .S_AXI_ARPROT(timer_slave.ar_prot),
    .S_AXI_ARVALID(timer_slave.ar_valid),
    .S_AXI_ARREADY(timer_slave.ar_ready),
    .S_AXI_RDATA(timer_slave.r_data),
    .S_AXI_RRESP(timer_slave.r_resp),
    .S_AXI_RVALID(timer_slave.r_valid),
    .S_AXI_RREADY(timer_slave.r_ready),
    .timer_irq(timer_irq)
);
endmodule