`define AXI_ADDR_WIDTH         32
`define AXI_DATA_WIDTH         32
`define AXI_ID_MASTER_WIDTH     2
`define AXI_ID_SLAVE_WIDTH      4
`define AXI_USER_WIDTH          1

module ekko_top(
    input               IO_CLK,
    input               IO_RST_N,
    
    output [3:0]        LED,
    
    input               JTAG_TCK,
    input               JTAG_TMS,
    input               JTAG_TRST_N,
    input               JTAG_TDI,
    output              JTAG_TDO,
    input               JTAG_RESET_N,
    
    output              SCL,
    inout               SDA
);

//----------------------------------------------------------------------------//
// Clock and reset generation
//----------------------------------------------------------------------------//
clkgen_xil7series clkgen(
    .IO_CLK(IO_CLK), 
    .IO_RST_N(~IO_RST_N),
    .clk_sys, 
    .rst_sys_n
);

//----------------------------------------------------------------------------//
// AXI Bus
//----------------------------------------------------------------------------//
AXI_BUS #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH     ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH     )
) master();

AXI_BUS #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH     ),
    .AXI_ID_WIDTH   ( `AXI_ID_SLAVE_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH     )
) slaves[2:0]();

//----------------------------------------------------------------------------//
// Core region
//----------------------------------------------------------------------------//
core_region #(
    .AXI_ADDR_WIDTH      ( `AXI_ADDR_WIDTH      ),       
    .AXI_DATA_WIDTH      ( `AXI_DATA_WIDTH      ),    
    .AXI_ID_MASTER_WIDTH ( `AXI_ID_MASTER_WIDTH ),
    .AXI_ID_SLAVE_WIDTH  ( `AXI_ID_SLAVE_WIDTH  ),  
    .AXI_USER_WIDTH      ( `AXI_USER_WIDTH      )    
) core_region_i(
    .clk_sys(clk_sys),
    .rst_sys_n(rst_sys_n),
    .LED(LED),
    .JTAG_TCK(JTAG_TCK),
    .JTAG_TMS(JTAG_TMS),
    .JTAG_TRST_N(JTAG_TRST_N),
    .JTAG_TDI(JTAG_TDI),
    .JTAG_TDO(JTAG_TDO),
    .JTAG_RESET_N(JTAG_RESET_N),
    .core_master(master),
    .timer_irq(timer0_irq)
);

//----------------------------------------------------------------------------//
// Peripherals
//----------------------------------------------------------------------------//

timer_axi_slave_v1_0  #( 
    .C_S00_AXI_DATA_WIDTH(`AXI_DATA_WIDTH )
) timer0(
    .clk(clk_sys),
    .rst(rst_sys_n),
    .timer_irq(timer0_irq),
    .timer_slave(slaves[0])
);

timer_axi_slave_v1_0  #( 
    .C_S00_AXI_DATA_WIDTH(`AXI_DATA_WIDTH )
) timer1(
    .clk(clk_sys),
    .rst(rst_sys_n),
    .timer_irq(),
    .timer_slave(slaves[1])
);

i2c_master_axi_slave_v1_0 #(
     .C_S00_AXI_DATA_WIDTH(`AXI_DATA_WIDTH )
) i2c_master(
    .clk(clk_sys),
    .rst(rst_sys_n),
    .sda(SDA),
    .scl(SCL),
    .i2c_irq(),
    .i2c_slave(slaves[2])
);

//----------------------------------------------------------------------------//
// AXI interconnect
//----------------------------------------------------------------------------//

