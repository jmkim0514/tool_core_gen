#!/user/de03/DE/util/anaconda3/bin/python3
# coding: utf-8
#===============================================================================
#  File name   : tool_core_gen.py
#  Version     : v 1.0
#  Description : core rtl generator
#  Simulator   : Python 3
#  Created by  : Kim jong-min
#  Date        : 2021/12/01     1'st Release
#===============================================================================
#  History
#-------------------------------------------------------------------------------
# 2021-12-01 Jongmin-Kim    v1p0 1st Release 
# 2022-04-12 Jongmin-Kim    v1p1 
#===============================================================================
import os
import sys
import time
import copy
import json
import argparse
from pprint import pprint
sys.path.append("../../lib/")
from modport_v0p1 import *
from alpgen_v0p2 import alpgen, alpgen_json, alpgen_excel

#------------------------------------------------------------------------------
# Function - @mark
#------------------------------------------------------------------------------
def get_argument():
    """get argument

    Returns:
        dict : return project file
    """
    parser = argparse.ArgumentParser(description="tool_core_gen: Core Generator. (jimmy@alpha-holdings.co.kr)")
    parser.add_argument('-p', dest="prj_file", required=False, help="project file")
    parser.add_argument('-o', dest="option", required=False, default='0', help="option")
    parser.add_argument('-c', dest="clean", action="store_true", required=False, help="remove the created file/folder")
    args = parser.parse_args()

    if args.clean:
        import platform
        my_os=platform.system()
        if(my_os =="Windows"):
            os.system("rmdir /s /q output")
        else:
            os.system("rm -rf output")
        print ('[LOG] remove the created file and folder')
        sys.exit(0)

    if os.path.isfile(args.prj_file)==False:
        print ("[LOG] *E, Can not find input file = ", args.prj_file)
        exit()

    # print(args.option)
    # exit()

    return get_json_data(args.prj_file), args.option

def get_json_data(config_path: str):
    with open(config_path, 'r', encoding='utf-8') as f:
        contents = f.read()
        #print (contents)
        while "/*" in contents:
            preComment, postComment = contents.split('/*', 1)
            contents = preComment + postComment.split('*/', 1)[1]
        while "//" in contents:
            preComment, postComment = contents.split('//', 1)
            contents = preComment + '\n' + postComment.split('\n', 1)[1]
        return json.loads(contents.replace("'", '"'))

def check_dir(file_path_i):
    file_path = os.path.dirname(file_path_i)
    if not os.path.isdir(file_path):
        os.makedirs(file_path)

# write_rtl function
# string to dictionary
def str_to_dic(i_str):
    dic = {}
    i_str = i_str.replace('{','').replace('}','')
    if len(i_str.strip())==0:
        return dic
    for i in i_str.split(','):
        key, value = i.split(':')
        dic[key.strip()] = int(value.strip())
    return dic
# HIER INFO --> Tree INFO
def scan_hier(i_row, i_col, list_hier):
    y = i_col
    dic = {}
    list_inst = []

    if list_hier[i_row][i_col+1]!=None:
        list_inst.append(list_hier[i_row][i_col+1])
        
    for x in range(i_row+1, len(list_hier)):
        if list_hier[x][y]==None:
            if list_hier[x][y+1]!=None:
                list_inst.append(list_hier[x][y+1])
        else:
            if list_hier[x][y].startswith('$'):
                break
    return (list_hier[i_row][i_col],list_inst)

def sort_top_ports(list_ports):
    dic = {}
    for dic_port in list_ports:
        port_name = dic_port['port']
        dir = dic_port['dir']
        msb = dic_port['msb']
        lsb = dic_port['lsb']
        try:
            if msb>dic[port_name]['msb']: dic[port_name]['msb'] = msb
            if lsb>dic[port_name]['lsb']: dic[port_name]['lsb'] = lsb
        except:
            dic[port_name] = {'port':port_name, 'dir': dir, 'msb':msb, 'lsb':lsb}
    return dic

