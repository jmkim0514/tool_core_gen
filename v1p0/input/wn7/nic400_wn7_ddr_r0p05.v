//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// The confidential and proprietary information contained in this file may     
// only be used by a person authorised under and to the extent permitted       
// by a subsisting licensing agreement from ARM Limited.                       
//                                                                             
//            (C) COPYRIGHT 2005-2015 ARM Limited.
//                ALL RIGHTS RESERVED                                          
//                                                                             
// This entire notice must be reproduced on all copies of this file            
// and copies of this file may only be made by a person if such person is      
// permitted to do so under the terms of a subsisting license agreement        
// from ARM Limited.                                                           
//                                                                             
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Top-Level Verilog file is auto-generated by AMBA Designer ADr3p5-01eac0-build-0005

//                                                                             
// Stitcher: generic_stitcher_core v3.1, built on Dec  1 2015
//                                                                             
// Filename: nic400_wn7_ddr_r0p05.v
// Created : Thu Apr 26 11:01:28 2018                            
//                                                                             
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Generated with Validator version1.0


//-----------------------------------------------------------------------------
// Module Declaration nic400_wn7_ddr_r0p05
//-----------------------------------------------------------------------------

module nic400_wn7_ddr_r0p05 (
  
// Instance: u_cd_ddr0, Port: ddr_s0

  awid_ddr_s0,
  awaddr_ddr_s0,
  awlen_ddr_s0,
  awsize_ddr_s0,
  awburst_ddr_s0,
  awlock_ddr_s0,
  awcache_ddr_s0,
  awprot_ddr_s0,
  awvalid_ddr_s0,
  awready_ddr_s0,
  wdata_ddr_s0,
  wstrb_ddr_s0,
  wlast_ddr_s0,
  wvalid_ddr_s0,
  wready_ddr_s0,
  bid_ddr_s0,
  bresp_ddr_s0,
  bvalid_ddr_s0,
  bready_ddr_s0,
  arid_ddr_s0,
  araddr_ddr_s0,
  arlen_ddr_s0,
  arsize_ddr_s0,
  arburst_ddr_s0,
  arlock_ddr_s0,
  arcache_ddr_s0,
  arprot_ddr_s0,
  arvalid_ddr_s0,
  arready_ddr_s0,
  rid_ddr_s0,
  rdata_ddr_s0,
  rresp_ddr_s0,
  rlast_ddr_s0,
  rvalid_ddr_s0,
  rready_ddr_s0,
  
// Instance: u_cd_ddr1, Port: ddr_s1

  awid_ddr_s1,
  awaddr_ddr_s1,
  awlen_ddr_s1,
  awsize_ddr_s1,
  awburst_ddr_s1,
  awlock_ddr_s1,
  awcache_ddr_s1,
  awprot_ddr_s1,
  awvalid_ddr_s1,
  awready_ddr_s1,
  wdata_ddr_s1,
  wstrb_ddr_s1,
  wlast_ddr_s1,
  wvalid_ddr_s1,
  wready_ddr_s1,
  bid_ddr_s1,
  bresp_ddr_s1,
  bvalid_ddr_s1,
  bready_ddr_s1,
  arid_ddr_s1,
  araddr_ddr_s1,
  arlen_ddr_s1,
  arsize_ddr_s1,
  arburst_ddr_s1,
  arlock_ddr_s1,
  arcache_ddr_s1,
  arprot_ddr_s1,
  arvalid_ddr_s1,
  arready_ddr_s1,
  rid_ddr_s1,
  rdata_ddr_s1,
  rresp_ddr_s1,
  rlast_ddr_s1,
  rvalid_ddr_s1,
  rready_ddr_s1,
  
// Instance: u_cd_main, Port: dphy_m0

  awid_dphy_m0,
  awaddr_dphy_m0,
  awlen_dphy_m0,
  awsize_dphy_m0,
  awburst_dphy_m0,
  awlock_dphy_m0,
  awcache_dphy_m0,
  awprot_dphy_m0,
  awvalid_dphy_m0,
  awready_dphy_m0,
  wdata_dphy_m0,
  wstrb_dphy_m0,
  wlast_dphy_m0,
  wvalid_dphy_m0,
  wready_dphy_m0,
  bid_dphy_m0,
  bresp_dphy_m0,
  bvalid_dphy_m0,
  bready_dphy_m0,
  arid_dphy_m0,
  araddr_dphy_m0,
  arlen_dphy_m0,
  arsize_dphy_m0,
  arburst_dphy_m0,
  arlock_dphy_m0,
  arcache_dphy_m0,
  arprot_dphy_m0,
  arvalid_dphy_m0,
  arready_dphy_m0,
  rid_dphy_m0,
  rdata_dphy_m0,
  rresp_dphy_m0,
  rlast_dphy_m0,
  rvalid_dphy_m0,
  rready_dphy_m0,

//  Non-bus signals

  ddr0clk,
  ddr0resetn,
  ddr1clk,
  ddr1resetn,
  mainclk,
  mainresetn

);



