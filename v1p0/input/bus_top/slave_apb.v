module slave_apb (

  paddr_m9,
  pselx_m9,
  penable_m9,
  pwrite_m9,
  prdata_m9,
  pwdata_m9,
  pready_m9,
  pslverr_m9,

 
);


// Instance: u_cd_aud, Port: aud_m9

input  [31:0] paddr_m9;
input         psel_m9;
input         penable_m9;
input         pwrite_m9;
output [31:0] prdata_m9;
input  [31:0] pwdata_m9;
output        pready_m9;
output        pslverr_m9;


endmodule