def extract_module(i_json):
    mod_name = i_json['top']['modname']
    tmp = {}
    tmp_ports = []
    for dic_port in i_json['top']['ports']:
        tmp_port = {}
        tmp_port['port'] = dic_port['port']
        tmp_port['dir']  = dic_port['dir']
        tmp_port['msb']  = dic_port['msb']
        tmp_port['lsb']  = dic_port['lsb']
        tmp_port['bus_group'] = False
        tmp_ports.append(tmp_port)
    tmp['modname']  = mod_name
    tmp['filename'] = mod_name+'.v'
    tmp['ports']    = tmp_ports
    return tmp

def search_inst(sub_top, trg_inst, level):
    for inst in HIER_DIC[sub_top]:
        if inst==trg_inst:
            if level==0: return True, trg_inst
            else       : return trg_inst
            
        elif inst.startswith('$'):
            inst_name = search_inst(inst, trg_inst, level+1)
            if inst_name!='':
                #if level==1: return inst
                if level==0: return True, 'u_'+inst[1:]
                else       : return sub_top

    if level==0: return False, ''
    else       : return ''

def get_dir_port(dir_i, port_i):
    if   dir_i=='input' : return 'i_'+port_i
    elif dir_i=='output': return 'o_'+port_i
    elif dir_i=='inout' : return 'b_'+port_i
    else:
        print('[ERROR] *E, unknown port direction')
        exit()

def sub_top_p2p(sub_top, con, DTOP):
    m_inst = con['mst']['inst'];  s_inst = con['slv']['inst']
    m_port = con['mst']['port'];  s_port = con['slv']['port']
    m_msb  = con['mst']['msb'] ;  s_msb  = con['slv']['msb']
    m_lsb  = con['mst']['lsb'] ;  s_lsb  = con['slv']['lsb']
    m_flag, mst_sub_inst = search_inst(sub_top, m_inst, 0)
    s_flag, slv_sub_inst = search_inst(sub_top, s_inst, 0)

    dic_con = {}
    if mst_sub_inst==slv_sub_inst:
        return dic_con
    # mst/slv - same hierarchy
    if m_flag and s_flag:
        wire_name = DTOP[m_inst][m_port]['wire']
        mst_dir = DTOP[m_inst][m_port]['dir']
        slv_dir = DTOP[s_inst][s_port]['dir']
        if m_inst==mst_sub_inst: mst_port = m_port
        else                   : mst_port = get_dir_port(mst_dir, wire_name)
        if s_inst==slv_sub_inst: slv_port = s_port
        else                   : slv_port = get_dir_port(slv_dir, wire_name)
        dic_con['type'] = 'p2p'
        dic_con['mst']  = {'inst':mst_sub_inst, 'port':mst_port, 'msb':m_msb, 'lsb':m_lsb}
        dic_con['slv']  = {'inst':slv_sub_inst, 'port':slv_port, 'msb':s_msb, 'lsb':s_lsb}

    # mst - same hierarchy
    # slv - other hierarchy
    elif m_flag and s_flag==False:
        wire_name = DTOP[m_inst][m_port]['wire']

        top_dir = DTOP[m_inst][m_port]['dir']
        sub_dir = DTOP[m_inst][m_port]['dir']
        top_port = get_dir_port(top_dir, wire_name)

        if m_inst==mst_sub_inst: sub_port = m_port
        else                 : sub_port = get_dir_port(sub_dir, wire_name)
        dic_con['type'] = 'p2t'
        dic_con['mst']  = {'inst':mst_sub_inst, 'port':sub_port, 'msb':m_msb, 'lsb':m_lsb}
        dic_con['top']  = {                   'port':top_port, 'msb':s_msb, 'lsb':s_lsb, 'dir': top_dir}

    # mst - other hierarchy
    # slv - same hierarchy
    elif m_flag==False and s_flag:
        wire_name = DTOP[m_inst][m_port]['wire']
        top_dir = DTOP[s_inst][s_port]['dir']
        sub_dir = DTOP[s_inst][s_port]['dir']

        top_port = get_dir_port(top_dir, wire_name)

        if s_inst==slv_sub_inst: sub_port = s_port
        else                 : sub_port = get_dir_port(sub_dir, wire_name)

        dic_con['type'] = 'p2t'
        dic_con['mst']  = {'inst':slv_sub_inst, 'port':sub_port, 'msb':s_msb, 'lsb':s_lsb}
        dic_con['top']  = {                   'port':top_port, 'msb':m_msb, 'lsb':m_lsb, 'dir': top_dir}
    return dic_con