axil_interconnect_wrap_1x3 #(
    .DATA_WIDTH(`AXI_DATA_WIDTH),
    .ADDR_WIDTH(`AXI_ADDR_WIDTH),
    .M_REGIONS(1),
    .M_BASE_ADDR({32'h22000, 32'h21000, 32'h20000}),
    .M_ADDR_WIDTH({32'd12, 32'd12, 32'd12})
) axi_interconnect (
    .clk(clk_sys),
    .rst(~rst_sys_n),

     /* Master */
    .s00_axil_awaddr(master.aw_addr),
    .s00_axil_awprot(master.aw_prot),
    .s00_axil_awvalid(master.aw_valid),
    .s00_axil_awready(master.aw_ready),
    
    .s00_axil_wdata(master.w_data),
    .s00_axil_wstrb(master.w_strb),
    .s00_axil_wvalid(master.w_valid),
    .s00_axil_wready(master.w_ready),
    
    .s00_axil_bresp(master.b_resp),
    .s00_axil_bvalid(master.b_valid),
    .s00_axil_bready(master.b_ready),
    
    .s00_axil_araddr(master.ar_addr),
    .s00_axil_arprot(master.ar_prot),
    .s00_axil_arvalid(master.ar_valid),
    .s00_axil_arready(master.ar_ready),
    
    .s00_axil_rdata(master.r_data),
    .s00_axil_rresp(master.r_resp),
    .s00_axil_rvalid(master.r_valid),
    .s00_axil_rready(master.r_ready),
    
     /* Slave 0 */
    .m00_axil_awaddr(slaves[0].aw_addr),
    .m00_axil_awprot(slaves[0].aw_prot),
    .m00_axil_awvalid(slaves[0].aw_valid),
    .m00_axil_awready(slaves[0].aw_ready),
    
    .m00_axil_wdata(slaves[0].w_data),
    .m00_axil_wstrb(slaves[0].w_strb),
    .m00_axil_wvalid(slaves[0].w_valid),
    .m00_axil_wready(slaves[0].w_ready),
    
    .m00_axil_bresp(slaves[0].b_resp),
    .m00_axil_bvalid(slaves[0].b_valid),
    .m00_axil_bready(slaves[0].b_ready),
    
    .m00_axil_araddr(slaves[0].ar_addr),
    .m00_axil_arprot(slaves[0].ar_prot),
    .m00_axil_arvalid(slaves[0].ar_valid),
    .m00_axil_arready(slaves[0].ar_ready),
    
    .m00_axil_rdata(slaves[0].r_data),
    .m00_axil_rresp(slaves[0].r_resp),
    .m00_axil_rvalid(slaves[0].r_valid),
    .m00_axil_rready(slaves[0].r_ready),
    
     /* Slave 1 */
    .m01_axil_awaddr(slaves[1].aw_addr),
    .m01_axil_awprot(slaves[1].aw_prot),
    .m01_axil_awvalid(slaves[1].aw_valid),
    .m01_axil_awready(slaves[1].aw_ready),
    
    .m01_axil_wdata(slaves[1].w_data),
    .m01_axil_wstrb(slaves[1].w_strb),
    .m01_axil_wvalid(slaves[1].w_valid),
    .m01_axil_wready(slaves[1].w_ready),
    
    .m01_axil_bresp(slaves[1].b_resp),
    .m01_axil_bvalid(slaves[1].b_valid),
    .m01_axil_bready(slaves[1].b_ready),
    
    .m01_axil_araddr(slaves[1].ar_addr),
    .m01_axil_arprot(slaves[1].ar_prot),
    .m01_axil_arvalid(slaves[1].ar_valid),
    .m01_axil_arready(slaves[1].ar_ready),
    
    .m01_axil_rdata(slaves[1].r_data),
    .m01_axil_rresp(slaves[1].r_resp),
    .m01_axil_rvalid(slaves[1].r_valid),
    .m01_axil_rready(slaves[1].r_ready),
    
    /* Slave 2 */
    .m02_axil_awaddr(slaves[2].aw_addr),
    .m02_axil_awprot(slaves[2].aw_prot),
    .m02_axil_awvalid(slaves[2].aw_valid),
    .m02_axil_awready(slaves[2].aw_ready),
    
    .m02_axil_wdata(slaves[2].w_data),
    .m02_axil_wstrb(slaves[2].w_strb),
    .m02_axil_wvalid(slaves[2].w_valid),
    .m02_axil_wready(slaves[2].w_ready),
    
    .m02_axil_bresp(slaves[2].b_resp),
    .m02_axil_bvalid(slaves[2].b_valid),
    .m02_axil_bready(slaves[2].b_ready),
    
    .m02_axil_araddr(slaves[2].ar_addr),
    .m02_axil_arprot(slaves[2].ar_prot),
    .m02_axil_arvalid(slaves[2].ar_valid),
    .m02_axil_arready(slaves[2].ar_ready),
    
    .m02_axil_rdata(slaves[2].r_data),
    .m02_axil_rresp(slaves[2].r_resp),
    .m02_axil_rvalid(slaves[2].r_valid),
    .m02_axil_rready(slaves[2].r_ready)
);

endmodule
