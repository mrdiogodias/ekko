`timescale 1 ns / 1 ps

`include "axi_bus.sv"

module i2c_master_axi_slave_v1_0 #(
    parameter integer C_S00_AXI_DATA_WIDTH	= 32,
    parameter integer C_S00_AXI_ADDR_WIDTH	= 4
)(
    input  wire clk,
    input  wire rst,
    inout  wire sda,
    output wire scl,
    output wire i2c_irq,
    AXI_BUS.Slave i2c_slave
);

// Instantiation of Axi Bus Interface S00_AXI
i2c_master_axi_slave_v1_0_S00_AXI #( 
    .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
) i2c_master_axi_inst (
    .S_AXI_ACLK(clk),
    .S_AXI_ARESETN(rst),
    .S_AXI_AWADDR(i2c_slave.aw_addr),
    .S_AXI_AWPROT(i2c_slave.aw_prot),
    .S_AXI_AWVALID(i2c_slave.aw_valid),
    .S_AXI_AWREADY(i2c_slave.aw_ready),
    .S_AXI_WDATA(i2c_slave.w_data),
    .S_AXI_WSTRB(i2c_slave.w_strb),
    .S_AXI_WVALID(i2c_slave.w_valid),
    .S_AXI_WREADY(i2c_slave.w_ready),
    .S_AXI_BRESP(i2c_slave.b_resp),
    .S_AXI_BVALID(i2c_slave.b_valid),
    .S_AXI_BREADY(i2c_slave.b_ready),
    .S_AXI_ARADDR(i2c_slave.ar_addr),
    .S_AXI_ARPROT(i2c_slave.ar_prot),
    .S_AXI_ARVALID(i2c_slave.ar_valid),
    .S_AXI_ARREADY(i2c_slave.ar_ready),
    .S_AXI_RDATA(i2c_slave.r_data),
    .S_AXI_RRESP(i2c_slave.r_resp),
    .S_AXI_RVALID(i2c_slave.r_valid),
    .S_AXI_RREADY(i2c_slave.r_ready),
    .sda(sda),
    .scl(scl),
    .i2c_irq(i2c_irq)
);
endmodule
