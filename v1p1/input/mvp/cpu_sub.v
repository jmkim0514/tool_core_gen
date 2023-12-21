//==============================================================================
//
// Project : MVP
//
// Verilog RTL(Behavioral) model
//
// This confidential and proprietary source code may be used only as authorized
// by a licensing agreement from ALPHAHOLDINGS Limited. The entire notice above
// must be reproduced on all authorized copies and copies may only be made to
// the extent permitted by a licensing agreement from ALPHAHOLDINGS Limited.
//
// COPYRIGHT (C) ALPHAHOLDINGS, inc. 2023
//
//==============================================================================
// File name    : cpu_hpdf
// Description  : CPU SUB TOP
// Simulator    : NC Verilog
// Created by   : bhoh
// Date         : 2023-05-24
//==============================================================================
module cpu_sub #(parameter   PDMA_CH = 20)
(
    // ----------------------------------------------------------------
    // IP Clock & Reset
    // ----------------------------------------------------------------
    input			        i_clk_cpu                       ,
    input			        i_rstn_cpu                      ,
    input			        i_clk_sram                      ,
    input			        i_rstn_sram                     ,
    input			        i_clk_rom                       ,
    input			        i_rstn_rom                      ,
    input			        i_clk_mclk_dma                  ,
    input			        i_rstn_mclk_dma                 ,
    input			        i_clk_sclk_dma                  ,
    input			        i_rstn_sclk_dma                 ,
    input			        i_clken_dma330                  ,

    input			        i_clk_bus_m0                    ,
    input			        i_rstn_bus_m0                   ,
    input			        i_clk_nfc                       ,
    input			        i_rstn_nfc                      ,
    input			        i_clk_sfmc                      ,
    input			        i_rstn_sfmc                     ,
    input			        i_clk_sfmc_flash                ,
    input			        i_rstn_sfmc_flash               ,
	input			        i_clk_tracein                   ,

	input			        i_clk_cpu_stclk                 ,

    input                   i_rstn_core                     ,
    output                  o_rstn_core                     ,

    // ----------------------------------------------------------------
    // CRM APB I/F
    // ----------------------------------------------------------------
    output                  o_crm_apb_psel                  ,
    output                  o_crm_apb_penable               ,
    output                  o_crm_apb_pwrite                ,
    output	[ 11:0]         o_crm_apb_paddr                 ,
    output  [ 31:0]         o_crm_apb_pwdata                ,
    input   [ 31:0]         i_crm_apb_prdata                ,

    // ----------------------------------------------------------------
    // CPU_BUS_S0 (AHB)
    // ----------------------------------------------------------------
    // Instance: u_cd_i_clk_cpu, Port: mat2cpu_s0
    output  [ 31:0]         o_haddr_mat2cpu_s0              ,
    output  [  2:0]	        o_hburst_mat2cpu_s0             ,
    output  [  3:0]	        o_hprot_mat2cpu_s0              ,
    output  [  2:0]	        o_hsize_mat2cpu_s0              ,
    output  [  1:0]	        o_htrans_mat2cpu_s0             ,
    output  [ 31:0]	        o_hwdata_mat2cpu_s0             ,
    output                  o_hwrite_mat2cpu_s0             ,
    input   [ 31:0]	        i_hrdata_mat2cpu_s0             ,
    input                   i_hreadyout_mat2cpu_s0          ,
    input                   i_hresp_mat2cpu_s0              ,
    output                  o_hselx_mat2cpu_s0              ,
    output                  o_hready_mat2cpu_s0             ,
    output  [  1:0]	        o_hauser_mat2cpu_s0             ,

    // ----------------------------------------------------------------
    // CPU_BUS_S1 (AXI)
    // ----------------------------------------------------------------
    // Instance: dma330_s1
	// Write Address Channel
    output  [  3:0]         o_awid_dma330_s1                ,
    output  [ 31:0]         o_awaddr_dma330_s1              ,
    output  [  3:0]         o_awlen_dma330_s1               ,
    output  [  2:0]         o_awsize_dma330_s1              ,
    output  [  1:0]         o_awburst_dma330_s1             ,
    output  [  1:0]         o_awlock_dma330_s1              ,
    output  [  3:0]         o_awcache_dma330_s1             ,
    output  [  2:0]         o_awprot_dma330_s1              ,
    output                  o_awvalid_dma330_s1             ,
    input                   i_awready_dma330_s1             ,

	// Write Data Channel
    output  [  3:0]         o_wid_dma330_s1                 ,
    output  [127:0]         o_wdata_dma330_s1               ,
    output  [ 15:0]         o_wstrb_dma330_s1               ,
    output                  o_wlast_dma330_s1               ,
    output                  o_wvalid_dma330_s1              ,
    input                   i_wready_dma330_s1              ,

	// Write Response Channel
    input   [  3:0]         i_bid_dma330_s1                 ,
    input   [  1:0]         i_bresp_dma330_s1               ,
    input                   i_bvalid_dma330_s1              ,
    output                  o_bready_dma330_s1              ,

	// Read Address Channel
    output  [  3:0]         o_arid_dma330_s1                ,
    output  [ 31:0]         o_araddr_dma330_s1              ,
    output  [  3:0]         o_arlen_dma330_s1               ,
    output  [  2:0]         o_arsize_dma330_s1              ,
    output  [  1:0]         o_arburst_dma330_s1             ,
    output  [  1:0]         o_arlock_dma330_s1              ,
    output  [  3:0]         o_arcache_dma330_s1             ,
    output  [  2:0]         o_arprot_dma330_s1              ,
    output                  o_arvalid_dma330_s1             ,
    input                   i_arready_dma330_s1             ,

	// Read Data Channel
    input   [  3:0]         i_rid_dma330_s1                 ,
    input   [127:0]         i_rdata_dma330_s1               ,
    input   [  1:0]         i_rresp_dma330_s1               ,
    input                   i_rlast_dma330_s1               ,
    input                   i_rvalid_dma330_s1              ,
    output                  o_rready_dma330_s1              ,

    output  [  1:0]         o_aruser_dma330_s1              ,
    output  [  1:0]         o_awuser_dma330_s1              ,

    // ----------------------------------------------------------------
    // CPU_BUS_M0 (AHB)
    // ----------------------------------------------------------------
    // Instance: cpu2mat_m0
    input   [  1:0]         i_htrans_cpu2mat_m0             ,
    input   [ 31:0]         i_haddr_cpu2mat_m0              ,
    input   [  3:0]         i_hprot_cpu2mat_m0              ,
    input                   i_hwrite_cpu2mat_m0             ,
    input   [  2:0]         i_hsize_cpu2mat_m0              ,
    input   [  2:0]         i_hburst_cpu2mat_m0             ,
    input   [ 31:0]         i_hwdata_cpu2mat_m0             ,
    output  [ 31:0]         o_hrdata_cpu2mat_m0             ,
    output                  o_hresp_cpu2mat_m0              ,
    output                  o_hready_cpu2mat_m0             ,

    // ----------------------------------------------------------------
    // CPU_BUS_M1 (APB)
    // ----------------------------------------------------------------
    // Instance: u_cpu_m1
    input                   i_pselx_cpu_m1                  ,
    input                   i_penable_cpu_m1                ,
    input                   i_pwrite_cpu_m1                 ,
    input   [ 31:0]         i_paddr_cpu_m1                  ,
    input   [ 31:0]         i_pwdata_cpu_m1                 ,
    output  [ 31:0]         o_prdata_cpu_m1                 ,
    output                  o_pready_cpu_m1                 ,
    output                  o_pslverr_cpu_m1                ,

    // ----------------------------------------------------------------
    // CPU_BUS_M2 (AHB)
    // ----------------------------------------------------------------
    // Instance: u_cpu_m2_deco_ahb
    input   [  1:0]         i_htrans_cpu_m2                 ,
    input   [ 31:0]         i_haddr_cpu_m2                  ,
    input   [  3:0]         i_hprot_cpu_m2                  ,
    input                   i_hwrite_cpu_m2                 ,
    input   [  2:0]         i_hsize_cpu_m2                  ,
    input   [  2:0]         i_hburst_cpu_m2                 ,
    input   [ 31:0]         i_hwdata_cpu_m2                 ,
    output  [ 31:0]         o_hrdata_cpu_m2                 ,
    output                  o_hready_cpu_m2                 ,
    output                  o_hresp_cpu_m2                  ,

    // ----------------------------------------------------------------
    // CPU_BUS_M3 (AHB)
    // ----------------------------------------------------------------
    // Instance: u_alp_sfmc_m3
    input   [  1:0]         i_htrans_sfmc_m3                ,
    input   [ 31:0]         i_haddr_sfmc_m3                 ,
    input   [  3:0]         i_hprot_sfmc_m3                 ,
    input                   i_hwrite_sfmc_m3                ,
    input   [  2:0]         i_hsize_sfmc_m3                 ,
    input   [  2:0]         i_hburst_sfmc_m3                ,
    input   [ 31:0]         i_hwdata_sfmc_m3                ,
    output                  o_hready_sfmc_m3                ,
    output  [ 31:0]         o_hrdata_sfmc_m3                ,
    output                  o_hresp_sfmc_m3                 ,

    // ----------------------------------------------------------------
    // Configuration Port
    // ----------------------------------------------------------------
	input   [ 38:0]         i_ema                           ,
	input   [  1:0]         i_boot_sel_y                    ,

    // ----------------------------------------------------------------
    // Test Mode
    // ----------------------------------------------------------------
	input                   i_test_mode                     ,
    input                   t_jtag_tck                      , 
    // ----------------------------------------------------------------
    // Cortex-M3
    // ----------------------------------------------------------------
    // Debug
	input                   i_jtag_tck_y                    ,   // Test clock / SWCLK 
	input                   i_jtag_tmms_y                   , // Test Mode Select/SWDIN
	input                   i_jtag_ntrst_y                  ,   // Test reset
	output                  o_jtag_tmms_a                   ,
	output                  o_jtag_tmms_oe                  ,
	input                   i_jtag_tdi_y                    , // Test Data In
	output                  o_jtag_tdo_a                    ,
	output                  o_jtag_tdo_oe                   ,

    // Interrupt
	input   [239:0]         i_irq_cpu                       ,

  	// TracePort Output
	output                  o_cm3_traceclk_a                ,
	output  [  3:0]         o_cm3_tracedata_a               ,

    // ----------------------------------------------------------------
    // NFCON
    // ----------------------------------------------------------------
    // power on configuration signals
	input                   i_nfc_cfgadvflash_y             ,
	input                   i_nfc_cfgaddrcycle_y            ,
	input                   i_nfc_cfgpagesize_y             ,

    // interrupt signals
	output                  o_irq_nfc_rnb                   ,
	output                  o_irq_nfc                       ,

    // nand flash memory interface signals
	input   [  7:0]         i_nfc_data_y                    ,
	output  [  7:0]         o_nfc_data_a                    ,
	output  [  7:0]         o_nfc_data_oe                   ,
	input                   i_nfc_rnb_y                     ,
	output                  o_nfc_cle_a                     ,
	output                  o_nfc_ale_a                     ,
	output                  o_nfc_nce_a                     ,
	output                  o_nfc_nre_a                     ,
	output                  o_nfc_nwe_a                     ,

    // ----------------------------------------------------------------
    // SFMC
    // ---------------------------------------------------------------
	output			        o_irq_sfmc                      ,
//	output			        o_sfmc_rstn_a                   , // Flash Memory Reset
	input			        i_sfmc_sclk_y                   , // Flash Memory Clock
	output			        o_sfmc_sclk_a                   , // Flash Memory Clock
	output			        o_sfmc_sclk_oe                  , // Flash Memory Clock
	output                  o_sfmc_csn_a                    , // Flash Memory Chip Select
	input   [  3:0]	        i_sfmc_data_y                   , // Flash Memory Data Input
	output  [  3:0]	        o_sfmc_data_a                   , // Flash Memory Data Output
	output  [  3:0]	        o_sfmc_data_oe                  , // Flash Memory Data Output Enable

    // ---------------------------------------------------------------
    // DMA330
    // ---------------------------------------------------------------
    // Request inputs from PL080-style peripheral
    input   [PDMA_CH-1:0]   i_dmac_breq                     ,
	input   [PDMA_CH-1:0]   i_dmac_sreq                     ,
	input   [PDMA_CH-1:0]   i_dmac_lbreq                    ,
	input   [PDMA_CH-1:0]   i_dmac_lsreq                    ,

    // Response outputs to PL080-style peripheral
	output  [PDMA_CH-1:0]   o_dmac_clr                      ,
	output  [PDMA_CH-1:0]   o_dmac_tc                       ,

	output                  o_irq_dmac0                     ,
	output                  o_irq_dmac1                     ,
	output                  o_irq_dmac2                     ,
	output                  o_irq_dmac3                     ,
	output                  o_irq_dmac4                     ,
	output                  o_irq_dmac5                     ,
	output                  o_irq_dmac6                     ,
	output                  o_irq_dmac7                     ,
	output                  o_irq_abort_dmac                
);


	wire	[1:0]	nfc_flash_dir   ;
	wire	[1:0]	nfc_nce         ;
	wire	[15:0]	nfc_flash_ioout ;

	wire        	nfcon_ston_wen  ;
	wire	[11:0]	nfcon_ston_a    ;
	wire	[31:0]	nfcon_ston_dout ;

	wire			nfcon_ston_clk  ;
	wire			nfcon_ston_nce  ;

	wire			nfc_cfgenbnfcon ;
    wire            nfc_boot_done   ;

    // power on configuration signals
    wire    [ 2:0]  nfc_boot_tacls  ;
    wire    [ 2:0]  nfc_boot_twrph0 ;
    wire    [ 2:0]  nfc_boot_twrph1 ;
    wire            nfc_endian      ;

    // external bus interface signals (ebi)
    wire            nfc_extbusreq   ;
    wire            nfc_extbusgnt   ;
    wire            nfc_extbackoff  ;

    wire            nfc_ston_csn0   ;

    wire            irq_nfc_rnb; 

	wire 			sfmc_sram_clk   ;
    wire			sfmc_sram_csn   ;
	wire			sfmc_sram_wen   ;
	wire	[10:0]	sfmc_sram_addr  ;
    wire	[31:0]	sfmc_sram_wdata ;
    wire	[31:0]	sfmc_sram_rdata ;
    wire            sfmc_boot_done  ; 
    wire            sfmc_boot_en    ;

    wire    [ 31:0]     bus_matrix_hrdatam0     ;
    wire                bus_matrix_hreadyoutm0  ;
    wire                bus_matrix_hreadym0     ;
    wire    [  1:0]     bus_matrix_hrespm0      ;
    wire    [ 31:0]     bus_matrix_haddrm0      ;
	wire                bus_matrix_hselm0       ;
    wire    [  1:0]     bus_matrix_htransm0     ;
    wire                bus_matrix_hwritem0     ;
    wire    [  2:0]     bus_matrix_hsizem0      ;
    wire    [ 31:0]     bus_matrix_hwdatam0     ;

    wire    [ 31:0]     bus_matrix_hrdatam1     ;
    wire                bus_matrix_hreadyoutm1  ;
    wire                bus_matrix_hreadym1     ;
    wire    [  1:0]     bus_matrix_hrespm1      ;
    wire    [ 31:0]     bus_matrix_haddrm1      ;
	wire                bus_matrix_hselm1       ;
    wire    [  1:0]     bus_matrix_htransm1     ;
    wire                bus_matrix_hwritem1     ;
    wire    [  2:0]     bus_matrix_hsizem1      ;
    wire    [ 31:0]     bus_matrix_hwdatam1     ;

	wire	[  1:0]     mat_remapsel            ;
	wire	[ 31:0]	    mat_haddrs0             ;
	wire	[ 31:0]	    mat_haddrs1             ;
	wire	[  1:0]	    mat_hresps3             ;

	//==================================================================
	// Cortex-M3
	//==================================================================
    // PMU
    wire                cm3_isolaten        ;
    
    // Debug
    wire                cm3_cdbgpwrupreq    ;

    // Miscellaneous
    wire    [ 25:0]     cm3_stcalib         ;
    wire    [ 31:0]     cm3_auxfault        ;
    wire                cm3_bigend          ;

    // Code (instruction & literal) bus
    wire	[  1:0]	    cm3_i_htrans        ;
    wire	[  2:0]	    cm3_i_hsize         ;
    wire	[  2:0]	    cm3_i_hburst        ;
    wire	[  3:0]	    cm3_i_hprot         ;
    wire				cm3_i_hready        ;
    wire 	[ 31:0]		cm3_i_haddr         ;
    wire	[ 31:0]	    cm3_i_hrdata        ;
    wire	[  1:0]	    cm3_i_hresp         ;
    wire    [  1:0]     cm3_i_memattr       ;
    
    wire	[  1:0]	    cm3_d_htrans        ;
    wire			    cm3_d_hwrite        ;
    wire	[  2:0]	    cm3_d_hsize         ;
    wire	[  2:0]	    cm3_d_hburst        ;
    wire	[  3:0]	    cm3_d_hprot         ;
    wire	[ 31:0]	    cm3_d_hwdata        ;
    wire			    cm3_d_hready        ;
    wire 	[ 31:0]		cm3_d_haddr         ;
    wire	[ 31:0]	    cm3_d_hrdata        ;
    wire	[  1:0]	    cm3_d_hresp         ;
    wire                cm3_d_exreq         ;
    wire    [  1:0]     cm3_d_memattr       ;
    wire                cm3_d_exresp        ;
    wire    [  1:0]     cm3_d_hmaster       ;
    
    // System Bus
    wire	[  1:0]	    cm3_s_htrans        ;
    wire	[ 31:0]	    cm3_s_haddr         ;
    wire			    cm3_s_hwrite        ;
    wire	[  2:0]	    cm3_s_hburst        ;
    wire	[  3:0]	    cm3_s_hprot         ;
    wire	[ 31:0]	    cm3_s_hwdata        ;
    wire			    cm3_s_hready        ;
    wire	[ 31:0]	    cm3_s_hrdata        ;
    wire	[  1:0]	    cm3_s_hresp         ;
    wire	[  2:0]	    cm3_s_hsize         ;
    wire                cm3_s_exreq         ;
    wire    [  1:0]     cm3_s_memattr       ;
    wire                cm3_s_hmastlock     ;
    wire    [  1:0]     cm3_s_hmaster       ;
    wire                cm3_s_exresp        ;

    // Sleep
    wire                cm3_sleepholdreqn   ;

    // DAP HMASTER override
    wire                cm3_fixhmastertype  ;

    // WIC
    wire                cm3_wicenreq        ;
    wire                cm3_wicenack        ;
    wire                cm3_wakeup          ;

    // Timestamp interface
    wire                cm3_tsclkchange     ;

    // Logic disable
    wire                cm3_mpudisable      ;
    wire                cm3_dbgen           ;

    // Core Status
    wire    [  3:0]     cm3_brchstat        ;
    wire                cm3_lockup          ;
    wire                cm3_sleeping        ;
    wire                cm3_sleepdeep       ;
    wire                cm3_sleepholdackn   ;
    wire    [  7:0]     cm3_currpri         ;

  	// Reset request
	wire                cm3_sysresetreq     ;

  	// Clock gating control
	wire                cm3_gatehclk        ;

    // Observation
    wire    [148:0]     cm3_internalstate   ;

    wire                jtag_tck            ;


        // synopsys dc_script_begin
        // set_dont_touch DONT_TOUCH_u_*
        // synopsys dc_script_end
        MXT2_X4M_A9TR_C34 DONT_TOUCH_u_alp_test_mxt2 (.Y(jtag_tck), .A(i_jtag_tck_y), .B(t_jtag_tck), .S0(i_test_mode));