//-----------------------------------------------------------------------------
// Port Declarations
//-----------------------------------------------------------------------------


// Instance: u_cd_ddr0, Port: ddr_s0

input  [9:0]  awid_ddr_s0;
input  [31:0] awaddr_ddr_s0;
input  [7:0]  awlen_ddr_s0;
input  [2:0]  awsize_ddr_s0;
input  [1:0]  awburst_ddr_s0;
input         awlock_ddr_s0;
input  [3:0]  awcache_ddr_s0;
input  [2:0]  awprot_ddr_s0;
input         awvalid_ddr_s0;
output        awready_ddr_s0;
input  [127:0] wdata_ddr_s0;
input  [15:0] wstrb_ddr_s0;
input         wlast_ddr_s0;
input         wvalid_ddr_s0;
output        wready_ddr_s0;
output [9:0]  bid_ddr_s0;
output [1:0]  bresp_ddr_s0;
output        bvalid_ddr_s0;
input         bready_ddr_s0;
input  [9:0]  arid_ddr_s0;
input  [31:0] araddr_ddr_s0;
input  [7:0]  arlen_ddr_s0;
input  [2:0]  arsize_ddr_s0;
input  [1:0]  arburst_ddr_s0;
input         arlock_ddr_s0;
input  [3:0]  arcache_ddr_s0;
input  [2:0]  arprot_ddr_s0;
input         arvalid_ddr_s0;
output        arready_ddr_s0;
output [9:0]  rid_ddr_s0;
output [127:0] rdata_ddr_s0;
output [1:0]  rresp_ddr_s0;
output        rlast_ddr_s0;
output        rvalid_ddr_s0;
input         rready_ddr_s0;

// Instance: u_cd_ddr1, Port: ddr_s1

input  [9:0]  awid_ddr_s1;
input  [31:0] awaddr_ddr_s1;
input  [7:0]  awlen_ddr_s1;
input  [2:0]  awsize_ddr_s1;
input  [1:0]  awburst_ddr_s1;
input         awlock_ddr_s1;
input  [3:0]  awcache_ddr_s1;
input  [2:0]  awprot_ddr_s1;
input         awvalid_ddr_s1;
output        awready_ddr_s1;
input  [127:0] wdata_ddr_s1;
input  [15:0] wstrb_ddr_s1;
input         wlast_ddr_s1;
input         wvalid_ddr_s1;
output        wready_ddr_s1;
output [9:0]  bid_ddr_s1;
output [1:0]  bresp_ddr_s1;
output        bvalid_ddr_s1;
input         bready_ddr_s1;
input  [9:0]  arid_ddr_s1;
input  [31:0] araddr_ddr_s1;
input  [7:0]  arlen_ddr_s1;
input  [2:0]  arsize_ddr_s1;
input  [1:0]  arburst_ddr_s1;
input         arlock_ddr_s1;
input  [3:0]  arcache_ddr_s1;
input  [2:0]  arprot_ddr_s1;
input         arvalid_ddr_s1;
output        arready_ddr_s1;
output [9:0]  rid_ddr_s1;
output [127:0] rdata_ddr_s1;
output [1:0]  rresp_ddr_s1;
output        rlast_ddr_s1;
output        rvalid_ddr_s1;
input         rready_ddr_s1;

