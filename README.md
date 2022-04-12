# tool_core_gen

# Version
v1p0
- tool_core_gen 에서 alpgen write_rtl 시 json 을 직접 받아 생성함 (json file생성 안함으로 수정)
- top port 연결 bug fix
- RTL comment 기능 추가

v1p1
- write file 할때 folder 가 없을 경우 자동 생성



# Todo
Lint Check
- project file에서 perfix가 중복되면 error report
- instance 가 본인 자신일때 error 처리
- $alp_vip 작성했을 때 vip_clock, vip_reset 은 반드시 작성해야 된다.

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