# sub_top : sub top name (ex: $hpdf_top)
def sub_top_p2t(sub_top, con, DTOP):
    m_inst = con['mst']['inst'];
    m_port = con['mst']['port'];  t_port = con['top']['port']
    m_msb  = con['mst']['msb'] ;  t_msb  = con['top']['msb']
    m_lsb  = con['mst']['lsb'] ;  t_lsb  = con['top']['lsb']
    
    m_flag, mst_sub_inst = search_inst(sub_top, m_inst, 0)
    m_dir  = DTOP[m_inst][m_port]['dir']
    dic_con = {}
    if m_flag:
        if m_inst!=mst_sub_inst :
            m_port = t_port
            m_msb  = t_msb
            m_lsb  = t_lsb
        dic_con['type'] = 'p2t'
        dic_con['mst']  = {'inst':mst_sub_inst, 'port':m_port, 'msb':m_msb, 'lsb':m_lsb}
        dic_con['top']  = {                   'port':t_port, 'msb':t_msb, 'lsb':t_lsb, 'dir': m_dir}
    return dic_con

def get_hierarchy(excel_top_sheet):
    l_hier = []
    for line in excel_top_sheet:
        if (line[0]=='HIERARCHY'): continue
        if (line[0]=='INSTANCE' ): break
        tmp = []
        for cell in line:
            tmp.append(cell)
        l_hier.append(tmp)
    tmp_hier_list = []
    tmp_hier_dic  = {}
    for y in range(len(l_hier[0])):    
        for x in range(len(l_hier)):
            if l_hier[x][y]==None: continue
            if l_hier[x][y].startswith('$'):
                tmp_hier_list.append(scan_hier(x, y, l_hier))
    tmp_hier_list.reverse()

    for sub_top, list_sub_inst in tmp_hier_list:
        tmp_hier_dic[sub_top] = list_sub_inst
    return tmp_hier_list, tmp_hier_dic

#HIER_LIST = [ ('$hpdf_ddr', ['u_ddr_bus']), ... , ('$top', ['$hpdf_peri', '$hpdf_hsp', '$hpdf_ddr'])]
#HIER_DIC = { '$hpdf_ddr': ['u_ddr_bus'], ... , '$top': ['$hpdf_peri', '$hpdf_hsp', '$hpdf_ddr']}
def update_hierarchy(cur_inst, new_inst, i_hier_list, i_hier_dic):
    o_hier_list = []
    for hpdf_top, list_sub in i_hier_list:
        for sub in list_sub:
            if sub==cur_inst:
                list_sub.append(new_inst)
                i_hier_dic[hpdf_top].append(new_inst)
        o_hier_list.append((hpdf_top, list_sub))
    return o_hier_list, i_hier_dic               

def write_excel(i_top_name, i_file_list, i_excel_name, i_out_folder):
    json = alpgen_json()
    for inst_name, wire_name, file_path, dic_param in i_file_list:
        top_port = modport(file_path, [], dic_param, 0)
        list_port = []
        for ps in top_port.port_info_set:
            for pi in ps:
                list_temp = []
                list_temp.append(pi.name)
                list_temp.append(pi.dir)
                list_temp.append(pi.msb)
                list_temp.append(pi.lsb)
                list_port.append(list_temp)
            module_name = pi.module_name

        json.add_module(module_name, file_path, list_port)
        json.add_instance(inst_name, module_name, wire_name, dic_param)
        json.add_top(i_top_name, [])

    # json_file_name = os.path.join(i_out_folder, i_top_name)+'.rtl.json'
    excel_file_name = os.path.join(i_out_folder, i_excel_name)
    # make json file
    # json.write_json(json_file_name)
    # make excel doc
    # gen = alpgen(json_file_name)
    gen = alpgen(json.get_json())

    check_dir(excel_file_name)
    gen.write_excel_group(excel_file_name)