// Instance: u_cd_main, Port: dphy_m0

output [10:0] awid_dphy_m0;
output [31:0] awaddr_dphy_m0;
output [7:0]  awlen_dphy_m0;
output [2:0]  awsize_dphy_m0;
output [1:0]  awburst_dphy_m0;
output        awlock_dphy_m0;
output [3:0]  awcache_dphy_m0;
output [2:0]  awprot_dphy_m0;
output        awvalid_dphy_m0;
input         awready_dphy_m0;
output [127:0] wdata_dphy_m0;
output [15:0] wstrb_dphy_m0;
output        wlast_dphy_m0;
output        wvalid_dphy_m0;
input         wready_dphy_m0;
input  [10:0] bid_dphy_m0;
input  [1:0]  bresp_dphy_m0;
input         bvalid_dphy_m0;
output        bready_dphy_m0;
output [10:0] arid_dphy_m0;
output [31:0] araddr_dphy_m0;
output [7:0]  arlen_dphy_m0;
output [2:0]  arsize_dphy_m0;
output [1:0]  arburst_dphy_m0;
output        arlock_dphy_m0;
output [3:0]  arcache_dphy_m0;
output [2:0]  arprot_dphy_m0;
output        arvalid_dphy_m0;
input         arready_dphy_m0;
input  [10:0] rid_dphy_m0;
input  [127:0] rdata_dphy_m0;
input  [1:0]  rresp_dphy_m0;
input         rlast_dphy_m0;
input         rvalid_dphy_m0;
output        rready_dphy_m0;

//  Non-bus signals

input         ddr0clk;
input         ddr0resetn;
input         ddr1clk;
input         ddr1resetn;
input         mainclk;
input         mainresetn;



//-----------------------------------------------------------------------------
// Internal Wire Declarations
//-----------------------------------------------------------------------------