cm3_sub_system u_cm3_sub_system(

    .i_clk_cpu                       (i_clk_cpu         ),
    .i_rstn_cpu                      (i_rstn_cpu        ),
    .i_clk_tracein                   (i_clk_tracein     ),
	.i_clk_cpu_stclk                 (i_clk_cpu_stclk   ),
	.i_jtag_tck_y                    (jtag_tck          ),   // Test Mode Select/SWDIN
	.i_jtag_tmms_y                   (i_jtag_tmms_y     ),   // Test Mode Select/SWDIN
	.i_jtag_ntrst_y                  (i_jtag_ntrst_y    ),   
    .o_jtag_tmms_a                   (o_jtag_tmms_a     ),
	.o_jtag_tmms_oe                  (o_jtag_tmms_oe    ),
	.i_jtag_tdi_y                    (i_jtag_tdi_y      ),   // Test Data In
	.o_jtag_tdo_a                    (o_jtag_tdo_a      ),
	.o_jtag_tdo_oe                   (o_jtag_tdo_oe     ),
	.o_cm3_traceclk_a                (o_cm3_traceclk_a  ),
	.o_cm3_tracedata_a               (o_cm3_tracedata_a ),
	.i_irq_cpu                       (i_irq_cpu         ),
    .i_cm3_isolaten                  (cm3_isolaten      ),   // Isolate core power domain
    .i_cm3_cdbgpwrupack              (cm3_cdbgpwrupack  ),   // Debug power up acknowledge
    .i_cm3_stcalib                   (cm3_stcalib       ),   // System Tick calibration
    .i_cm3_auxfault                  (cm3_auxfault      ),   // Auxillary FSR pulse inputs
    .i_cm3_bigend                    (cm3_bigend        ),   // Static endianess select
    .i_cm3_hreadyi                   (cm3_i_hready      ),   // ICode-bus ready
    .i_cm3_hrdatai                   (cm3_i_hrdata      ),   // ICode-bus read data
    .i_cm3_hrespi                    (cm3_i_hresp       ),   // ICode-bus transfer response
    .i_cm3_hreadyd                   (cm3_d_hready      ),   // DCode-bus ready
    .i_cm3_hrdatad                   (cm3_d_hrdata      ),   // DCode-bus read data
    .i_cm3_hrespd                    (cm3_d_hresp       ),   // DCode-bus transfer response
    .i_cm3_exrespd                   (cm3_d_exresp      ),   // DCode-bus exclusive response
    .i_cm3_hreadys                   (cm3_s_hready      ),   // System-bus ready
    .i_cm3_hrdatas                   (cm3_s_hrdata      ),   // System-bus read data
    .i_cm3_hresps                    (cm3_s_hresp       ),   // System-bus transfer response
    .i_cm3_exresps                   (cm3_s_exresp      ),   // System-bus exclusive response
    .i_cm3_sleepholdreqn             (cm3_sleepholdreqn ),   // Hold core in sleep mode
    .i_cm3_fixhmastertype            (cm3_fixhmastertype),   // Override HMASTER for AHB-AP accesses
    .i_cm3_wicenreq                  (cm3_wicenreq      ),   // WIC mode Request from PMU
    .i_cm3_tsclkchange               (cm3_tsclkchange   ),   // Timestamp clock ratio change
    .i_cm3_mpudisable                (cm3_mpudisable    ),   // Disable the MPU (act as default)
    .i_cm3_dbgen                     (cm3_dbgen         ),   // Enable debug
    .i_scan_mode                     (i_test_mode       ),   // SCAN MODE
    .o_cm3_cdbgpwrupreq              (cm3_cdbgpwrupreq  ),   // Debug power up request
    .o_cm3_htransi                   (cm3_i_htrans      ),   // ICode-bus transfer type
    .o_cm3_hsizei                    (cm3_i_hsize       ),   // ICode-bus transfer size
    .o_cm3_haddri                    (cm3_i_haddr       ),   // ICode-bus address
    .o_cm3_hbursti                   (cm3_i_hburst      ),   // ICode-bus burst length
    .o_cm3_hproti                    (cm3_i_hprot       ),   // ICode-bus protection
    .o_cm3_memattri                  (cm3_i_memattr     ),   // ICode-bus memory attributes
    .o_cm3_hmasterd                  (cm3_d_hmaster     ),   // DCode-bus master
    .o_cm3_htransd                   (cm3_d_htrans      ),   // DCode-bus transfer type
    .o_cm3_hsized                    (cm3_d_hsize       ),   // DCode-bus transfer size
    .o_cm3_haddrd                    (cm3_d_haddr       ),   // DCode-bus address
    .o_cm3_hburstd                   (cm3_d_hburst      ),   // DCode-bus burst length
    .o_cm3_hprotd                    (cm3_d_hprot       ),   // DCode-bus protection
    .o_cm3_memattrd                  (cm3_d_memattr     ),   // ICode-bus memory attributes
    .o_cm3_exreqd                    (cm3_d_exreq       ),   // ICode-bus exclusive request
    .o_cm3_hwrited                   (cm3_d_hwrite      ),   // DCode-bus write not read
    .o_cm3_hwdatad                   (cm3_d_hwdata      ),   // DCode-bus write data
    .o_cm3_hmasters                  (cm3_s_hmaster     ),   // System-bus master
    .o_cm3_htranss                   (cm3_s_htrans      ),   // System-bus transfer type
    .o_cm3_hwrites                   (cm3_s_hwrite      ),   // System-bus write not read
    .o_cm3_hsizes                    (cm3_s_hsize       ),   // System-bus transfer size
    .o_cm3_hmastlocks                (cm3_s_hmastlock   ),   // System-bus lock
    .o_cm3_haddrs                    (cm3_s_haddr       ),   // System-bus address
    .o_cm3_hwdatas                   (cm3_s_hwdata      ),   // System-bus write data
    .o_cm3_hbursts                   (cm3_s_hburst      ),   // System-bus burst length
    .o_cm3_hprots                    (cm3_s_hprot       ),   // System-bus protection
    .o_cm3_memattrs                  (cm3_s_memattr     ),   // System-bus memory attributes
    .o_cm3_exreqs                    (cm3_s_exreq       ),   // System-bus exclusive request
    .o_cm3_brchstat                  (cm3_brchstat     ),   // Branch status
    .o_cm3_lockup                    (cm3_lockup       ),   // Lockup indication
    .o_cm3_sleeping                  (cm3_sleeping     ),   // Core is sleeping
    .o_cm3_sleepdeep                 (cm3_sleepdeep    ),   // System can enter deep sleep
    .o_cm3_sleepholdackn             (cm3_sleepholdackn),   // Indicate core is force in sleep mode
    .o_cm3_currpri                   (cm3_currpri      ),   // Current Int Priority
    .o_cm3_sysresetreq               (cm3_sysresetreq  ),   // System reset request
    .o_cm3_gatehclk                  (cm3_gatehclk     ),   // when high, HCLK can be turned off
    .o_cm3_internalstate             (cm3_internalstate),   // Observation of internal state
    .o_cm3_wicenack                  (cm3_wicenack     ),   // WIC mode acknowledge from WIC
    .o_cm3_wakeup                    (cm3_wakeup       )    // Wake-up request from WIC
);

    boot_system u_boot_system(
        .i_boot_sel		    (i_boot_sel_y),
        .i_nfc_boot_done	(nfc_boot_done), 
        .o_nfc_boot_en		(nfc_cfgenbnfcon), 
        .i_sfmc_boot_done	(sfmc_boot_done), 
        .o_sfmc_boot_en		(sfmc_boot_en  ), 
        .i_cm3_i_haddr		(cm3_i_haddr), 
        .i_cm3_d_haddr		(cm3_d_haddr), 
        .o_mat_haddrs0		(mat_haddrs0), 
        .o_mat_haddrs1		(mat_haddrs1), 
        .o_mat_remapsel		(mat_remapsel), 
        .i_rstn_core		(i_rstn_core), 
        .o_rstn_core		(o_rstn_core) 
    );


	//==================================================================
	// 4x3 BusMatrix
	//==================================================================

	assign o_hresp_cpu2mat_m0 = mat_hresps3[0];

    cm3_platform_busmatrix 
    u_busmatrix (
        // Common AHB signals
		.HCLK                    (i_clk_cpu                 ),
        .HRESETn                 (i_rstn_cpu                ),
        // System address remapping control
        .REMAP                   ({2'b0, mat_remapsel}      ),
        // Input port SI0 (inputs from master 0)
        .HSELS0                  (cm3_i_htrans[1]           ),
        .HADDRS0                 (mat_haddrs0               ),
        .HTRANSS0                (cm3_i_htrans              ),
        .HWRITES0                (1'b0                      ),
        .HSIZES0                 (cm3_i_hsize               ),
        .HBURSTS0                (cm3_i_hburst              ),
        .HPROTS0                 (cm3_i_hprot               ),
        .HMASTERS0               (4'h0                      ),
        .HWDATAS0                (32'h0                     ),
        .HMASTLOCKS0             (1'b0                      ),
        .HREADYS0                (cm3_i_hready              ),
        // Input port SI1 (inputs from master 1)
        .HSELS1                  (cm3_d_htrans[1]           ),
        .HADDRS1                 (mat_haddrs1               ),
        .HTRANSS1                (cm3_d_htrans              ),
        .HWRITES1                (cm3_d_hwrite              ),
        .HSIZES1                 (cm3_d_hsize               ),
        .HBURSTS1                (cm3_d_hburst              ),
        .HPROTS1                 (cm3_d_hprot               ),
        .HMASTERS1               (4'h0                      ),
        .HWDATAS1                (cm3_d_hwdata              ),
        .HMASTLOCKS1             (1'b0                      ),
        .HREADYS1                (cm3_d_hready              ),
        // Input port SI2 (inputs from master 2)
        .HSELS2                  (cm3_s_htrans[1]           ),
        .HADDRS2                 (cm3_s_haddr               ),
        .HTRANSS2                (cm3_s_htrans              ),
        .HWRITES2                (cm3_s_hwrite              ),
        .HSIZES2                 (cm3_s_hsize               ),
        .HBURSTS2                (cm3_s_hburst              ),
        .HPROTS2                 (cm3_s_hprot               ),
        .HMASTERS2               (4'h0                      ),
        .HWDATAS2                (cm3_s_hwdata              ),
        .HMASTLOCKS2             (1'b0                      ),
        .HREADYS2                (cm3_s_hready              ),
        // Input port SI3 (inputs from master 3)
        .HSELS3                  (i_htrans_cpu2mat_m0[1]    ),
        .HADDRS3                 (i_haddr_cpu2mat_m0        ),
        .HTRANSS3                (i_htrans_cpu2mat_m0       ),
        .HWRITES3                (i_hwrite_cpu2mat_m0       ),
        .HSIZES3                 (i_hsize_cpu2mat_m0        ),
        .HBURSTS3                (i_hburst_cpu2mat_m0       ),
        .HPROTS3                 (i_hprot_cpu2mat_m0        ),
        .HMASTERS3               (4'h0                      ),
        .HWDATAS3                (i_hwdata_cpu2mat_m0       ),
        .HMASTLOCKS3             (1'h0                      ),
        .HREADYS3                (o_hready_cpu2mat_m0       ),
        // Output port MI0 (inputs from slave 0)
        .HRDATAM0                (bus_matrix_hrdatam0       ),
        .HREADYOUTM0             (bus_matrix_hreadyoutm0    ),
        .HRESPM0                 (bus_matrix_hrespm0        ),
        // Output port MI1 (inputs from slave 1)
        .HRDATAM1                (bus_matrix_hrdatam1       ),
        .HREADYOUTM1             (bus_matrix_hreadyoutm1    ),
        .HRESPM1                 (bus_matrix_hrespm1        ),
        // Output port MI2 (inputs from slave 2)
        .HRDATAM2                (i_hrdata_mat2cpu_s0       ),
        .HREADYOUTM2             (i_hreadyout_mat2cpu_s0    ),
        .HRESPM2                 ({1'b0, i_hresp_mat2cpu_s0}),
        // Scan test dummy signals; not connected until scan insertion
        .SCANENABLE              (i_test_mode               ),
        .SCANINHCLK              (i_clk_cpu                 ),
        // Output port MI0 (outputs to slave 0)
        .HSELM0                  (bus_matrix_hselm0         ),
        .HADDRM0                 (bus_matrix_haddrm0        ),
        .HTRANSM0                (bus_matrix_htransm0       ),
        .HWRITEM0                (bus_matrix_hwritem0       ),
        .HSIZEM0                 (bus_matrix_hsizem0        ),
        .HBURSTM0                (                          ),
        .HPROTM0                 (                          ),
        .HMASTERM0               (                          ),
        .HWDATAM0                (bus_matrix_hwdatam0       ),
        .HMASTLOCKM0             (                          ),
        .HREADYMUXM0             (bus_matrix_hreadym0       ),
        // Output port MI1 (outputs to slave 1)
        .HSELM1                  (bus_matrix_hselm1         ),
        .HADDRM1                 (bus_matrix_haddrm1        ),
        .HTRANSM1                (bus_matrix_htransm1       ),
        .HWRITEM1                (bus_matrix_hwritem1       ),
        .HSIZEM1                 (bus_matrix_hsizem1        ),
        //.HBURSTM1                (bus_matrix_HBURSTM1     ),
        .HBURSTM1                (                          ),
        .HPROTM1                 (                          ),
        .HMASTERM1               (                          ),
        .HWDATAM1                (bus_matrix_hwdatam1       ),
        .HMASTLOCKM1             (                          ),
        .HREADYMUXM1             (bus_matrix_hreadym1       ),
        // Output port MI2 (outputs to slave 2)
        .HSELM2                  (o_hselx_mat2cpu_s0        ),
        .HADDRM2                 (o_haddr_mat2cpu_s0        ),
        .HTRANSM2                (o_htrans_mat2cpu_s0       ),
        .HWRITEM2                (o_hwrite_mat2cpu_s0       ),
        .HSIZEM2                 (o_hsize_mat2cpu_s0        ),
        .HBURSTM2                (o_hburst_mat2cpu_s0       ),
        .HPROTM2                 (o_hprot_mat2cpu_s0        ),
        .HMASTERM2               (                          ),
        .HWDATAM2                (o_hwdata_mat2cpu_s0       ),
        .HMASTLOCKM2             (                          ),
        .HREADYMUXM2             (o_hready_mat2cpu_s0       ),
        // Input port SI0 (outputs to master 0)
        .HRDATAS0                (cm3_i_hrdata              ),
        .HREADYOUTS0             (cm3_i_hready              ),
        .HRESPS0                 (cm3_i_hresp               ),
        // Input port SI1 (outputs to master 1)
        .HRDATAS1                (cm3_d_hrdata              ),
        .HREADYOUTS1             (cm3_d_hready              ),
        .HRESPS1                 (cm3_d_hresp               ),
        // Input port SI2 (outputs to master 2)
        .HRDATAS2                (cm3_s_hrdata              ),
        .HREADYOUTS2             (cm3_s_hready              ),
        .HRESPS2                 (cm3_s_hresp               ),
        // Input port SI3 (outputs to master 3)
        .HRDATAS3                (o_hrdata_cpu2mat_m0       ),
        .HREADYOUTS3             (o_hready_cpu2mat_m0       ),
        .HRESPS3                 (mat_hresps3               ),
        // Scan test dummy signals; not connected until scan insertion
        .SCANOUTHCLK             (                          )
    );

	//==================================================================
	// CPU_PERI0 (M1)
	//==================================================================
	wire			dma330_sec_psel     ;
    wire			dma330_sec_penable  ;
    wire			dma330_sec_pwrite   ;
    wire	[11:0]	dma330_sec_paddr    ;
    wire    [31:0]	dma330_sec_pwdata   ;
    wire	[31:0]	dma330_sec_prdata   ;
    wire 			dma330_sec_pready   ;
    wire			dma330_sec_pslverr  ;

    wire			dma330_nsec_psel    ;
    wire			dma330_nsec_penable ;
    wire			dma330_nsec_pwrite  ;
    wire    [11:0]	dma330_nsec_paddr   ;
    wire	[31:0]	dma330_nsec_pwdata  ;
    wire	[31:0]	dma330_nsec_prdata  ;
    wire			dma330_nsec_pready  ;
    wire			dma330_nsec_pslverr ;

    wire			debug_port_psel     ;
    wire			debug_port_penable  ;
    wire			debug_port_pwrite   ;
    wire    [31:0]	debug_port_paddr    ;
    wire	[31:0]	debug_port_pwdata   ;
    wire	[31:0]	debug_port_prdata   ;

    wire            sys_psel            ;
    wire            sys_penable         ;
    wire            sys_pwrite          ;
    wire    [11:0]  sys_paddr           ;
    wire    [31:0]  sys_pwdata          ;
    wire    [31:0]  sys_prdata          ;

    wire            tie_psel            ;
    wire            tie_penable         ;
    wire            tie_pwrite          ;
    wire    [11: 0] tie_paddr           ;
    wire    [31: 0] tie_pwdata          ;
    wire    [31: 0] tie_prdata          ;

    cpu_m1_deco_apb3
    u_cpu_m1_deco_apb3 (
        // SI Clock & Reset
        .i_clk_si                   (i_clk_bus_m0       ),
        .i_rstn_si                  (i_rstn_bus_m0      ),
        // SI Interface
        .i_si_psel                  (i_pselx_cpu_m1     ),
        .i_si_penable               (i_penable_cpu_m1   ),
        .i_si_pwrite                (i_pwrite_cpu_m1    ),
        .i_si_paddr                 (i_paddr_cpu_m1     ),
        .i_si_pwdata                (i_pwdata_cpu_m1    ),
        .o_si_prdata                (o_prdata_cpu_m1    ),
        .o_si_pready                (o_pready_cpu_m1    ),
        .o_si_pslverr               (o_pslverr_cpu_m1   ),
        // MI_0 - name:cpu_crm 
        .o_cpu_crm_psel             (o_crm_apb_psel     ),
        .o_cpu_crm_penable          (o_crm_apb_penable  ),
        .o_cpu_crm_pwrite           (o_crm_apb_pwrite   ),
        .o_cpu_crm_paddr            (o_crm_apb_paddr    ),
        .o_cpu_crm_pwdata           (o_crm_apb_pwdata   ),
        .i_cpu_crm_prdata           (i_crm_apb_prdata   ),
        .i_cpu_crm_pready           (1'b1               ),
        .i_cpu_crm_pslverr          (1'b0               ),
        // MI_1 - name:cpu_sys 
        .o_cpu_sys_psel             (sys_psel           ),
        .o_cpu_sys_penable          (sys_penable        ),
        .o_cpu_sys_pwrite           (sys_pwrite         ),
        .o_cpu_sys_paddr            (sys_paddr          ),
        .o_cpu_sys_pwdata           (sys_pwdata         ),
        .i_cpu_sys_prdata           (sys_prdata         ),
        .i_cpu_sys_pready           (1'b1               ),
        .i_cpu_sys_pslverr          (1'b0               ),
        // MI_2 - name:cpu_tie 
        .o_cpu_tie_psel             (tie_psel           ),
        .o_cpu_tie_penable          (tie_penable        ),
        .o_cpu_tie_pwrite           (tie_pwrite         ),
        .o_cpu_tie_paddr            (tie_paddr          ),
        .o_cpu_tie_pwdata           (tie_pwdata         ),
        .i_cpu_tie_prdata           (tie_prdata         ),
        .i_cpu_tie_pready           (1'b1               ),
        .i_cpu_tie_pslverr          (1'b0               ),
        // MI_3 - name:dma330_s 
        .i_dma330_s_clk             (i_clk_sclk_dma     ),
        .i_dma330_s_rstn            (i_rstn_sclk_dma    ),
        .o_dma330_s_psel            (dma330_sec_psel    ),
        .o_dma330_s_penable         (dma330_sec_penable ),
        .o_dma330_s_pwrite          (dma330_sec_pwrite  ),
        .o_dma330_s_paddr           (dma330_sec_paddr   ),
        .o_dma330_s_pwdata          (dma330_sec_pwdata  ),
        .i_dma330_s_prdata          (dma330_sec_prdata  ),
        .i_dma330_s_pready          (dma330_sec_pready  ),
        .i_dma330_s_pslverr         (1'b0               ),
        // MI_4 - name:dma330_ns 
        .i_dma330_ns_clk            (i_clk_sclk_dma     ),
        .i_dma330_ns_rstn           (i_rstn_sclk_dma    ),
        .o_dma330_ns_psel           (dma330_nsec_psel   ),
        .o_dma330_ns_penable        (dma330_nsec_penable),
        .o_dma330_ns_pwrite         (dma330_nsec_pwrite ),
        .o_dma330_ns_paddr          (dma330_nsec_paddr  ),
        .o_dma330_ns_pwdata         (dma330_nsec_pwdata ),
        .i_dma330_ns_prdata         (dma330_nsec_prdata ),
        .i_dma330_ns_pready         (dma330_nsec_pready ),
        .i_dma330_ns_pslverr        (1'b0               ),
        // MI_5 - name:debug_port 
        .o_debug_port_psel          (debug_port_psel    ),
        .o_debug_port_penable       (debug_port_penable ),
        .o_debug_port_pwrite        (debug_port_pwrite  ),
        .o_debug_port_paddr         (debug_port_paddr   ),
        .o_debug_port_pwdata        (debug_port_pwdata  ),
        .i_debug_port_prdata        (debug_port_prdata  ),
        .i_debug_port_pready        (1'b1               ),
        .i_debug_port_pslverr       (1'b0               )
    );

	//==================================================================
	// CPU_PERI1 (M2)
	//==================================================================
    wire    [ 1:0]  nfc_htrans  ;
    wire    [15:0]  nfc_haddr   ;
    wire    	    nfc_hwrite  ;
    wire    [ 2:0]  nfc_hsize   ;
    wire    [ 2:0]  nfc_hburst  ;
    wire    [31:0]  nfc_hwdata  ;
    wire    [31:0]  nfc_hrdata  ;
    wire    	    nfc_hready  ;
    wire    [ 1:0]  nfc_hresp   ;

    wire    [ 1:0]  sfmc_htrans ;
    wire    [15:0]  sfmc_haddr  ;
    wire    	    sfmc_hwrite ;
    wire    [ 2:0]  sfmc_hsize  ;
    wire    [ 2:0]  sfmc_hburst ;
    wire    [31:0]  sfmc_hwdata ;
    wire    [31:0]  sfmc_hrdata ;
    wire            sfmc_hready ;
    wire            sfmc_hresp  ;

    cpu_m2_deco_ahb
    u_cpu_m2_deco_ahb(
        // SI Clock & Reset
        .i_clk_si               (i_clk_bus_m0       ),
        .i_rstn_si              (i_rstn_bus_m0      ),
        // SI Interface
        .i_si_htrans            (i_htrans_cpu_m2    ),
        .i_si_haddr             (i_haddr_cpu_m2     ),
        .i_si_hwrite            (i_hwrite_cpu_m2    ),
        .i_si_hsize             (i_hsize_cpu_m2     ),
        .i_si_hburst            (i_hburst_cpu_m2    ),
        .i_si_hwdata            (i_hwdata_cpu_m2    ),
        .o_si_hrdata            (o_hrdata_cpu_m2    ),
        .o_si_hready            (o_hready_cpu_m2    ),
        .o_si_hresp             (o_hresp_cpu_m2     ),
        // MI_0 - name:nfcon 
        .o_nfcon_htrans         (nfc_htrans         ),
        .o_nfcon_haddr          (nfc_haddr          ),
        .o_nfcon_hwrite         (nfc_hwrite         ),
        .o_nfcon_hsize          (nfc_hsize          ),
        .o_nfcon_hburst         (nfc_hburst         ),
        .o_nfcon_hwdata         (nfc_hwdata         ),
        .i_nfcon_hrdata         (nfc_hrdata         ),
        .i_nfcon_hready         (nfc_hready         ),
        .i_nfcon_hresp          (nfc_hresp[0]       ),
        // MI_1 - name:sfmc 
        .o_sfmc_htrans          (sfmc_htrans        ),
        .o_sfmc_haddr           (sfmc_haddr         ),
        .o_sfmc_hwrite          (sfmc_hwrite        ),
        .o_sfmc_hsize           (sfmc_hsize         ),
        .o_sfmc_hburst          (sfmc_hburst        ),
        .o_sfmc_hwdata          (sfmc_hwdata        ),
        .i_sfmc_hrdata          (sfmc_hrdata        ),
        .i_sfmc_hready          (sfmc_hready        ),
        .i_sfmc_hresp           (sfmc_hresp         )
    );

	//==================================================================
	// DMA330
	//==================================================================
    wire                        dmac_boot_from_pc       ;
    wire      [31:0]            dmac_boot_addr          ;
    wire                        dmac_manager_ns         ;
    wire      [ 7:0]            dmac_irq_ns             ;
    wire      [19:0]            dmac_periph_ns          ;
    wire      [19:0]            dmac_enable_tc_on_flush ;
    wire      [ 7:0]            dmac_irq                ;

    assign  o_irq_dmac0 = dmac_irq[0];
    assign  o_irq_dmac1 = dmac_irq[1];
    assign  o_irq_dmac2 = dmac_irq[2];
    assign  o_irq_dmac3 = dmac_irq[3];
    assign  o_irq_dmac4 = dmac_irq[4];
    assign  o_irq_dmac5 = dmac_irq[5];
    assign  o_irq_dmac6 = dmac_irq[6];
    assign  o_irq_dmac7 = dmac_irq[7];

	wrap_arm_dma330	#( .DMA_PCH (PDMA_CH))
	u_wrap_arm_dma330 (
	    // Global Signals
		.i_clk					(i_clk_mclk_dma             ),
		.i_rstn					(i_rstn_mclk_dma            ),

        // interrupt outputs
		.o_irq					(dmac_irq                   ),
		.o_irq_abort			(o_irq_abort_dmac           ),

        // Peripheral I/F - PL080-style
        // Request inputs from PL080-style peripheral
		.i_dmac_breq			(i_dmac_breq                ),
		.i_dmac_sreq			(i_dmac_sreq                ),
		.i_dmac_lbreq			(i_dmac_lbreq               ),
		.i_dmac_lsreq			(i_dmac_lsreq               ),

        // Response outputs to PL080-style peripheral
		.o_dmac_clr				(o_dmac_clr                 ),
		.o_dmac_tc				(o_dmac_tc                  ),

        // MISC
		.i_boot_from_pc			(dmac_boot_from_pc          ),
		.i_boot_addr			(dmac_boot_addr             ),
		.i_boot_manager_ns		(dmac_manager_ns            ),
		.i_boot_irq_ns			(dmac_irq_ns                ),
		.i_boot_periph_ns		(dmac_periph_ns             ),
		.i_enable_tc_on_flush	(dmac_enable_tc_on_flush    ),

        // AXI Interface
	    // Write Address Channel
		.o_mst_awid				(o_awid_dma330_s1           ),
		.o_mst_awaddr			(o_awaddr_dma330_s1         ),
		.o_mst_awlen			(o_awlen_dma330_s1          ),
		.o_mst_awsize			(o_awsize_dma330_s1         ),
		.o_mst_awburst			(o_awburst_dma330_s1        ),
		.o_mst_awlock			(o_awlock_dma330_s1         ),
		.o_mst_awcache			(o_awcache_dma330_s1        ),
		.o_mst_awprot			(o_awprot_dma330_s1         ),
		.o_mst_awvalid			(o_awvalid_dma330_s1        ),
		.i_mst_awready			(i_awready_dma330_s1        ),

	    // Write Data Channel
		.o_mst_wid				(o_wid_dma330_s1            ),
		.o_mst_wdata			(o_wdata_dma330_s1          ),
		.o_mst_wstrb			(o_wstrb_dma330_s1          ),
		.o_mst_wlast			(o_wlast_dma330_s1          ),
		.o_mst_wvalid			(o_wvalid_dma330_s1         ),
		.i_mst_wready			(i_wready_dma330_s1         ),

	    // Write Response Channel
		.i_mst_bid				(i_bid_dma330_s1            ),
		.i_mst_bresp			(i_bresp_dma330_s1          ),
		.i_mst_bvalid			(i_bvalid_dma330_s1         ),
		.o_mst_bready			(o_bready_dma330_s1         ),

	    // Read Address Channel
		.o_mst_arid				(o_arid_dma330_s1           ),
		.o_mst_araddr			(o_araddr_dma330_s1         ),
		.o_mst_arlen			(o_arlen_dma330_s1          ),
		.o_mst_arsize			(o_arsize_dma330_s1         ),
		.o_mst_arburst			(o_arburst_dma330_s1        ),
		.o_mst_arlock			(o_arlock_dma330_s1         ),
		.o_mst_arcache			(o_arcache_dma330_s1        ),
		.o_mst_arprot			(o_arprot_dma330_s1         ),
		.o_mst_arvalid			(o_arvalid_dma330_s1        ),
		.i_mst_arready			(i_arready_dma330_s1        ),

	    // Read Data Channel
		.i_mst_rid				(i_rid_dma330_s1            ),
		.i_mst_rdata			(i_rdata_dma330_s1          ),
		.i_mst_rresp			(i_rresp_dma330_s1          ),
		.i_mst_rlast			(i_rlast_dma330_s1          ),
		.i_mst_rvalid			(i_rvalid_dma330_s1         ),
		.o_mst_rready			(o_rready_dma330_s1         ),

	    // Non-Secure APB Interface
		.i_pclk_en				(i_clken_dma330             ),
		.i_ns_psel				(dma330_nsec_psel           ),
		.i_ns_penable			(dma330_nsec_penable        ),
		.i_ns_pwrite			(dma330_nsec_pwrite         ),
		.i_ns_pwdata			(dma330_nsec_pwdata         ),
		.i_ns_paddr				({20'b0,dma330_nsec_paddr}  ),
		.o_ns_prdata			(dma330_nsec_prdata         ),
		.o_ns_pready			(dma330_nsec_pready         ),

 	    // Secure APB Interface
		.i_se_psel				(dma330_sec_psel            ),
		.i_se_penable			(dma330_sec_penable         ),
		.i_se_pwrite			(dma330_sec_pwrite          ),
		.i_se_pwdata			(dma330_sec_pwdata          ),
		.i_se_paddr				({20'b0,dma330_sec_paddr}   ),
		.o_se_prdata			(dma330_sec_prdata          ),
		.o_se_pready			(dma330_sec_pready          )
    );

	//==================================================================
	// NFCON
	//==================================================================

	assign  o_nfc_nce_a 	    =   nfc_nce[0];
	assign  o_nfc_data_a	    =   nfc_flash_ioout[7:0];
	assign  o_nfc_data_oe       =   {8{~nfc_flash_dir[0]}};


    assign  o_irq_nfc_rnb         = ~irq_nfc_rnb; 

	NFCON 
    u_alp_nand_m2 (
	    // power on configuration signals
	    .CfgStone16KB	(nfc_cfgstone16kb           ),
	    .CfgEnbNFCON	(nfc_cfgenbnfcon            ), // enable boot loader
    	.CfgAdvFlash	(i_nfc_cfgadvflash_y        ), // To support 1G, 2G-bit advanced nand flash memory
    	.CfgAddCycle	(i_nfc_cfgaddrcycle_y       ), // nand flash memory address step ( 3step, 4step )
    	.CfgPageSize	(i_nfc_cfgpagesize_y        ), // nand flash memory page size ( 256bytes, 512bytes )
    	.CfgBusWidth	(1'b0                       ), // bus width setting ( 8bit, 16bit )
    	.Boot_TACLS		(nfc_boot_tacls             ), // tacls setting for nand boot loader operation
    	.Boot_TWRPH0	(nfc_boot_twrph0            ), // twrph0 setting for nand boot loader operation
    	.Boot_TWRPH1	(nfc_boot_twrph1            ), // twrph1 setting for nand boot loader operation
    	.ENDIAN			(nfc_endian                 ), // read endian setting

    	// interrupt signals
    	.BootDone		(nfc_boot_done              ), // indicates whether auto boot done to ahb arbiter
    	.NFlash_RnB		(irq_nfc_rnb                ), // indicates nand flash memory states to pcmcia ( 0:busy, 1:ready )
    	.INTREQ			(o_irq_nfc                  ), // interrupt request source

    	// reset & clock
    	.HCLK			(i_clk_nfc                  ),
    	.HRESETn		(i_rstn_nfc                 ),

    	// ahb slave
    	.HADDRston		(24'h0                      ),
    	.HTRANSston		(1'b0                       ),
    	.HWRITEston		(1'b0                       ),
    	.HSIZEston		(2'b0                       ),
   		.HRDATAston		(                           ),
    	.HWDATAston		(32'h0                      ),
    	.HREADYinston	(1'b0                       ),
    	.HSELston		(1'b0                       ),
    	.HREADYston		(                           ),
    	.HRESPston		(                           ),

    	// ahb slave --> nand flash controller boot stepping stone Register
    	.HADDRsfr		({8'h0, nfc_haddr}          ),
    	.HTRANSsfr		(nfc_htrans[1]              ),
    	.HWRITEsfr		(nfc_hwrite                 ),
    	.HSIZEsfr		(nfc_hsize[1:0]             ),
    	.HRDATAsfr		(nfc_hrdata                 ),
    	.HWDATAsfr		(nfc_hwdata                 ),
    	.HREADYinsfr	(nfc_hready                 ),
    	.HSELsfr		(nfc_htrans[1]              ),
    	.HREADYsfr		(nfc_hready                 ),
    	.HRESPsfr		(nfc_hresp                  ),

    	// nand flash memory interface signals
    	.Flash_IOin		({8'b0, i_nfc_data_y}       ), // nand flash memory input data bus
    	.Flash_RnB		(i_nfc_rnb_y                ), // nand flash memory rnb signal
    	.Flash_CLE		(o_nfc_cle_a                ), // nand flash memory cle signal
    	.Flash_ALE		(o_nfc_ale_a                ), // nand flash memory ale signal
    	.Flash_nCE		(nfc_nce                    ), // nand flash memory nce signal
    	.Flash_nRE		(o_nfc_nre_a                ), // nand flash memory nre signal
    	.Flash_nWE		(o_nfc_nwe_a                ), // nand flash memory nwe signal
    	.Flash_IOout	(nfc_flash_ioout            ), // nand flash memory output data bus [15:0]
    	.Flash_DIR		(nfc_flash_dir              ), // nand flash memory data direction control ( 0:output, 1:input )

    	// external bus interface signals ( ebi ),
    	.ExtBusReq		(nfc_extbusreq              ), // ebi request signal
    	.ExtBusGnt		(nfc_extbusgnt              ), // ebi grant signal
    	.ExtBackOff		(nfc_extbackoff             ), // ebi backoff signal

    	// stepping stone interface signals
    	.STON_WEN		(nfcon_ston_wen             ), // sram write enable signal
    	.STON_A			(nfcon_ston_a               ), // sram sram address signal
    	.STON_BWEN		(                           ), // sram bit write enable signal
    	.STON_DOUT		(nfcon_ston_dout            ),

    	.STON_CK		(nfcon_ston_clk             ), // sram clock signal for stepping stone #0
    	.STON_CSN		(nfc_ston_csn0              ), // sram chip selection for stepping stone #0
    	.STON_Din		(32'b0                      ), // sram data input signal for stepping stone #0
    	.STON_CSNout	(nfcon_ston_nce             ), // sram chip selection signal for stepping stone #0
    	.MCS0_in		(1'b0                       ), // sram margin control of sense amp #0
    	.MCS0_out		(                           ),
    	.PDN0_in		(1'b1                       ), // sram active low power down mode #0
    	.PDN0_out		(                           ),
    	.SLN0_in		(1'b1                       ), // srma active sleep mode #0
    	.SLN0_out		(                           ),

		// test signals
    	.SCAN_TEST_MODE (i_test_mode                ) // scan test mode
	);

    //==================================================================
    // SFMC
    //==================================================================

    wire    [7:0]   sfmc_data_a ;
    wire    [7:0]   sfmc_data_y ;
    wire    [7:0]   sfmc_data_oe;

    sfmc_top 
    u_sfmc_top (
        .i_ema          (i_ema                      ),
        .i_hclk         (i_clk_sfmc                 ),  // AHB Bus Clock
        .i_hresetn      (i_rstn_sfmc                ),  // AHB Bus Reset
        .i_fclk         (i_clk_sfmc_flash           ),  // Flash Cont Clock
 	    .i_fresetn      (i_rstn_sfmc_flash          ),  // Flash Cont Reset
 	    .i_pad_sclk     (i_sfmc_sclk_y              ),  // sclk pad inputinput
 	    .i_scan_mode    (i_test_mode                ),
        .i_scan_clk     (i_clk_sfmc                 ),
        .i_scan_rstn    (i_rstn_sfmc                ),
 	    .o_irq          (o_irq_sfmc                 ),
        .i_boot_enb     (sfmc_boot_en               ),
        .o_boot_done    (sfmc_boot_done             ),
        .i_auto_htrans  (i_htrans_sfmc_m3           ),
        .i_auto_hwrite  (i_hwrite_sfmc_m3           ),
        .i_auto_hburst  (i_hburst_sfmc_m3           ),
        .i_auto_hsize   (i_hsize_sfmc_m3            ),
        .i_auto_haddr   (i_haddr_sfmc_m3            ),
        .i_auto_hwdata  (i_hwdata_sfmc_m3           ),
        .o_auto_hready  (o_hready_sfmc_m3           ),
        .o_auto_hrdata  (o_hrdata_sfmc_m3           ),
        .o_auto_hresp   (o_hresp_sfmc_m3            ),
        .i_manu_htrans  (sfmc_htrans                ),
        .i_manu_hwrite  (sfmc_hwrite                ),
        .i_manu_hburst  (sfmc_hburst                ),
        .i_manu_hsize   (sfmc_hsize                 ),
        .i_manu_haddr   ({16'b0, sfmc_haddr}        ),
        .i_manu_hwdata  (sfmc_hwdata                ),
        .o_manu_hready  (sfmc_hready                ),
        .o_manu_hrdata  (sfmc_hrdata                ),
        .o_manu_hresp   (sfmc_hresp                 ),
//        .o_flash_rstn   (o_sfmc_rstn_a              ),  
        .o_flash_rstn   (                           ),
        .o_flash_sclk   (o_sfmc_sclk_a              ),  
        .o_flash_csn    (o_sfmc_csn_a               ),  
        .o_flash_s      (sfmc_data_a                ),  
        .i_flash_s      (sfmc_data_y                ),  
        .o_flash_s_oen  (sfmc_data_oe               ),  
        .i_flash_dqs    (1'b0                       )   // Flash Memory DQS
    );

    assign o_sfmc_sclk_oe   = 1'b1                      ;
    assign o_sfmc_data_a    = sfmc_data_a[3:0]          ;
    assign sfmc_data_y      = {4'h0, i_sfmc_data_y[3:0]};
    assign o_sfmc_data_oe   = sfmc_data_oe[3:0]         ;

	//==================================================================
	// ROM
	//==================================================================
	assign bus_matrix_hrespm0[1] = 1'b0;

	alp_ahb_introm #( 
            .DW     (32),
            .MEM_KB (16))
    u_alp_ahb_introm (
	    .i_ema			(i_ema                  ),
	    .i_clk			(i_clk_rom              ),
	    .i_rstn         (i_rstn_rom             ),
	    // AHB I/F
	    .i_htrans		(bus_matrix_htransm0[1] ),
	    .i_hwrite		(bus_matrix_hwritem0    ),
	    .i_hsize		(bus_matrix_hsizem0     ),
	    .i_haddr		(bus_matrix_haddrm0     ),
	    .i_hwdata		(bus_matrix_hwdatam0    ),
	    .i_hready		(bus_matrix_hreadym0    ),
	    .o_hresp		(bus_matrix_hrespm0[0]  ),
	    .o_hready		(bus_matrix_hreadyoutm0 ),
	    .o_hrdata		(bus_matrix_hrdatam0    )
	);


    //==================================================================
    // SRAM
    //==================================================================

	assign bus_matrix_hrespm1[1] = 1'b0;

    alp_ahb_intram_nfcon #(
            .DW     (32),
            .MEM_KB (512))
    u_alp_ahb_intram_nfcon (
        .i_ema		    (i_ema),
        .i_test_mode    (i_test_mode),
        .i_clk		    (i_clk_sram),
        .i_rstn		    (i_rstn_sram),
        .i_sram_sel		(~nfc_boot_done),
        .i_sram_wen		(nfcon_ston_wen),
        .i_sram_addr	(nfcon_ston_a),
        .i_sram_din		(nfcon_ston_dout),
        .i_sram_clk		(nfcon_ston_clk),
        .i_sram_csn		(nfcon_ston_nce),
        .i_htrans		(bus_matrix_htransm1[1]),
        .i_hwrite		(bus_matrix_hwritem1),
        .i_hsize		(bus_matrix_hsizem1),
        .i_haddr		(bus_matrix_haddrm1),
        .i_hwdata		(bus_matrix_hwdatam1),
        .i_hready		(bus_matrix_hreadym1),
        .o_hresp		(bus_matrix_hrespm1[0]),
        .o_hrdata		(bus_matrix_hrdatam1),
        .o_hready       (bus_matrix_hreadyoutm1)
    ); 

    //==================================================================
    // APB Dummy for debug port
    //==================================================================
    apb_dummy 
    u_apb_dummy (
        .i_pclk			        (i_clk_bus_m0       ),
        .i_presetn              (i_rstn_bus_m0      ),
        .i_psel			        (debug_port_psel    ),
        .i_penable		        (debug_port_penable ),
        .i_pwrite		        (debug_port_pwrite  ),
        .i_paddr		        (debug_port_paddr   ),
        .i_pwdata		        (debug_port_pwdata  ),
    	.o_prdata		        (debug_port_prdata  )
    );

    //==================================================================
	// SYS_CTRL
    //==================================================================
	cpu_sys_ctrl
	u_cpu_sys_ctrl(
        .i_apb_pclk			    (i_clk_bus_m0       ),
        .i_apb_prstn		    (i_rstn_bus_m0      ),
        .i_apb_psel			    (sys_psel           ),
        .i_apb_penable		    (sys_penable        ),
        .i_apb_pwrite		    (sys_pwrite         ),
        .i_apb_paddr		    (sys_paddr          ),
        .i_apb_pwdata		    (sys_pwdata         ),
        .o_apb_prdata		    (sys_prdata         ),
        .o_nfc_cfgstone8kb      (nfc_cfgstone16kb   ),
        .o_nfc_boot_tacls       (nfc_boot_tacls     ),
        .o_nfc_boot_twrph0      (nfc_boot_twrph0    ),
        .o_nfc_boot_twrph1      (nfc_boot_twrph1    ),
        .o_cpu_hauser           (o_hauser_mat2cpu_s0),
        .o_dma_rd_user          (o_aruser_dma330_s1 ),
        .o_dma_wr_user          (o_awuser_dma330_s1 )
	);

    //==================================================================
	// TIE_CTRL
    //==================================================================
	cpu_tie_ctrl
	u_cpu_tie_ctrl
	(
        .i_apb_pclk			        (i_clk_bus_m0               ),
        .i_apb_prstn		        (i_rstn_bus_m0              ),
        .i_apb_psel			        (tie_psel                   ),
        .i_apb_penable		        (tie_penable                ),
        .i_apb_pwrite		        (tie_pwrite                 ),
        .i_apb_paddr		        (tie_paddr                  ),
        .i_apb_pwdata		        (tie_pwdata                 ),
        .o_apb_prdata		        (tie_prdata                 ),
        .o_dma330_boot_irq_ns       (dmac_irq_ns                ),
        .o_dma330_boot_manager_ns   (dmac_manager_ns            ),
        .o_dma330_boot_from_pc      (dmac_boot_from_pc          ),
        .o_dma330_boot_periph_ns    (dmac_periph_ns             ),
        .o_dma330_enable_tc_on_flush(dmac_enable_tc_on_flush    ),
        .o_dma330_boot_addr         (dmac_boot_addr             ),
        .o_cm3_exrespd              (cm3_d_exresp               ),
        .o_cm3_exresps              (cm3_s_exresp               ),
        .o_cm3_sleepholdreqn        (cm3_sleepholdreqn          ),
        .o_cm3_auxfault             (cm3_auxfault               ),
        .o_cm3_bigend               (cm3_bigend                 ),
        .o_cm3_tsclkchange          (cm3_tsclkchange            ),
        .o_cm3_mpudisable           (cm3_mpudisable             ),
        .o_cm3_isolateN             (cm3_isolaten               ),
        .o_cm3_wicenreq             (cm3_wicenreq               ),
        .o_cm3_cdbgpwrupack         (cm3_cdbgpwrupack           ),
        .o_cm3_dbgen                (cm3_dbgen                  ),
        .o_cm3_fixhmastertype       (cm3_fixhmastertype         ),
        .o_cm3_stcalib              (cm3_stcalib                ),
        .i_cm3_memattri             (cm3_i_memattr              ),
        .i_cm3_brchstat             (cm3_brchstat               ),
        .i_cm3_hmasterd             (cm3_d_hmaster              ),
        .i_cm3_memattrd             (cm3_d_memattr              ),
        .i_cm3_exreqd               (cm3_d_exreq                ),
        .i_cm3_hmasters             (cm3_s_hmaster              ),
        .i_cm3_memattrs             (cm3_s_memattr              ),
        .i_cm3_hmastlocks           (cm3_s_hmastlock            ),
        .i_cm3_exreqs               (cm3_s_exreq                ),
        .i_cm3_sleeping             (cm3_sleeping               ),
        .i_cm3_sleepdeep            (cm3_sleepdeep              ),
        .i_cm3_gatehclk             (cm3_gatehclk               ),
        .i_cm3_sleepholdackn        (cm3_sleepholdackn          ),
        .i_cm3_sysresetreq          (cm3_sysresetreq            ),
        .i_cm3_lockup               (cm3_lockup                 ),
        .i_cm3_wakeup               (cm3_wakeup                 ),
        .i_cm3_wicenack             (cm3_wicenack               ),
        .i_cm3_cdbgpwrupreq         (cm3_cdbgpwrupreq           ),
        .i_cm3_currpri              (cm3_currpri                ),
        .i_cm3_internalstate        (cm3_internalstate          ),
        .o_nfc_endian               (nfc_endian                 ),
        .o_nfc_extbusgnt            (nfc_extbusgnt              ),
        .o_nfc_extbackoff           (nfc_extbackoff             ),
        .o_nfc_ston_csn0            (nfc_ston_csn0              ),
        .i_nfc_extbusreq            (nfc_extbusreq              )
    );


endmodule
