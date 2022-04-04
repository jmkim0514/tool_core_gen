# tools_core_gen : Clock & Reset Generator

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