SUB_TOP_LIST = []    # json_sub object list
def write_rtl (i_excel_name, i_out_folder, enb_json_i):
    global HIER_DIC
    SUB_TOP_LIST = []
    HIER_LIST = []  # format = [ $hpdf_0: [inst_0, inst_1], $hpdf_1: [inst_2, inst_3], $top: [$hpdf_0, $hpdf_1] ]
    HIER_DIC  = {}  # format = { $hpdf_0: [inst_0, inst_1], $hpdf_1: [inst_2, inst_3], $top: [$hpdf_0, $hpdf_1] }, global
    dic_sub_module = {}  # [ {module_name: {'modname':, 'filename', 'ports':['name', 'dir':, 'msb':, 'lsb', 'bus_group':False]}}]
    file_excel = os.path.join(i_out_folder, i_excel_name)
    file_json  = os.path.join(i_out_folder, i_excel_name)+'.json'
    print ('[LOG]--------------------------------')
    print ('[LOG] RTL Generation')
    print ('[LOG] read excel file')
    print ('[LOG]   - excel doc  = '+file_excel)
    bg = alpgen_excel(file_excel)
    dic_excel = bg.read_excel_format_0()
    json_ref = alpgen(file_json)
    json_ref.DEBUG = 1
    HIER_LIST, HIER_DIC = get_hierarchy(dic_excel['$top'])
    #---------------------------------------------------------------
    # Excel Connection Info --> Add json_ref
    #---------------------------------------------------------------
    for inst_name in dic_excel:
        if inst_name=='$top':
            continue
        # dic_port = {'dir':, 'port':, 'msb':, 'lsb':, 'con_inst':, 'con_port':, 'vip_clock':, 'vip_reset':}
        for di in dic_excel[inst_name]:
            if di['con_port']==None:
                continue
            if (di['con_port']=='$alp_vip'):
                # generate alp_vip clock/reset top port
                if di['vip_clock_inst']==None and di['vip_clock_port']!=None:
                    json_ref.append_top_port(di['vip_clock_port'], 'input', 0, 0)
                if di['vip_reset_inst']==None and di['vip_reset_port']!=None:
                    json_ref.append_top_port(di['vip_reset_port'], 'input', 0, 0)
                # register alp_vip connection
                bus_inst = inst_name
                bus_sym = di['port']
                vip_inst = di['con_inst']
                clk_inst = di['vip_clock_inst']
                clk_port = di['vip_clock_port']
                rst_inst = di['vip_reset_inst']
                rst_port = di['vip_reset_port']
                vip_prefix = di['vip_prefix']
                json_ref.con_alp_vip(bus_inst, bus_sym, vip_inst, clk_inst, clk_port, rst_inst, rst_port, vip_prefix)

                HIER_LIST, HIER_DIC = update_hierarchy(inst_name, vip_inst, HIER_LIST, HIER_DIC)

            # bus_symbol to top_port - 2022-04-12
            elif (di['con_port'].find('$')>=0 and di['con_inst']==None):
                bus_symbol = di['port']
                bus_type = di['dir'].split('$')[0]
                top_symbol = di['con_port']
                for di in json_ref.get_bus_info(inst_name, bus_symbol, bus_type):
                    port = di['port']
                    dir = di['dir']
                    msb = di['msb']
                    lsb = di['lsb']
                    port_top = json_ref.get_port_from_symbol(port, dir, top_symbol)

                    json_ref.append_top_port(port_top, dir, msb, lsb)
                    json_ref.con_pin_to_top(inst_name, port, msb, lsb, port_top, msb, lsb)

            elif di['con_port']!=None:
                s_inst = inst_name
                s_port = di['port']; t_port = di['con_port']
                s_msb  = di['msb'] ; t_msb  = s_msb
                s_lsb  = di['lsb'] ; t_lsb  = s_lsb
                # bus_group
                if di['dir'].startswith('bus'):
                    (port_dir, port_type) = di['dir'].split('$')
                    if port_type=='mst':
                        #json_ref.con_bus_group(inst_name, di['port'], di['con_inst'], di['con_port'])
                        json_ref.con_bus_group(s_inst, s_port, di['con_inst'], di['con_port'])
                    else:
                        #json_ref.con_bus_group(di['con_inst'], di['con_port'], inst_name, di['port'])
                        json_ref.con_bus_group(di['con_inst'], di['con_port'], s_inst, s_port)
                elif di['con_inst']==None:
                    if di['con_port'].isdigit():
                        json_ref.con_pin_value  (s_inst, s_port, s_msb, s_lsb, di['con_port'])
                    else:
                        json_ref.con_pin_to_top (s_inst, s_port, s_msb, s_lsb, t_port, t_msb, t_lsb)
                        json_ref.append_top_port(t_port, di['dir'], t_msb, t_lsb)
                else:
                    t_inst = di['con_inst']
                    if di['dir']=='output':  # output is master
                        json_ref.con_pin_to_pin(s_inst, s_port, s_msb, s_lsb, t_inst, t_port, t_msb, t_lsb)
                    else:
                        json_ref.con_pin_to_pin(t_inst, t_port, t_msb, t_lsb, s_inst, s_port, s_msb, s_lsb)

    #---------------------------------------------------------------
    # Sub Top HPDF Generation
    #---------------------------------------------------------------
    dtop_from_json_ref = json_ref.platform_designer()
    for sub_mod_name, list_sub in HIER_LIST:
        sub_top = sub_mod_name
        sub_mod_name = sub_mod_name[1:]
        sub_inst_name = 'u_'+sub_mod_name
        # 1. create json object
        json_sub = alpgen_json()
        # 2. copy module
        json_sub.JSON['module'] = copy.deepcopy(json_ref.JSON['module'])  # must be copy.copy

        for inst_name in list_sub:
            if inst_name.startswith('$'):
                mod_name = inst_name[1:]
                json_sub.JSON['module'][mod_name] = dic_sub_module[mod_name]

        # 3. copy instance
        for inst_name in json_ref.JSON['instance']:
            if inst_name in list_sub:
                json_sub.JSON['instance'][inst_name] = copy.deepcopy(json_ref.JSON['instance'][inst_name])

        for inst_name in list_sub:
            if inst_name.startswith('$'):
                mod_name = inst_name[1:]
                inst_name = 'u_'+mod_name
                json_sub.JSON['instance'][inst_name] = \
                    {'modname': mod_name, 'prefix':'', 'parameter':{}}

        # 4. create top
        json_sub.JSON['top']['modname'] = sub_mod_name

        # 5. copy connection
        #    - process only p2p/p2t/tie
        #    - since alp_group/alp_vip is converted to p2p/p2t, no need to process it here

        list_top_port = []
        for con in json_ref.JSON['connection']:
            if con['type']=='p2p':
                dic_con = sub_top_p2p(sub_top, con, dtop_from_json_ref)
                # if sub_mod_name=='top':
                #     print (dic_con)
                if len(dic_con)>0:
                    json_sub.append_connection(dic_con)
                    if dic_con['type']=='p2t':
                        list_top_port.append(dic_con['top'])
            elif con['type']=='p2t':
                dic_con = sub_top_p2t(sub_top, con, dtop_from_json_ref)
                if len(dic_con)>0:
                    json_sub.append_connection(dic_con)
                    list_top_port.append(dic_con['top'])
            elif con['type']=='tie':
                if con['mst']['inst'] in list_sub:
                    json_sub.append_connection(con)
                    
        # 6. register top ports
        for dic_port in sort_top_ports(list_top_port).values():
            #json_sub.JSON['top']['ports'].append(dic_port)
            json_sub.append_top_port(dic_port)

        # register sub top module
        dic_sub_module[sub_mod_name] = extract_module(json_sub.JSON)

        SUB_TOP_LIST.append(json_sub)   
    #---------------------------------------------------------------
    # RTL Generation
    #---------------------------------------------------------------
    for json_sub in SUB_TOP_LIST:
        mod_name = json_sub.JSON['top']['modname']
