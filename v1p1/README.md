# tool_core_gen : Core Generator


# Excel Doc
## Instance Sheet

Col | Description
:---|:-
Direction |(auto) port dir
Port name |(auto) port name
MSB       |(auto) msb bit
LSB       |(auto) lsb bit
inst_name |연결하려고 하는 instance name
port_name |연결하려고 하는 instance의 port name
vip-clock_inst|(alp_vip) alp_vip clock과 연결하려고 하는 instance name
vip-clock_port|(alp_vip) alp_vip clock과 연결하려고 하는 port name
vip-reset_inst|(alp_vip) alp_vip reset과 연결하려고 하는 instance name
vip-reset_port|(alp_vip) alp_vip reset과 연결하려고 하는 port name

- (auto)는 tool 상에서 자동 생성하는 col이다.
- (alp_vip)는 port_name이 $alp_vip 일때만 사용하는 col 이다.

## Example

Direction |Port name|MSB|LSB|inst_name|port_name
:-|:-|:-|:-|:-|:-
input      |i_clk             |0  |0 |- |-
bus$mst    |apb$$_aud_m9      |32 |0 |- |-
bus$slv    |axi$$_cpu2peri_s0 |32 |0 |- |-
[bus_type] |[bus_symbol]      |32 |0 |- |-


## alp_vip connection

inst_name | port_name |clock_inst|clock_port|reset_inst|reset_port
:-|:-|:-|:-|:-|:-
u_peri |i_clk    |-     |-          |-     |-
u_vip0 |$alp_vip |u_crm |o_clk_peri |u_crm |o_rstn_peri
 .     |[symbol] |- |- |- |-








## Lint
instance 가 본인 자신일때 error 처리
$alp_vip 작성했을 때 vip_clock, vip_reset 은 반드시 작성해야 된다.


## alp_gen
con_pin_to_pin(inst, port, msb, lsb, inst, port, msb, lsb)
- inst 가 공백이면 pin_to_top 으로 변경


## Overview
Clock & Reset Management RTL 을 생성하기 위한 script 이다.
본 script를 수행하려면 아래와 같은 Input file이 필요하다.
수행 결과 Output file이 생성된다.
Simulation 을 수행하기 위해서는 Alpha CRC Lib File 이 필요하다.



# License
This library is licensed under jong-min kim