wire   [31:0]  araddr_dphy_m0;
wire   [1:0]   arburst_dphy_m0;
wire   [3:0]   arcache_dphy_m0;
wire   [10:0]  arid_dphy_m0;
wire   [7:0]   arlen_dphy_m0;
wire           arlock_dphy_m0;
wire   [2:0]   arprot_dphy_m0;
wire           arready_ddr_s0;
wire           arready_ddr_s1;
wire   [2:0]   arsize_dphy_m0;
wire           arvalid_dphy_m0;
wire   [31:0]  awaddr_dphy_m0;
wire   [1:0]   awburst_dphy_m0;
wire   [3:0]   awcache_dphy_m0;
wire   [10:0]  awid_dphy_m0;
wire   [7:0]   awlen_dphy_m0;
wire           awlock_dphy_m0;
wire   [2:0]   awprot_dphy_m0;
wire           awready_ddr_s0;
wire           awready_ddr_s1;
wire   [2:0]   awsize_dphy_m0;
wire           awvalid_dphy_m0;
wire   [9:0]   bid_ddr_s0;
wire   [9:0]   bid_ddr_s1;
wire           bready_dphy_m0;
wire   [1:0]   bresp_ddr_s0;
wire   [1:0]   bresp_ddr_s1;
wire           bvalid_ddr_s0;
wire           bvalid_ddr_s1;
wire   [127:0] rdata_ddr_s0;
wire   [127:0] rdata_ddr_s1;
wire   [9:0]   rid_ddr_s0;
wire   [9:0]   rid_ddr_s1;
wire           rlast_ddr_s0;
wire           rlast_ddr_s1;
wire           rready_dphy_m0;
wire   [1:0]   rresp_ddr_s0;
wire   [1:0]   rresp_ddr_s1;
wire           rvalid_ddr_s0;
wire           rvalid_ddr_s1;
wire   [127:0] wdata_dphy_m0;
wire           wlast_dphy_m0;
wire           wready_ddr_s0;
wire           wready_ddr_s1;
wire   [15:0]  wstrb_dphy_m0;
wire           wvalid_dphy_m0;
wire   [63:0]  ar_data_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [5:0]   ar_wpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [63:0]  aw_data_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [5:0]   aw_wpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [4:0]   b_rpntr_bin_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [5:0]   b_rpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [4:0]   r_rpntr_bin_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [5:0]   r_rpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [144:0] w_data_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [5:0]   w_wpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_ddr0
wire   [63:0]  ar_data_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [5:0]   ar_wpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [63:0]  aw_data_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [5:0]   aw_wpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [4:0]   b_rpntr_bin_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [5:0]   b_rpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [4:0]   r_rpntr_bin_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [5:0]   r_rpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [144:0] w_data_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [5:0]   w_wpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_ddr1
wire   [4:0]   ar_rpntr_bin_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [4:0]   ar_rpntr_bin_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [5:0]   ar_rpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [5:0]   ar_rpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [4:0]   aw_rpntr_bin_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [4:0]   aw_rpntr_bin_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [5:0]   aw_rpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [5:0]   aw_rpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [11:0]  b_data_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [11:0]  b_data_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [5:0]   b_wpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [5:0]   b_wpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [140:0] r_data_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [140:0] r_data_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [5:0]   r_wpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [5:0]   r_wpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [4:0]   w_rpntr_bin_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [4:0]   w_rpntr_bin_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [5:0]   w_rpntr_gry_ddr_s0_ib_int_async;    //ddr_s0_ib_int_async - u_cd_main
wire   [5:0]   w_rpntr_gry_ddr_s1_ib_int_async;    //ddr_s1_ib_int_async - u_cd_main
wire   [31:0]  araddr_ddr_s0;
wire   [31:0]  araddr_ddr_s1;
wire   [1:0]   arburst_ddr_s0;
wire   [1:0]   arburst_ddr_s1;
wire   [3:0]   arcache_ddr_s0;
wire   [3:0]   arcache_ddr_s1;
wire   [9:0]   arid_ddr_s0;
wire   [9:0]   arid_ddr_s1;
wire   [7:0]   arlen_ddr_s0;
wire   [7:0]   arlen_ddr_s1;
wire           arlock_ddr_s0;
wire           arlock_ddr_s1;
wire   [2:0]   arprot_ddr_s0;
wire   [2:0]   arprot_ddr_s1;
wire           arready_dphy_m0;
wire   [2:0]   arsize_ddr_s0;
wire   [2:0]   arsize_ddr_s1;
wire           arvalid_ddr_s0;
wire           arvalid_ddr_s1;
wire   [31:0]  awaddr_ddr_s0;
wire   [31:0]  awaddr_ddr_s1;
wire   [1:0]   awburst_ddr_s0;
wire   [1:0]   awburst_ddr_s1;
wire   [3:0]   awcache_ddr_s0;
wire   [3:0]   awcache_ddr_s1;
wire   [9:0]   awid_ddr_s0;
wire   [9:0]   awid_ddr_s1;
wire   [7:0]   awlen_ddr_s0;
wire   [7:0]   awlen_ddr_s1;
wire           awlock_ddr_s0;
wire           awlock_ddr_s1;
wire   [2:0]   awprot_ddr_s0;
wire   [2:0]   awprot_ddr_s1;
wire           awready_dphy_m0;
wire   [2:0]   awsize_ddr_s0;
wire   [2:0]   awsize_ddr_s1;
wire           awvalid_ddr_s0;
wire           awvalid_ddr_s1;
wire   [10:0]  bid_dphy_m0;
wire           bready_ddr_s0;
wire           bready_ddr_s1;
wire   [1:0]   bresp_dphy_m0;
wire           bvalid_dphy_m0;
wire           ddr0clk;
wire           ddr0resetn;
wire           ddr1clk;
wire           ddr1resetn;
wire           mainclk;
wire           mainresetn;
wire   [127:0] rdata_dphy_m0;
wire   [10:0]  rid_dphy_m0;
wire           rlast_dphy_m0;
wire           rready_ddr_s0;
wire           rready_ddr_s1;
wire   [1:0]   rresp_dphy_m0;
wire           rvalid_dphy_m0;
wire   [127:0] wdata_ddr_s0;
wire   [127:0] wdata_ddr_s1;
wire           wlast_ddr_s0;
wire           wlast_ddr_s1;
wire           wready_dphy_m0;
wire   [15:0]  wstrb_ddr_s0;
wire   [15:0]  wstrb_ddr_s1;
wire           wvalid_ddr_s0;
wire           wvalid_ddr_s1;