#        json_name = mod_name+'.json'
        rtl_name = mod_name+'.v'
        # json_file_name = os.path.join(i_out_folder, json_name)
        rtl_file_name  = os.path.join(i_out_folder, rtl_name)
        # json_sub.write_json(json_file_name)
        write_comment(json_sub)

        if enb_json_i:
            json_name = mod_name+'.json'
            json_file_name = os.path.join(i_out_folder, json_name)
            print('=============================')
            print(json_file_name)
            check_dir(json_file_name)
            with open(json_file_name, 'w', encoding='utf-8') as f:
                json.dump(json_sub.get_json(), f, indent="\t")

        gen = alpgen(json_sub.get_json())
        check_dir(rtl_file_name)
        gen.write_rtl(rtl_file_name)

Comment = """\
//==============================================================================
//
// Project : {0}
//
// Verilog RTL(Behavioral) model
//
// This confidential and proprietary source code may be used only as authorized
// by a licensing agreement from ALPHAHOLDINGS Limited. The entire notice above
// must be reproduced on all authorized copies and copies may only be made to
// the extent permitted by a licensing agreement from ALPHAHOLDINGS Limited.
//
// COPYRIGHT (C) ALPHAHOLDINGS, inc. 2022
//
//==============================================================================
// File name : {1}
// Version : {2}
// Description :
// Simulator : NC Verilog
// Created by : {3}
// Date : {4}
//==============================================================================

"""

