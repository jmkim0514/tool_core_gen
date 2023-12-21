module mvp_crm_cpu (
    input              i_test_bypass,
    input              i_rstn_peri,
    input              i_apb_pclk,
    input              i_apb_prstn,
    input              i_apb_psel,
    input              i_apb_penable,
    input              i_apb_pwrite,
    input   [ 11:  0]  i_apb_paddr,
    input   [ 31:  0]  i_apb_pwdata,
    output  [ 31:  0]  o_apb_prdata,
    input              i_clk_cpu,
    input              i_clk_cpu_peri,
    input              i_clk_cpu2peri,
    input              i_clk_main_system,
    input              i_clk_cpu2mvp,
    input              i_clk_cpu2main,
    input              i_clk_sfmc_pad_y,
    input              i_clk_xtal_y,
    input              i_test_clk200,
    input              i_test_clk100,
    output             o_clk_cpu,
    output             o_rstn_cpu,
    output             o_clk_cpu_bus,
    output             o_rstn_cpu_bus,
    output             o_clk_sram,
    output             o_rstn_sram,
    output             o_clk_rom,
    output             o_rstn_rom,
    output             o_mclk_dma,
    output             o_rstn_mclk_dma,
    output             o_sclk_dma,
    output             o_rstn_sclk_dma,
    output             o_clk_cpu_peri,
    output             o_rstn_cpu_peri,
    output             o_clk_nfc,
    output             o_rstn_nfc,
    output             o_clk_sfmc,
    output             o_rstn_sfmc,
    output             o_clk_sfmc_flash,
    output             o_rstn_sfmc_flash,
    output             o_clk_tracein,
    output             o_clk_cpu2peri,
    output             o_rstn_cpu2peri,
    output             o_clk_main_system,
    output             o_rstn_main_system,
    output             o_clk_cpu2mvp,
    output             o_rstn_cpu2mvp,
    output             o_clk_cpu2main,
    output             o_rstn_cpu2main,
    output             o_clk_sfmc_pad,
    output             o_clken_dma330,
    output             o_cpu_stclk,
    input              i_rstn_mem,
    input              i_rstn_bus,
    input              i_rstn_ip,
    input              i_rstn_core,
    input              i_scan_clk,
    input              i_scan_mode,
    input              i_scan_rstn
);

    wire           w0_o_out;
    wire           w1_o_out;
    wire           w2_o_out;
    wire           w3_o_out;
    wire           w4_o_out;
    wire           w5_o_clk;
    wire           w6_o_clk;
    wire           w8_o_out;
    wire           w9_o_out;
    wire           w10_o_out;
    wire           w11_o_clk;
    wire           w12_o_clk;
    wire           w13_o_clk;
    wire           w14_o_out;
    wire           w15_o_out;
    wire           w16_o_out;
    wire           w17_o_out;
    wire           w18_o_out;
    wire           w20_o_out;
    wire           w21_o_out;
    wire           w22_o_out;
    wire    [1:0]  reg_o_u_div_sfmc_flash_div;
    wire           reg_o_u_div_sfmc_flash_update;
    wire           reg_o_clken_u_crg_sram;
    wire           reg_o_clken_u_crg_rom;
    wire           reg_o_clken_u_crg_mclk_dma;
    wire           reg_o_clken_u_crg_sclk_dma;
    wire           reg_o_clken_u_crg_nfc;
    wire           reg_o_clken_u_crg_sfmc;
    wire           reg_o_clken_u_crg_sfmc_flash;
    wire           reg_o_clken_u_crg_cpu2peri;
    wire           reg_o_clken_u_crg_cpu2mvp;
    wire           reg_o_clken_u_crg_cpu2main;
    wire           reg_o_clken_u_crg_sfmc_pad;
    wire           reg_o_rsten_u_crg_sram;
    wire           reg_o_rsten_u_crg_rom;
    wire           reg_o_rsten_u_crg_mclk_dma;
    wire           reg_o_rsten_u_crg_sclk_dma;
    wire           reg_o_rsten_u_crg_nfc;
    wire           reg_o_rsten_u_crg_sfmc;
    wire           reg_o_rsten_u_crg_sfmc_flash;
    wire           reg_o_rsten_u_crg_cpu2peri;
    wire           reg_o_rsten_u_crg_cpu2mvp;
    wire           reg_o_rsten_u_crg_cpu2main;


    alp_clk_buf u_buf_clk_cpu (
        .i_in                        (i_clk_cpu),
        .o_out                       (w0_o_out)
    );

    alp_clk_buf u_buf_clk_cpu_bus (
        .i_in                        (i_clk_cpu),
        .o_out                       (w1_o_out)
    );

    alp_clk_buf u_buf_clk_sram (
        .i_in                        (i_clk_cpu),
        .o_out                       (w2_o_out)
    );

    alp_clk_buf u_buf_clk_rom (
        .i_in                        (i_clk_cpu),
        .o_out                       (w3_o_out)
    );

    alp_clk_buf u_buf_mclk_dma (
        .i_in                        (i_clk_cpu),
        .o_out                       (w4_o_out)
    );

    alp_clk_mux2 u_test_mux0 (
        .i_sel                       (i_test_bypass),
        .i_clk0                      (w0_o_out),
        .i_clk1                      (i_test_clk200),
        .o_clk                       (w5_o_clk)
    );

    alp_clk_div2 u_div2_cpu (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w5_o_clk),
        .o_clk                       (w6_o_clk)
    );

    alp_clk_inv u_inv_clken_dma330 (
        .i_in                        (w6_o_clk),
        .o_out                       (o_clken_dma330)
    );

    alp_clk_buf u_buf_clk_cpu_peri (
        .i_in                        (i_clk_cpu_peri),
        .o_out                       (w8_o_out)
    );

    alp_clk_buf u_buf_clk_nfc (
        .i_in                        (i_clk_cpu_peri),
        .o_out                       (w9_o_out)
    );

    alp_clk_buf u_buf_clk_sfmc (
        .i_in                        (i_clk_cpu_peri),
        .o_out                       (w10_o_out)
    );

    alp_clk_mux2 u_test_mux1 (
        .i_sel                       (i_test_bypass),
        .i_clk0                      (i_clk_cpu_peri),
        .i_clk1                      (i_test_clk100),
        .o_clk                       (w11_o_clk)
    );

    alp_clk_divm4
        #(.DEFAULT(0))
    u_div_sfmc_flash (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w11_o_clk),
        .i_div                       (reg_o_u_div_sfmc_flash_div),
        .i_update                    (reg_o_u_div_sfmc_flash_update),
        .o_clk                       (w12_o_clk)
    );

    alp_clk_div2 u_div2_clk_tracein (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w11_o_clk),
        .o_clk                       (w13_o_clk)
    );

    alp_clk_buf u_buf_clk_cpu2peri (
        .i_in                        (i_clk_cpu2peri),
        .o_out                       (w14_o_out)
    );

    alp_clk_buf u_buf_clk_main_system (
        .i_in                        (i_clk_main_system),
        .o_out                       (w15_o_out)
    );

    alp_clk_buf u_buf_clk_cpu2mvp (
        .i_in                        (i_clk_cpu2mvp),
        .o_out                       (w16_o_out)
    );

    alp_clk_buf u_buf_clk_cpu2main (
        .i_in                        (i_clk_cpu2main),
        .o_out                       (w17_o_out)
    );

    alp_clk_buf u_buf_clk_sfmc_pad (
        .i_in                        (i_clk_sfmc_pad_y),
        .o_out                       (w18_o_out)
    );

    alp_clk_inv u_inv_cpu_stclk (
        .i_in                        (i_clk_xtal_y),
        .o_out                       (o_cpu_stclk)
    );

    alp_clk_buf u_occ_point0 (
        .i_in                        (w6_o_clk),
        .o_out                       (w20_o_out)
    );

    alp_clk_buf u_occ_point1 (
        .i_in                        (w12_o_clk),
        .o_out                       (w21_o_out)
    );

    alp_clk_buf u_occ_point2 (
        .i_in                        (w13_o_clk),
        .o_out                       (w22_o_out)
    );

    alp_clk_crg u_crg_cpu (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w0_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (1'h1),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_core),
        .i_rsten2                    (1'h1),
        .o_clk                       (o_clk_cpu),
        .o_rstn                      (o_rstn_cpu),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_cpu_bus (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w1_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (1'h1),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_bus),
        .i_rsten2                    (1'h1),
        .o_clk                       (o_clk_cpu_bus),
        .o_rstn                      (o_rstn_cpu_bus),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_sram (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w2_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_sram),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_mem),
        .i_rsten2                    (reg_o_rsten_u_crg_sram),
        .o_clk                       (o_clk_sram),
        .o_rstn                      (o_rstn_sram),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_rom (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w3_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_rom),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_mem),
        .i_rsten2                    (reg_o_rsten_u_crg_rom),
        .o_clk                       (o_clk_rom),
        .o_rstn                      (o_rstn_rom),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_mclk_dma (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w4_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_mclk_dma),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (1'h1),
        .i_rsten2                    (reg_o_rsten_u_crg_mclk_dma),
        .o_clk                       (o_mclk_dma),
        .o_rstn                      (o_rstn_mclk_dma),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_sclk_dma (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w20_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_sclk_dma),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (1'h1),
        .i_rsten2                    (reg_o_rsten_u_crg_sclk_dma),
        .o_clk                       (o_sclk_dma),
        .o_rstn                      (o_rstn_sclk_dma),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_cpu_peri (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w8_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (1'h1),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_ip),
        .i_rsten2                    (1'h1),
        .o_clk                       (o_clk_cpu_peri),
        .o_rstn                      (o_rstn_cpu_peri),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_nfc (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w9_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_nfc),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_ip),
        .i_rsten2                    (reg_o_rsten_u_crg_nfc),
        .o_clk                       (o_clk_nfc),
        .o_rstn                      (o_rstn_nfc),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_sfmc (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w10_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_sfmc),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_ip),
        .i_rsten2                    (reg_o_rsten_u_crg_sfmc),
        .o_clk                       (o_clk_sfmc),
        .o_rstn                      (o_rstn_sfmc),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_sfmc_flash (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w21_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_sfmc_flash),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_ip),
        .i_rsten2                    (reg_o_rsten_u_crg_sfmc_flash),
        .o_clk                       (o_clk_sfmc_flash),
        .o_rstn                      (o_rstn_sfmc_flash),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg_clock u_crg_tracein (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w22_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (1'h1),
        .o_clk                       (o_clk_tracein),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_cpu2peri (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w14_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_cpu2peri),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (1'h1),
        .i_rsten2                    (reg_o_rsten_u_crg_cpu2peri),
        .o_clk                       (o_clk_cpu2peri),
        .o_rstn                      (o_rstn_cpu2peri),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_main_system (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w15_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (1'h1),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (i_rstn_ip),
        .i_rsten2                    (1'h1),
        .o_clk                       (o_clk_main_system),
        .o_rstn                      (o_rstn_main_system),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_cpu2mvp (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w16_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_cpu2mvp),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (1'h1),
        .i_rsten2                    (reg_o_rsten_u_crg_cpu2mvp),
        .o_clk                       (o_clk_cpu2mvp),
        .o_rstn                      (o_rstn_cpu2mvp),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg u_crg_cpu2main (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w17_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_cpu2main),
        .i_rsten0                    (1'h1),
        .i_rsten1                    (1'h1),
        .i_rsten2                    (reg_o_rsten_u_crg_cpu2main),
        .o_clk                       (o_clk_cpu2main),
        .o_rstn                      (o_rstn_cpu2main),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    alp_clk_crg_clock u_crg_sfmc_pad (
        .i_rstn                      (i_rstn_peri),
        .i_clk                       (w18_o_out),
        .i_clken0                    (1'h1),
        .i_clken1                    (1'h1),
        .i_clken2                    (reg_o_clken_u_crg_sfmc_pad),
        .o_clk                       (o_clk_sfmc_pad),
        .i_scan_mode                 (i_scan_mode),
        .i_scan_clk                  (i_scan_clk),
        .i_scan_rstn                 (i_scan_rstn),
        .i_test_bypass               (i_test_bypass)
    );

    regmap_mvp_crm_cpu u_regmap_mvp_crm_cpu (
        .i_crm_bypass                (i_test_bypass),
        .i_apb_pclk                  (i_apb_pclk),
        .i_apb_prstn                 (i_apb_prstn),
        .i_apb_psel                  (i_apb_psel),
        .i_apb_penable               (i_apb_penable),
        .i_apb_pwrite                (i_apb_pwrite),
        .i_apb_paddr                 (i_apb_paddr),
        .i_apb_pwdata                (i_apb_pwdata),
        .o_apb_prdata                (o_apb_prdata),
        .o_u_div_sfmc_flash_div      (reg_o_u_div_sfmc_flash_div),
        .o_u_div_sfmc_flash_update   (reg_o_u_div_sfmc_flash_update),
        .o_clken_u_crg_sram          (reg_o_clken_u_crg_sram),
        .o_clken_u_crg_rom           (reg_o_clken_u_crg_rom),
        .o_clken_u_crg_mclk_dma      (reg_o_clken_u_crg_mclk_dma),
        .o_clken_u_crg_sclk_dma      (reg_o_clken_u_crg_sclk_dma),
        .o_clken_u_crg_nfc           (reg_o_clken_u_crg_nfc),
        .o_clken_u_crg_sfmc          (reg_o_clken_u_crg_sfmc),
        .o_clken_u_crg_sfmc_flash    (reg_o_clken_u_crg_sfmc_flash),
        .o_clken_u_crg_cpu2peri      (reg_o_clken_u_crg_cpu2peri),
        .o_clken_u_crg_cpu2mvp       (reg_o_clken_u_crg_cpu2mvp),
        .o_clken_u_crg_cpu2main      (reg_o_clken_u_crg_cpu2main),
        .o_clken_u_crg_sfmc_pad      (reg_o_clken_u_crg_sfmc_pad),
        .o_rsten_u_crg_sram          (reg_o_rsten_u_crg_sram),
        .o_rsten_u_crg_rom           (reg_o_rsten_u_crg_rom),
        .o_rsten_u_crg_mclk_dma      (reg_o_rsten_u_crg_mclk_dma),
        .o_rsten_u_crg_sclk_dma      (reg_o_rsten_u_crg_sclk_dma),
        .o_rsten_u_crg_nfc           (reg_o_rsten_u_crg_nfc),
        .o_rsten_u_crg_sfmc          (reg_o_rsten_u_crg_sfmc),
        .o_rsten_u_crg_sfmc_flash    (reg_o_rsten_u_crg_sfmc_flash),
        .o_rsten_u_crg_cpu2peri      (reg_o_rsten_u_crg_cpu2peri),
        .o_rsten_u_crg_cpu2mvp       (reg_o_rsten_u_crg_cpu2mvp),
        .o_rsten_u_crg_cpu2main      (reg_o_rsten_u_crg_cpu2main)
    );

endmodule