//-----------------------------------------------------------------------------
// Sub-Modules Instantiation
//-----------------------------------------------------------------------------

nic400_cd_ddr0_wn7_ddr_r0p05     u_cd_ddr0 (
  .ddr0clk              (ddr0clk),    // ddr_s0
  .ddr0resetn           (ddr0resetn),    // ddr_s0
  .awid_ddr_s0          (awid_ddr_s0),    // ddr_s0
  .awaddr_ddr_s0        (awaddr_ddr_s0),    // ddr_s0
  .awlen_ddr_s0         (awlen_ddr_s0),    // ddr_s0
  .awsize_ddr_s0        (awsize_ddr_s0),    // ddr_s0
  .awburst_ddr_s0       (awburst_ddr_s0),    // ddr_s0
  .awlock_ddr_s0        (awlock_ddr_s0),    // ddr_s0
  .awcache_ddr_s0       (awcache_ddr_s0),    // ddr_s0
  .awprot_ddr_s0        (awprot_ddr_s0),    // ddr_s0
  .awvalid_ddr_s0       (awvalid_ddr_s0),    // ddr_s0
  .awready_ddr_s0       (awready_ddr_s0),    // ddr_s0
  .wdata_ddr_s0         (wdata_ddr_s0),    // ddr_s0
  .wstrb_ddr_s0         (wstrb_ddr_s0),    // ddr_s0
  .wlast_ddr_s0         (wlast_ddr_s0),    // ddr_s0
  .wvalid_ddr_s0        (wvalid_ddr_s0),    // ddr_s0
  .wready_ddr_s0        (wready_ddr_s0),    // ddr_s0
  .bid_ddr_s0           (bid_ddr_s0),    // ddr_s0
  .bresp_ddr_s0         (bresp_ddr_s0),    // ddr_s0
  .bvalid_ddr_s0        (bvalid_ddr_s0),    // ddr_s0
  .bready_ddr_s0        (bready_ddr_s0),    // ddr_s0
  .arid_ddr_s0          (arid_ddr_s0),    // ddr_s0
  .araddr_ddr_s0        (araddr_ddr_s0),    // ddr_s0
  .arlen_ddr_s0         (arlen_ddr_s0),    // ddr_s0
  .arsize_ddr_s0        (arsize_ddr_s0),    // ddr_s0
  .arburst_ddr_s0       (arburst_ddr_s0),    // ddr_s0
  .arlock_ddr_s0        (arlock_ddr_s0),    // ddr_s0
  .arcache_ddr_s0       (arcache_ddr_s0),    // ddr_s0
  .arprot_ddr_s0        (arprot_ddr_s0),    // ddr_s0
  .arvalid_ddr_s0       (arvalid_ddr_s0),    // ddr_s0
  .arready_ddr_s0       (arready_ddr_s0),    // ddr_s0
  .rid_ddr_s0           (rid_ddr_s0),    // ddr_s0
  .rdata_ddr_s0         (rdata_ddr_s0),    // ddr_s0
  .rresp_ddr_s0         (rresp_ddr_s0),    // ddr_s0
  .rlast_ddr_s0         (rlast_ddr_s0),    // ddr_s0
  .rvalid_ddr_s0        (rvalid_ddr_s0),    // ddr_s0
  .rready_ddr_s0        (rready_ddr_s0),    // ddr_s0
  .aw_data_ddr_s0_ib_int_async (aw_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .aw_wpntr_gry_ddr_s0_ib_int_async (aw_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .aw_rpntr_bin_ddr_s0_ib_int_async (aw_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .aw_rpntr_gry_ddr_s0_ib_int_async (aw_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .ar_data_ddr_s0_ib_int_async (ar_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .ar_wpntr_gry_ddr_s0_ib_int_async (ar_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .ar_rpntr_bin_ddr_s0_ib_int_async (ar_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .ar_rpntr_gry_ddr_s0_ib_int_async (ar_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .w_data_ddr_s0_ib_int_async (w_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .w_wpntr_gry_ddr_s0_ib_int_async (w_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .w_rpntr_bin_ddr_s0_ib_int_async (w_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .w_rpntr_gry_ddr_s0_ib_int_async (w_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .r_data_ddr_s0_ib_int_async (r_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .r_wpntr_gry_ddr_s0_ib_int_async (r_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .r_rpntr_bin_ddr_s0_ib_int_async (r_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .r_rpntr_gry_ddr_s0_ib_int_async (r_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .b_data_ddr_s0_ib_int_async (b_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .b_wpntr_gry_ddr_s0_ib_int_async (b_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .b_rpntr_bin_ddr_s0_ib_int_async (b_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .b_rpntr_gry_ddr_s0_ib_int_async (b_rpntr_gry_ddr_s0_ib_int_async)    // ddr_s0_ib_int_async
);


nic400_cd_ddr1_wn7_ddr_r0p05     u_cd_ddr1 (
  .ddr1clk              (ddr1clk),    // ddr_s1
  .ddr1resetn           (ddr1resetn),    // ddr_s1
  .awid_ddr_s1          (awid_ddr_s1),    // ddr_s1
  .awaddr_ddr_s1        (awaddr_ddr_s1),    // ddr_s1
  .awlen_ddr_s1         (awlen_ddr_s1),    // ddr_s1
  .awsize_ddr_s1        (awsize_ddr_s1),    // ddr_s1
  .awburst_ddr_s1       (awburst_ddr_s1),    // ddr_s1
  .awlock_ddr_s1        (awlock_ddr_s1),    // ddr_s1
  .awcache_ddr_s1       (awcache_ddr_s1),    // ddr_s1
  .awprot_ddr_s1        (awprot_ddr_s1),    // ddr_s1
  .awvalid_ddr_s1       (awvalid_ddr_s1),    // ddr_s1
  .awready_ddr_s1       (awready_ddr_s1),    // ddr_s1
  .wdata_ddr_s1         (wdata_ddr_s1),    // ddr_s1
  .wstrb_ddr_s1         (wstrb_ddr_s1),    // ddr_s1
  .wlast_ddr_s1         (wlast_ddr_s1),    // ddr_s1
  .wvalid_ddr_s1        (wvalid_ddr_s1),    // ddr_s1
  .wready_ddr_s1        (wready_ddr_s1),    // ddr_s1
  .bid_ddr_s1           (bid_ddr_s1),    // ddr_s1
  .bresp_ddr_s1         (bresp_ddr_s1),    // ddr_s1
  .bvalid_ddr_s1        (bvalid_ddr_s1),    // ddr_s1
  .bready_ddr_s1        (bready_ddr_s1),    // ddr_s1
  .arid_ddr_s1          (arid_ddr_s1),    // ddr_s1
  .araddr_ddr_s1        (araddr_ddr_s1),    // ddr_s1
  .arlen_ddr_s1         (arlen_ddr_s1),    // ddr_s1
  .arsize_ddr_s1        (arsize_ddr_s1),    // ddr_s1
  .arburst_ddr_s1       (arburst_ddr_s1),    // ddr_s1
  .arlock_ddr_s1        (arlock_ddr_s1),    // ddr_s1
  .arcache_ddr_s1       (arcache_ddr_s1),    // ddr_s1
  .arprot_ddr_s1        (arprot_ddr_s1),    // ddr_s1
  .arvalid_ddr_s1       (arvalid_ddr_s1),    // ddr_s1
  .arready_ddr_s1       (arready_ddr_s1),    // ddr_s1
  .rid_ddr_s1           (rid_ddr_s1),    // ddr_s1
  .rdata_ddr_s1         (rdata_ddr_s1),    // ddr_s1
  .rresp_ddr_s1         (rresp_ddr_s1),    // ddr_s1
  .rlast_ddr_s1         (rlast_ddr_s1),    // ddr_s1
  .rvalid_ddr_s1        (rvalid_ddr_s1),    // ddr_s1
  .rready_ddr_s1        (rready_ddr_s1),    // ddr_s1
  .aw_data_ddr_s1_ib_int_async (aw_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .aw_wpntr_gry_ddr_s1_ib_int_async (aw_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .aw_rpntr_bin_ddr_s1_ib_int_async (aw_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .aw_rpntr_gry_ddr_s1_ib_int_async (aw_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .ar_data_ddr_s1_ib_int_async (ar_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .ar_wpntr_gry_ddr_s1_ib_int_async (ar_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .ar_rpntr_bin_ddr_s1_ib_int_async (ar_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .ar_rpntr_gry_ddr_s1_ib_int_async (ar_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .w_data_ddr_s1_ib_int_async (w_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .w_wpntr_gry_ddr_s1_ib_int_async (w_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .w_rpntr_bin_ddr_s1_ib_int_async (w_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .w_rpntr_gry_ddr_s1_ib_int_async (w_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .r_data_ddr_s1_ib_int_async (r_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .r_wpntr_gry_ddr_s1_ib_int_async (r_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .r_rpntr_bin_ddr_s1_ib_int_async (r_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .r_rpntr_gry_ddr_s1_ib_int_async (r_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .b_data_ddr_s1_ib_int_async (b_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .b_wpntr_gry_ddr_s1_ib_int_async (b_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .b_rpntr_bin_ddr_s1_ib_int_async (b_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .b_rpntr_gry_ddr_s1_ib_int_async (b_rpntr_gry_ddr_s1_ib_int_async)    // ddr_s1_ib_int_async
);


nic400_cd_main_wn7_ddr_r0p05     u_cd_main (
  .aw_data_ddr_s0_ib_int_async (aw_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .aw_wpntr_gry_ddr_s0_ib_int_async (aw_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .aw_rpntr_bin_ddr_s0_ib_int_async (aw_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .aw_rpntr_gry_ddr_s0_ib_int_async (aw_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .ar_data_ddr_s0_ib_int_async (ar_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .ar_wpntr_gry_ddr_s0_ib_int_async (ar_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .ar_rpntr_bin_ddr_s0_ib_int_async (ar_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .ar_rpntr_gry_ddr_s0_ib_int_async (ar_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .w_data_ddr_s0_ib_int_async (w_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .w_wpntr_gry_ddr_s0_ib_int_async (w_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .w_rpntr_bin_ddr_s0_ib_int_async (w_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .w_rpntr_gry_ddr_s0_ib_int_async (w_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .r_data_ddr_s0_ib_int_async (r_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .r_wpntr_gry_ddr_s0_ib_int_async (r_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .r_rpntr_bin_ddr_s0_ib_int_async (r_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .r_rpntr_gry_ddr_s0_ib_int_async (r_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .b_data_ddr_s0_ib_int_async (b_data_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .b_wpntr_gry_ddr_s0_ib_int_async (b_wpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .b_rpntr_bin_ddr_s0_ib_int_async (b_rpntr_bin_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .b_rpntr_gry_ddr_s0_ib_int_async (b_rpntr_gry_ddr_s0_ib_int_async),    // ddr_s0_ib_int_async
  .aw_data_ddr_s1_ib_int_async (aw_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .aw_wpntr_gry_ddr_s1_ib_int_async (aw_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .aw_rpntr_bin_ddr_s1_ib_int_async (aw_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .aw_rpntr_gry_ddr_s1_ib_int_async (aw_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .ar_data_ddr_s1_ib_int_async (ar_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .ar_wpntr_gry_ddr_s1_ib_int_async (ar_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .ar_rpntr_bin_ddr_s1_ib_int_async (ar_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .ar_rpntr_gry_ddr_s1_ib_int_async (ar_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .w_data_ddr_s1_ib_int_async (w_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .w_wpntr_gry_ddr_s1_ib_int_async (w_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .w_rpntr_bin_ddr_s1_ib_int_async (w_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .w_rpntr_gry_ddr_s1_ib_int_async (w_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .r_data_ddr_s1_ib_int_async (r_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .r_wpntr_gry_ddr_s1_ib_int_async (r_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .r_rpntr_bin_ddr_s1_ib_int_async (r_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .r_rpntr_gry_ddr_s1_ib_int_async (r_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .b_data_ddr_s1_ib_int_async (b_data_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .b_wpntr_gry_ddr_s1_ib_int_async (b_wpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .b_rpntr_bin_ddr_s1_ib_int_async (b_rpntr_bin_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .b_rpntr_gry_ddr_s1_ib_int_async (b_rpntr_gry_ddr_s1_ib_int_async),    // ddr_s1_ib_int_async
  .mainclk              (mainclk),    // dphy_m0
  .mainresetn           (mainresetn),    // dphy_m0
  .awid_dphy_m0         (awid_dphy_m0),    // dphy_m0
  .awaddr_dphy_m0       (awaddr_dphy_m0),    // dphy_m0
  .awlen_dphy_m0        (awlen_dphy_m0),    // dphy_m0
  .awsize_dphy_m0       (awsize_dphy_m0),    // dphy_m0
  .awburst_dphy_m0      (awburst_dphy_m0),    // dphy_m0
  .awlock_dphy_m0       (awlock_dphy_m0),    // dphy_m0
  .awcache_dphy_m0      (awcache_dphy_m0),    // dphy_m0
  .awprot_dphy_m0       (awprot_dphy_m0),    // dphy_m0
  .awvalid_dphy_m0      (awvalid_dphy_m0),    // dphy_m0
  .awready_dphy_m0      (awready_dphy_m0),    // dphy_m0
  .wdata_dphy_m0        (wdata_dphy_m0),    // dphy_m0
  .wstrb_dphy_m0        (wstrb_dphy_m0),    // dphy_m0
  .wlast_dphy_m0        (wlast_dphy_m0),    // dphy_m0
  .wvalid_dphy_m0       (wvalid_dphy_m0),    // dphy_m0
  .wready_dphy_m0       (wready_dphy_m0),    // dphy_m0
  .bid_dphy_m0          (bid_dphy_m0),    // dphy_m0
  .bresp_dphy_m0        (bresp_dphy_m0),    // dphy_m0
  .bvalid_dphy_m0       (bvalid_dphy_m0),    // dphy_m0
  .bready_dphy_m0       (bready_dphy_m0),    // dphy_m0
  .arid_dphy_m0         (arid_dphy_m0),    // dphy_m0
  .araddr_dphy_m0       (araddr_dphy_m0),    // dphy_m0
  .arlen_dphy_m0        (arlen_dphy_m0),    // dphy_m0
  .arsize_dphy_m0       (arsize_dphy_m0),    // dphy_m0
  .arburst_dphy_m0      (arburst_dphy_m0),    // dphy_m0
  .arlock_dphy_m0       (arlock_dphy_m0),    // dphy_m0
  .arcache_dphy_m0      (arcache_dphy_m0),    // dphy_m0
  .arprot_dphy_m0       (arprot_dphy_m0),    // dphy_m0
  .arvalid_dphy_m0      (arvalid_dphy_m0),    // dphy_m0
  .arready_dphy_m0      (arready_dphy_m0),    // dphy_m0
  .rid_dphy_m0          (rid_dphy_m0),    // dphy_m0
  .rdata_dphy_m0        (rdata_dphy_m0),    // dphy_m0
  .rresp_dphy_m0        (rresp_dphy_m0),    // dphy_m0
  .rlast_dphy_m0        (rlast_dphy_m0),    // dphy_m0
  .rvalid_dphy_m0       (rvalid_dphy_m0),    // dphy_m0
  .rready_dphy_m0       (rready_dphy_m0)    // dphy_m0
);



endmodule