def write_comment(obj_i):
    modname = obj_i.JSON['top']['modname']
    times = time.localtime()[0:6]
    year   = str(times[0])
    month  = str(times[1])
    day    = str(times[2])
    hour   = str(times[3])
    minute = str(times[4])

    dates = "{0}-{1:0>2}-{2:0>2}  {3}:{4}".format(year, month, day, hour, minute)

    result = Comment.format('PNAI70X', modname, VERSION, DESIGNER, dates)
    obj_i.JSON['top']['comment'] = {}
    obj_i.JSON['top']['comment']['pre'] = result
    return True

#------------------------------------------------------------------------------
# Main - @mark
#------------------------------------------------------------------------------
dict_prj, option = get_argument()

file_list = []
top_name   = dict_prj['top_name']
excel_name = dict_prj['excel_name']
out_folder = dict_prj['output_folder']

if dict_prj.get('enable_output_json'):
    if dict_prj['enable_output_json'].lower()=='true':
        enable_json = True
    else:
        enable_json = False
else:
    enable_json = False

if dict_prj.get('alp_tools')!=None:
    VERSION = dict_prj['alp_tools']['version']
    PROJECT = dict_prj['alp_tools']['project']
    DESIGNER = dict_prj['alp_tools']['designer']
else:
    VERSION = "v1.0"
    PROJECT = "alpha project"
    DESIGNER = "SoC Designer"


for di in dict_prj['file_list']:
    inst_name = di['instance_name']
    wire_name = di['wire_name']
    file_path = di['file_path']
    parameter = di['parameter']
    file_list.append((inst_name, wire_name, file_path, parameter))
#check_dir(os.path.join(out_folder, excel_name))


if os.name=='nt': os.system('cls')
else            : os.system('clear')
print ('Alpha Platform Designer')
print (' 1. Excel Generation')
print (' 2. RTL Generation')

if option=='0':
    _in = input('Please Enter Selection >> ')
elif option=='1':
    _in = '1'
elif option=='2':
    _in = '2'

if _in=='1':
    write_excel(top_name, file_list, excel_name, out_folder)
elif _in=='2':
    write_rtl(excel_name, out_folder, enable_json)
else:
    print ('[ERROR] Not Support')
