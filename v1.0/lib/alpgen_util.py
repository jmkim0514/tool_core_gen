# -*- coding: utf-8 -*-
# =================================================================
# Copyright (C) 2020 AlphaHondings Co. ,All Rights Reserved
# AlphaHoldings Co. Proprietary & Confidential
# File Name   : alpgen.py 
# Description :
# Author      : Kim Jong Min ( jimmy@alpha-holdings.kr )
# =================================================================
import json
import copy
from operator import itemgetter, attrgetter
from pprint import pprint

#alpgen_group
#alpgen_lint
#alpgen_vip
#alpgen_print


#------------------------------------------------------------------------------
# alpgen_group - @mark
#------------------------------------------------------------------------------
class alpgen_group:
    bus_ref = [('apb', 'pselx'), ('apb', 'psel'), ('ahb', 'htrans'), ('axi', 'awvalid'), ('axi', 'arvalid')]
    amba_apb = [ \
#            {'port': ['pclk'         ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':  0, 'level':4, 'parameter': ''}, \
#            {'port': ['presetn'      ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':  0, 'level':4, 'parameter': ''}, \
            {'port': ['psel', 'pselx'], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':  0, 'level':0, 'parameter': ''}, \
            {'port': ['penable'      ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':  0, 'level':0, 'parameter': ''}, \
            {'port': ['paddr'        ], 'dir': 'output', 'msb': 31, 'lsb': 0, 'default':  0, 'level':0, 'parameter': 'ADDR_WIDTH'}, \
            {'port': ['pwrite'       ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':  0, 'level':0, 'parameter': ''}, \
            {'port': ['pwdata'       ], 'dir': 'output', 'msb': 31, 'lsb': 0, 'default':  0, 'level':0, 'parameter': 'DATA_WIDTH'}, \
            {'port': ['pprot'        ], 'dir': 'output', 'msb':  2, 'lsb': 0, 'default':  0, 'level':2, 'parameter': ''}, \
            {'port': ['pstrb'        ], 'dir': 'output', 'msb':  3, 'lsb': 0, 'default': 15, 'level':1, 'parameter': ''}, \
            {'port': ['prdata'       ], 'dir': 'input' , 'msb': 31, 'lsb': 0, 'default':  0, 'level':0, 'parameter': 'DATA_WIDTH'}, \
            {'port': ['pready'       ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':  1, 'level':6, 'parameter': ''}, \
            {'port': ['pslverr'      ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':  0, 'level':1, 'parameter': ''}, \
        ]
    amba_ahb = [ \
#            {'port': ['hclk'               ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':4, 'parameter': ''}, \
#            {'port': ['hresetn'            ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':4, 'parameter': ''}, \
            {'port': ['htrans'             ], 'dir': 'output', 'msb':  1, 'lsb': 0, 'default':0, 'level': 8, 'parameter': ''}, \
            {'port': ['hsel', 'hselx'      ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':1, 'level': 7, 'parameter': ''}, \
            {'port': ['haddr'              ], 'dir': 'output', 'msb': 31, 'lsb': 0, 'default':0, 'level': 0, 'parameter': 'ADDR_WIDTH'}, \
            {'port': ['hwrite'             ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level': 0, 'parameter': ''}, \
            {'port': ['hburst'             ], 'dir': 'output', 'msb':  2, 'lsb': 0, 'default':0, 'level': 2, 'parameter': ''}, \
            {'port': ['hsize'              ], 'dir': 'output', 'msb':  2, 'lsb': 0, 'default':0, 'level': 1, 'parameter': ''}, \
            {'port': ['hwdata'             ], 'dir': 'output', 'msb': 31, 'lsb': 0, 'default':0, 'level': 0, 'parameter': 'DATA_WIDTH'}, \
            {'port': ['hrdata'             ], 'dir': 'input' , 'msb': 31, 'lsb': 0, 'default':0, 'level': 0, 'parameter': 'DATA_WIDTH'}, \
            {'port': ['hready', 'hreadyout'], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':1, 'level':10, 'parameter': ''}, \
            {'port': ['hready', 'hreadyout'], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':1, 'level':10, 'parameter': ''}, \
            {'port': ['hmastlock'          ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level': 3, 'parameter': ''}, \
            {'port': ['hresp'              ], 'dir': 'input' , 'msb':  1, 'lsb': 0, 'default':0, 'level': 3, 'parameter': ''}, \
            {'port': ['hprot'              ], 'dir': 'output', 'msb':  6, 'lsb': 0, 'default':0, 'level': 3, 'parameter': ''}, \
            {'port': ['hnonsec'            ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level': 2, 'parameter': ''}, \
            {'port': ['hmaster'            ], 'dir': 'output', 'msb':  3, 'lsb': 0, 'default':0, 'level': 2, 'parameter': ''}, \
            {'port': ['hexokay'            ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level': 1, 'parameter': ''}, \
            {'port': ['hauser'             ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level': 2, 'parameter': 'USER_WIDTH'}, \
            {'port': ['hwuser'             ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level': 2, 'parameter': 'USER_WIDTH'}, \
            {'port': ['hruser'             ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level': 2, 'parameter': 'USER_WIDTH'}, \
        ]
    amba_ahb_hready = [ \
            {'port': ['hready', 'hreadyout'], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':1, 'level':0, 'parameter': ''}, \
        ]
    amba_axi = [ \
#            {'port': ['aclk'    ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':4, 'parameter': ''}, \
#            {'port': ['aresetn' ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':4, 'parameter': ''}, \
            {'port': ['awid'    ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':1, 'parameter': 'ID_WIDTH'}, \
            {'port': ['awaddr'  ], 'dir': 'output', 'msb': 31, 'lsb': 0, 'default':0, 'level':0, 'parameter': 'ADDR_WIDTH'}, \
            {'port': ['awlen'   ], 'dir': 'output', 'msb':  7, 'lsb': 0, 'default':0, 'level':0, 'parameter': 'LEN_WIDTH'}, \
            {'port': ['awsize'  ], 'dir': 'output', 'msb':  2, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['awburst' ], 'dir': 'output', 'msb':  1, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['awlock'  ], 'dir': 'output', 'msb':  1, 'lsb': 0, 'default':0, 'level':3, 'parameter': ''}, \
            {'port': ['awcache' ], 'dir': 'output', 'msb':  3, 'lsb': 0, 'default':0, 'level':3, 'parameter': ''}, \
            {'port': ['awprot'  ], 'dir': 'output', 'msb':  2, 'lsb': 0, 'default':0, 'level':3, 'parameter': ''}, \
            {'port': ['awregion'], 'dir': 'output', 'msb':  3, 'lsb': 0, 'default':0, 'level':2, 'parameter': ''}, \
            {'port': ['awqos'   ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':2, 'parameter': ''}, \
            {'port': ['awuser'  ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':2, 'parameter': 'USER_WIDTH'}, \
            {'port': ['awvalid' ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['awready' ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['arid'    ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':1, 'parameter': 'ID_WIDTH'}, \
            {'port': ['araddr'  ], 'dir': 'output', 'msb': 31, 'lsb': 0, 'default':0, 'level':0, 'parameter': 'ADDR_WIDTH'}, \
            {'port': ['arlen'   ], 'dir': 'output', 'msb':  7, 'lsb': 0, 'default':0, 'level':0, 'parameter': 'LEN_WIDTH'}, \
            {'port': ['arsize'  ], 'dir': 'output', 'msb':  2, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['arburst' ], 'dir': 'output', 'msb':  1, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['arlock'  ], 'dir': 'output', 'msb':  1, 'lsb': 0, 'default':0, 'level':3, 'parameter': ''}, \
            {'port': ['arcache' ], 'dir': 'output', 'msb':  3, 'lsb': 0, 'default':0, 'level':3, 'parameter': ''}, \
            {'port': ['arprot'  ], 'dir': 'output', 'msb':  2, 'lsb': 0, 'default':0, 'level':3, 'parameter': ''}, \
            {'port': ['arregion'], 'dir': 'output', 'msb':  3, 'lsb': 0, 'default':0, 'level':2, 'parameter': ''}, \
            {'port': ['arqos'   ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':2, 'parameter': ''}, \
            {'port': ['aruser'  ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':2, 'parameter': 'USER_WIDTH'}, \
            {'port': ['arvalid' ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['arready' ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['wid'     ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':1, 'parameter': 'ID_WIDTH'}, \
            {'port': ['wdata'   ], 'dir': 'output', 'msb': 31, 'lsb': 0, 'default':0, 'level':0, 'parameter': 'DATA_WIDTH'}, \
            {'port': ['wstrb'   ], 'dir': 'output', 'msb':  3, 'lsb': 0, 'default':0, 'level':0, 'parameter': 'BYTE_WIDTH'}, \
            {'port': ['wlast'   ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['wuser'   ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':2, 'parameter': 'USER_WIDTH'}, \
            {'port': ['wvalid'  ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['wready'  ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['bid'     ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':1, 'parameter': 'ID_WIDTH'}, \
            {'port': ['bresp'   ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':3, 'parameter': ''}, \
            {'port': ['buser'   ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':2, 'parameter': 'USER_WIDTH'}, \
            {'port': ['bvalid'  ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['bready'  ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['rid'     ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':1, 'parameter': 'ID_WIDTH'}, \
            {'port': ['rresp'   ], 'dir': 'input' , 'msb':  1, 'lsb': 0, 'default':0, 'level':2, 'parameter': ''}, \
            {'port': ['rdata'   ], 'dir': 'input' , 'msb': 31, 'lsb': 0, 'default':0, 'level':0, 'parameter': 'DATA_WIDTH'}, \
            {'port': ['rlast'   ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['ruser'   ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':2, 'parameter': 'USER_WIDTH'}, \
            {'port': ['rvalid'  ], 'dir': 'input' , 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
            {'port': ['rready'  ], 'dir': 'output', 'msb':  0, 'lsb': 0, 'default':0, 'level':0, 'parameter': ''}, \
        ]

    def pattern_to_symbol (self, dic):
        out = dic['protocol']
        if dic['option']=='u': out = out.upper()
        if dic['option']=='c': out = out.capitalize()
        dpre = ''
        dpos = ''
        if   dic['portdir']=='pre' : dpre = '.'
        elif dic['portdir']=='post': dpos = '.'
        return '$'.join([out, dpre+dic['prefix'], dpos+dic['postfix']])

    def symbol_to_pattern (self, symbol):
        symbol = symbol.split('$')
        dic = {}
        dic['protocol'] = symbol[0].lower()
        dic['portdir']  = ''
        if symbol[1].startswith('.'):
            dic['portdir'] = 'pre'
            dic['prefix']  = symbol[1][1:]
        else:
            dic['prefix']   = symbol[1]
        if symbol[2].startswith('.'):
            dic['portdir'] = 'post'
            dic['postfix']  = symbol[2][1:]
        else:
            dic['postfix']  = symbol[2]

        if   symbol[0].isupper()    : dic['option'] = 'u'
        elif symbol[0][:1].isupper(): dic['option'] = 'c'
        else                        : dic['option'] = ''
        return dic

    # input: normal signal
    # output: {'protocol': axi, 'type', mst/slv, 'prefix': str, 'postfix': str, 'option': u/c, 'parameter':{}}
    def get_bus_pattern(self, i_signal, i_dir):
        for bus_protocol, bus_ref in self.bus_ref:
            dic = {}
            if i_signal.lower().find(bus_ref)>=0:
                dic['protocol'] = bus_protocol
                dic['portdir'] = ''
                if i_dir=='output':
                    dic['type'] = 'mst'
                    if i_signal.startswith('o_'): dic['portdir'] = 'pre' ; signal = i_signal[2:]
                    elif i_signal.endswith('_o'): dic['portdir'] = 'post'; signal = i_signal[:-2]
                    else                        :                          signal = i_signal
                else:
                    dic['type'] = 'slv'
                    if i_signal.startswith('i_'): dic['portdir'] = 'pre' ; signal = i_signal[2:]
                    elif i_signal.endswith('_i'): dic['portdir'] = 'post'; signal = i_signal[:-2]
                    else                        :                          signal = i_signal

                s = signal.lower().find(bus_ref)
                e = s + len(bus_ref)
                dic['prefix'] = signal[:s]
                dic['postfix'] = signal[e:]
                if    signal[s:e].isupper()     : dic['option'] = 'u'
                elif  signal[s:e][:1].isupper() : dic['option'] = 'c'
                else                           : dic['option'] = ''
                dic['parameter'] = {}
                return dic
        return dic

    # input : dic_pattern = {'protocol': , 'type':, 'prefix':, 'postfix':, 'option': , 'dirpre': }   --> bus_pattern
    #         bus_type    = mst/slv
    # return : [ {'port': [], 'dir': , 'msb': , 'lsb': , 'parameter': },  --> bus list by bus_pattern
    #            {'port': [], 'dir': , 'msb': , 'lsb': , 'parameter': } ]
    def get_bus_signal_list (self, dic_pattern, bus_type):
        #list_bus_signal = []
        if   dic_pattern['protocol']=='apb'   : list_bus_signal = self.amba_apb
        elif dic_pattern['protocol']=='ahb'   : list_bus_signal = self.amba_ahb
        elif dic_pattern['protocol']=='axi'   : list_bus_signal = self.amba_axi
        elif dic_pattern['protocol']=='hready': list_bus_signal = self.amba_ahb_hready
        result = []
        for dic_port in list_bus_signal:
            l_port_name = []
            for port_name in dic_port['port']:
                if   dic_pattern['option']=='u': port_name = port_name.upper()
                elif dic_pattern['option']=='c': port_name = port_name.capitalize()
                port_name = dic_pattern['prefix']+port_name+dic_pattern['postfix']
                
                if dic_port['dir']=='output':
                    if   bus_type=='mst': affix = 'o' # output
                    elif bus_type=='slv': affix = 'i' # input
                elif dic_port['dir']=='input':
                    if   bus_type=='mst': affix = 'i' # input
                    elif bus_type=='slv': affix = 'o' # output
                else                    : affix = 'b' # inout
                if   dic_pattern['portdir']=='pre' : port_name = affix+'_'+port_name
                elif dic_pattern['portdir']=='post': port_name = port_name+'_'+affix
                l_port_name.append(port_name)

            tmp = {}
            tmp['port']       = l_port_name
            tmp['msb']        = dic_port['msb']
            tmp['lsb']        = dic_port['lsb']
            tmp['level']      = dic_port['level']
            tmp['default']    = dic_port['default']
            tmp['parameter']  = dic_port['parameter']
            if bus_type=='slv':
                if   dic_port['dir']=='input' : tmp['dir'] = 'output'
                elif dic_port['dir']=='output': tmp['dir'] = 'input'
                else                          : tmp['dir'] = dic_port['dir']
            else: tmp['dir'] = dic_port['dir']
            result.append(tmp)
        return result

    # from get_bus_signal_list
    def get_bus_signal_list_hready (self, dic_pattern, bus_type):
        dic_pattern['protocol']='hready'
        return self.get_bus_signal_list (dic_pattern, bus_type)

#-------------------------------------------------------------------------------
# alpgen_lint - @mark
#-------------------------------------------------------------------------------
class alpgen_lint:
    __port_list = ['input', 'output', 'inout']

    def __init__ (self, i_json_top):
        self.TREE = i_json_top

    def __tree_for_lint(self):
        self.TREE = {}
        for inst_name in self.JSON['instance']:
            self.TREE[inst_name] = {}

            try   : self.JSON['instance'][inst_name]['modname']
            except: assert(0), "[ERROR] [\'modname\'] <= No Arg : JSON['instance'][inst_name]['modname']"

            mod_name = self.JSON['instance'][inst_name]['modname']

            try   : self.JSON['module'][mod_name]['ports']
            except: assert(0), "[ERROR] [\'ports\'] <= No Arg : JSON['module'][%s]['ports']"%(mod_name)

            for dic_port in self.JSON['module'][mod_name]['ports']:
                tmp = {}
                tmp['dir'] = dic_port['dir']
                tmp['msb'] = self.dec_bit(dic_port['msb'], inst_name, dic_port['port'], True)
                tmp['lsb'] = self.dec_bit(dic_port['lsb'], inst_name, dic_port['port'], True)
                self.TREE[inst_name][dic_port['port']] = tmp

            try   : self.JSON['top']
            except: return
            try   : self.JSON['top']['ports']
            except: continue

            top_port = {}
            for dic_port in self.JSON['top']['ports']:
                try   : dic_port['port']
                except: assert(0), "[ERROR] {\'port\': } <= No Arg : JSON['top']['ports]{'port': }"

                top_port[dic_port['port']] = dic_port
            self.TREE['$top'] = top_port


    def lint_json(self):        
        print ('[LOG] json lint start.')
        self.__tree_for_lint()
        self.__lint_top()
        self.__json_format_instance()
        self.__json_format_module()
        self.__json_format_connection()
        self.TREE = {}
        print ('[LOG] json lint end.')

#    def lint_json_rtl(self, json_file):
#        print ('[LOG] JSON Lint Check Start.')
#        self.__tree_for_lint()
#        self.__lint_top()
#        self.__json_format_instance()
#        self.__json_format_module()
#        self.__json_format_connection()
#        self.TREE = {}
#        print ('[LOG] JSON Lint Check End.')

    def lint_json_excel_group(self, json_file):
        print ('[LOG] JSON Format Validation Start.')
        #self.__lint_top()
        self.__json_format_instance()
        self.__json_format_module()
        #self.__json_format_connection()
        print ('[LOG] JSON Format Validation is Complete.')

    def __get_port_info(self, mod_name, port_name):
        if mod_name=='':
            for i in self.JSON['top']['ports']:
                if i['port']==port_name:
                    return i
        else:
            for i in self.JSON['module'][mod_name]['ports']:
                if i['port']==port_name:
                    return i
        print('[LOG] *E, Port not found')
        print('      - module name = ', mod_name)
        print('      - port name   = ', port_name)

    # get_modname
    # - input : instance name
    # - return : module name
    def __get_modname(self, inst_name):
        return self.JSON['instance'][inst_name]['modname']

    def __debug_con_mst(self, m_inst, m_port, m_dir, m_msb, m_lsb):
        mst_mod_info = self.__get_port_info(self.__get_modname(m_inst), m_port)
        print('      - connection mst_inst = ', m_inst)
        print('      - connection mst_port = ', m_port)
        print('      - connection mst_dir  = ', m_dir)
        print('      - connection mst_msb  = ', m_msb)
        print('      - connection mst_lsb  = ', m_lsb)
        print('      - module     mst_dir  = ', mst_mod_info['dir'])
        print('      - module     mst_msb  = ', mst_mod_info['msb'])
        print('      - module     mst_lsb  = ', mst_mod_info['lsb'])

    def __debug_con_tie(self, m_inst, m_port, m_dir, m_msb, m_lsb, slv_value):
        print('      type = tie')
        self.__debug_con_mst(m_inst, m_port, m_dir, m_msb, m_lsb)
        print('      - slv_value = ', slv_value)

    #-------------------------------------------------------------------------------
    # JSON File Check
    #-------------------------------------------------------------------------------
    port_define = ('input', 'output', 'inout')
    def __lint_top(self):
        try   : self.JSON['top']
        except: return
        try   : self.JSON['top']['modname']
        except: assert(0), '[ERROR] [\'top\'][\'modname\'] <= No Argument\n'

        for dic_port in self.JSON['top']['ports']:
            try   : dic_port['dir']
            except: assert(0), "[ERROR] {\'dir\': } <= No Arg : JSON['top']['ports]{'dir': }"
            try   : dic_port['msb']
            except: assert(0), "[ERROR] {\'msb\': } <= No Arg : JSON['top']['ports]{'msb': }"
            try   : dic_port['lsb']
            except: assert(0), "[ERROR] {\'lsb\': } <= No Arg : JSON['top']['ports]{'lsb': }"

            if dic_port['dir'] not in self.port_define:
                assert(0), "[ERROR] ['top']['ports']={\'dir\': ? } <= Unknown direction : %s, "%(dic_port)
            if type(dic_port['msb'])!=int:
                assert(0), "[ERROR] ['top']['ports']={\'msb\': } <= Must be int type: %s, "%(dic_port)
            if type(dic_port['lsb'])!=int:
                assert(0), "[ERROR] ['top']['ports']={\'lsb\': } <= Must be int type : %s, "%(dic_port)

    def __json_format_instance(self):
        if (self.JSON.get('instance','no_key')=='no_key'):
            print ('[LOG] *E,  The json_file[\'instance\'] was not found.'); exit()
        else:
            for inst_name in list(self.JSON['instance'].keys()):
                if (self.JSON['instance'][inst_name].get('modname','no_key')=='no_key'):
                    print ('[LOG] *E,  json_file[\'instance\'][{0}][\'modname\'] keys() was not found.'.format(inst_name)); exit()
                elif (self.JSON['instance'][inst_name]['modname']==''):
                    print ('[LOG] *E,  no json_file[\'instance\'][{0}][\'modname\'] value.'.format(inst_name)); exit()
                if (self.JSON['instance'][inst_name].get('prefix','no_key')=='no_key'):
                    print ('[LOG] *E,  json_file[\'instance\'][{0}][\'prefix\'] keys() was not found.'.format(inst_name)); exit()
                #if (self.JSON['instance'][inst_name].get('parameter','no_key')=='no_key'):
                #    print ('[LOG] *E,  json_file[\'instance\'][{0}][\'paramter\'] keys() was not found.'.format(inst_name)); exit()

    def __json_format_module(self):
        if (self.JSON.get('module','no_key')=='no_key'):
            print ('[LOG] *E,  The json_file[\'module\'] was not found.'); exit()
        else:
            for mod_name in list(self.JSON['module'].keys()):
                if (self.JSON['module'][mod_name].get('modname','no_key')=='no_key'):
                    print ('[LOG] *E,  json_file[\'module\'][{0}][\'modname\'] was not found.'.format(mod_name)); exit()
                elif (self.JSON['module'][mod_name]['modname']==''):
                    print ('[LOG] *E,  no json_file[\'module\'][{0}][\'modname\'] value.'.format(mod_name)); exit()
                if (self.JSON['module'][mod_name].get('filename','no_key')=='no_key'):
                    print ('[LOG] *E,  json_file[\'module\'][{0}][\'filename\'] keys() was not found.'.format(mod_name)); exit()
                if (self.JSON['module'][mod_name].get('ports','no_key')=='no_key'):
                    print ('[LOG] *E,  json_file[\'module\'][{0}][\'ports\'] keys() was not found.'.format(mod_name)); exit()

    def __json_format_connection(self):
        for con in self.JSON['connection']:
            mode = con['type']
            # common
            if (mode=='p2p' or mode=='p2t' or mode=='tie'):
                m_inst=con['mst']['inst']
                m_port=con['mst']['port']
                m_msb=self.dec_bit(con['mst']['msb'], m_inst, m_port, False)
                m_lsb=self.dec_bit(con['mst']['lsb'], m_inst, m_port, False)

                try   : self.TREE[m_inst]
                except: assert(0), '[ERROR] \'%s\' <= No Instance Name\n\n %s'%(m_inst, con)
                try   : self.TREE[m_inst][m_port]
                except: assert(0), '[ERROR] \'%s\' <= No Port Name\n\n %s'%(m_port, con)

            if mode=='p2p':
                s_inst=con['slv']['inst']; s_port=con['slv']['port']; s_msb=con['slv']['msb']; s_lsb=con['slv']['lsb']
                try   : self.TREE[s_inst]
                except: assert(0), '[ERROR] \'%s\' <= No Instance Name\n\n %s'%(s_inst, con)
                try   : self.TREE[s_inst][s_port]
                except: assert(0), '[ERROR] \'%s\' <= No Port Name\n\n %s'%(s_port, con)
            elif mode=='p2t':
                s_port=con['top']['port']; s_msb=con['top']['msb']; s_lsb=con['top']['lsb']
                try   : self.TREE['$top'][s_port]
                except: assert(0), '[ERROR] \'%s\' <= No Top Port Name\n %s'%(s_port, con)
            elif mode=='tie':
                if type(con['value'])!=int:
                    assert(0), '[ERROR] JSON[\'connection\'][\'tie\'][value] <= Value must be int %s'%(con)

                # @todo - m_msb<module_msb 
                # @todo - m_msb-m_lsb == s_msb-s_lsb
            elif (mode=='bus_group' or mode=='pattern'):
                m_inst=con['mst']['inst']; m_sym=con['mst']['symbol']
                s_inst=con['slv']['inst']; s_sym=con['slv']['symbol']
                try   : self.TREE[m_inst]
                except: assert(0), '[ERROR] \'%s\' <= No Instance Name\n%s'%(m_inst, con)
                if (mode=='group' or (mode=='pattern' and s_inst!='')):
                    try   : self.TREE[s_inst]
                    except: assert(0), '[ERROR] \'%s\' <= No Instance Name\n%s'%(s_inst, con)
                if m_sym.split('$')[0]!=s_sym.split('$')[0]:
                    assert(0), '[ERROR] mst_symbol=%s, slv_symbol=%s <= different bus\n%s'%(m_sym, s_sym, con)
            elif (mode=='alp_vip'):
                b_inst=con['bus']['inst']
                try   : self.TREE[b_inst]
                except: assert(0), '[ERROR] \'%s\' <= No Instance Name\n%s'%(b_inst, con)
            else:
                assert(0), '[ERROR] Unknown JSON Format\n%s'%(con)
                
            flag_error = False
            #----------------------------------------------------------------------
            # inst/port/msb/lsb/dir valication check
            #----------------------------------------------------------------------
            if (mode=='p2p' or mode=='p2t'):
                # msb/lsb bit check
                if (m_msb<m_lsb):
                    print ('[LOG] *E, m_lsb is greater than m_msb.')
                    flag_error = True
                if (s_msb<s_lsb):
                    print ('[LOG] *E, s_lsb is greater than s_msb.')
                    flag_error = True
                # msb/lsb connection/module check
                if (m_msb>self.TREE[m_inst][m_port]['msb']):
                    print ('[LOG] *E, The msb of the connection is larger than the msb of the module.')
                    flag_error = True
                if (m_lsb<self.TREE[m_inst][m_port]['lsb']):
                    print ('[LOG] *E, The lsb of the connection is smaller than the lsb of the module.')
                    flag_error = True
                if mode=='p2p':
                    if (s_msb>self.TREE[s_inst][s_port]['msb']):
                        print ('[LOG] *E, The msb of the connection is larger than the msb of the module.')
                        flag_error = True
                    if (s_lsb<self.TREE[s_inst][s_port]['lsb']):
                        print ('[LOG] *E, The lsb of the connection is smaller than the lsb of the module.')
                        flag_error = True
                if mode=='p2t':
                    if (s_msb>self.TREE['$top'][s_port]['msb']):
                        print ('[LOG] *E, The msb of the connection is larger than the msb of the module.')
                        flag_error = True
                    if (s_lsb<self.TREE['$top'][s_port]['lsb']):
                        print ('[LOG] *E, The lsb of the connection is smaller than the lsb of the module.')
                        flag_error = True

#------------------------------------------------------------------------------
# alpgen_vip - @mark
#------------------------------------------------------------------------------
class alpgen_vip:
    avm_apb = { \
        'modname':'avm_apb', \
        'filename': 'avm_apb.v', \
        'ports': [ \
            {'port': 'i_pclk'   , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_presetn', 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_psel'   , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_penable', 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_paddr'  , 'dir': 'output', 'msb': 'ADDR_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_pwrite' , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_pwdata' , 'dir': 'output', 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_pprot'  , 'dir': 'output', 'msb':            '2', 'lsb': '0'}, \
            {'port': 'o_pstrb'  , 'dir': 'output', 'msb': 'BYTE_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_prdata' , 'dir': 'input' , 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_pready' , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_pslverr', 'dir': 'input' , 'msb':            '0', 'lsb': '0'}  \
        ] \
    }

    avm_ahb = { \
        'modname': 'avm_ahb', \
        'filename': 'avm_ahb.v', \
        'ports': [ \
            {'port': 'i_hclk'     , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_hresetn'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_htrans'   , 'dir': 'output', 'msb':            '1', 'lsb': '0'}, \
            {'port': 'o_haddr'    , 'dir': 'output', 'msb': 'ADDR_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_hwrite'   , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_hsize'    , 'dir': 'output', 'msb':            '2', 'lsb': '0'}, \
            {'port': 'o_hburst'   , 'dir': 'output', 'msb':            '2', 'lsb': '0'}, \
            {'port': 'o_hwdata'   , 'dir': 'output', 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_hmastlock', 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_hrdata'   , 'dir': 'input' , 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_hready'   , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_hresp'    , 'dir': 'input' , 'msb':            '1', 'lsb': '0'}, \
        ] \
    }

    avm_axi = { \
        'modname': 'avm_axi', \
        'filename': 'avm_axi.v', \
        'ports': [ \
            {'port': 'i_aclk'    , 'dir': 'input',  'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_aresetn' , 'dir': 'input',  'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_awid'    , 'dir': 'output', 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_awaddr'  , 'dir': 'output', 'msb': 'ADDR_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_awlen'   , 'dir': 'output', 'msb':  'LEN_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_awsize'  , 'dir': 'output', 'msb':            '2', 'lsb': '0'}, \
            {'port': 'o_awburst' , 'dir': 'output', 'msb':            '1', 'lsb': '0'}, \
            {'port': 'o_awlock'  , 'dir': 'output', 'msb':            '1', 'lsb': '0'}, \
            {'port': 'o_awcache' , 'dir': 'output', 'msb':            '3', 'lsb': '0'}, \
            {'port': 'o_awprot'  , 'dir': 'output', 'msb':            '2', 'lsb': '0'}, \
            {'port': 'o_awvalid' , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_awready' , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_wid'     , 'dir': 'output', 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_wdata'   , 'dir': 'output', 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_wstrb'   , 'dir': 'output', 'msb': 'BYTE_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_wlast'   , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_wvalid'  , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_wready'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_bid'     , 'dir': 'input' , 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_bresp'   , 'dir': 'input' , 'msb':            '1', 'lsb': '0'}, \
            {'port': 'i_bvalid'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_bready'  , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_arid'    , 'dir': 'output', 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_araddr'  , 'dir': 'output', 'msb': 'ADDR_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_arlen'   , 'dir': 'output', 'msb':  'LEN_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_arsize'  , 'dir': 'output', 'msb':            '2', 'lsb': '0'}, \
            {'port': 'o_arburst' , 'dir': 'output', 'msb':            '1', 'lsb': '0'}, \
            {'port': 'o_arlock'  , 'dir': 'output', 'msb':            '1', 'lsb': '0'}, \
            {'port': 'o_arcache' , 'dir': 'output', 'msb':            '3', 'lsb': '0'}, \
            {'port': 'o_arprot'  , 'dir': 'output', 'msb':            '2', 'lsb': '0'}, \
            {'port': 'o_arvalid' , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_arready' , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_rid'     , 'dir': 'input' , 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_rdata'   , 'dir': 'input' , 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_rresp'   , 'dir': 'input' , 'msb':            '1', 'lsb': '0'}, \
            {'port': 'i_rlast'   , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_rvalid'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_rready'  , 'dir': 'output', 'msb':            '0', 'lsb': '0'}  \
        ] \
    }

    avs_apb = { \
        'modname':'avs_apb', \
        'filename': 'avs_apb.v', \
        'ports': [ \
            {'port': 'i_pclk'   , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_presetn', 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_pselx'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_penable', 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_paddr'  , 'dir': 'input' , 'msb': 'ADDR_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_pwrite' , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_pwdata' , 'dir': 'input' , 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_prdata' , 'dir': 'output', 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_pready' , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_pslverr', 'dir': 'output', 'msb':            '0', 'lsb': '0'}  \
        ] \
    }
    avs_ahb = { \
        'modname': 'avs_ahb', \
        'filename': 'avs_ahb.v', \
        'ports': [ \
            {'port': 'i_hclk'     , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_hresetn'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_htrans'   , 'dir': 'input' , 'msb':            '1', 'lsb': '0'}, \
            {'port': 'i_haddr'    , 'dir': 'input' , 'msb': 'ADDR_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_hwrite'   , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_hsize'    , 'dir': 'input' , 'msb':            '2', 'lsb': '0'}, \
            {'port': 'i_hburst'   , 'dir': 'input' , 'msb':            '2', 'lsb': '0'}, \
            {'port': 'i_hwdata'   , 'dir': 'input' , 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_hready'   , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_hrdata'   , 'dir': 'output', 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_hreadyout', 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_hresp'    , 'dir': 'output', 'msb':            '1', 'lsb': '0'}, \
        ] \
    }

    avs_axi = { \
        'modname': 'avs_axi', \
        'filename': 'avs_axi.v', \
        'ports': [ \
            {'port': 'i_aclk'    , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_aresetn' , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_awid'    , 'dir': 'input' , 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_awaddr'  , 'dir': 'input' , 'msb': 'ADDR_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_awlen'   , 'dir': 'input' , 'msb':  'LEN_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_awsize'  , 'dir': 'input' , 'msb':            '2', 'lsb': '0'}, \
            {'port': 'i_awburst' , 'dir': 'input' , 'msb':            '1', 'lsb': '0'}, \
            {'port': 'i_awlock'  , 'dir': 'input' , 'msb':            '1', 'lsb': '0'}, \
            {'port': 'i_awcache' , 'dir': 'input' , 'msb':            '3', 'lsb': '0'}, \
            {'port': 'i_awprot'  , 'dir': 'input' , 'msb':            '2', 'lsb': '0'}, \
            {'port': 'i_awvalid' , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_awready' , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
#            {'port': 'i_wid'     , 'dir': 'input' , 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_wdata'   , 'dir': 'input' , 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_wstrb'   , 'dir': 'input' , 'msb': 'BYTE_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_wlast'   , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_wvalid'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_wready'  , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_bid'     , 'dir': 'output', 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_bresp'   , 'dir': 'output', 'msb':            '1', 'lsb': '0'}, \
            {'port': 'o_bvalid'  , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_bready'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_arid'    , 'dir': 'input' , 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_araddr'  , 'dir': 'input' , 'msb': 'ADDR_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_arlen'   , 'dir': 'input' , 'msb':  'LEN_WIDTH-1', 'lsb': '0'}, \
            {'port': 'i_arsize'  , 'dir': 'input' , 'msb':            '2', 'lsb': '0'}, \
            {'port': 'i_arburst' , 'dir': 'input' , 'msb':            '1', 'lsb': '0'}, \
            {'port': 'i_arlock'  , 'dir': 'input' , 'msb':            '1', 'lsb': '0'}, \
            {'port': 'i_arcache' , 'dir': 'input' , 'msb':            '3', 'lsb': '0'}, \
            {'port': 'i_arprot'  , 'dir': 'input' , 'msb':            '2', 'lsb': '0'}, \
            {'port': 'i_arvalid' , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_arready' , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_rid'     , 'dir': 'output', 'msb':   'ID_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_rdata'   , 'dir': 'output', 'msb': 'DATA_WIDTH-1', 'lsb': '0'}, \
            {'port': 'o_rresp'   , 'dir': 'output', 'msb':            '1', 'lsb': '0'}, \
            {'port': 'o_rlast'   , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'o_rvalid'  , 'dir': 'output', 'msb':            '0', 'lsb': '0'}, \
            {'port': 'i_rready'  , 'dir': 'input' , 'msb':            '0', 'lsb': '0'}  \
        ] \
    }

    #def __init__ (self, dic_pattern):
    def __init__ (self, dic_or_sym):
        if type(dic_or_sym)==dict:
            dic = dic_or_sym
        elif type(dic_or_sym)==str:
            dic = self.__symbol_to_pattern(dic_or_sym)
            #todo - 
            dic['type'] = 'imsi'
            dic['parameter'] = {}
        self.type     = dic['type']
        self.protocol = dic['protocol']
        self.prefix   = dic['prefix']
        self.postfix  = dic['postfix']
        self.portdir  = dic['portdir']
        self.option   = dic['option']
        self.param    = dic['parameter']

    def __symbol_to_pattern (self, symbol):
        symbol = symbol.split('$')
        dic = {}
        dic['protocol'] = symbol[0].lower()
        dic['portdir']  = ''
        if symbol[1].startswith('.'):
            dic['portdir'] = 'pre'
            dic['prefix']  = symbol[1][1:]
        else:
            dic['prefix']   = symbol[1]
        if symbol[2].startswith('.'):
            dic['portdir'] = 'post'
            dic['postfix']  = symbol[2][1:]
        else:
            dic['postfix']  = symbol[2]

        if   symbol[0].isupper()    : dic['option'] = 'u'
        elif symbol[0][:1].isupper(): dic['option'] = 'c'
        else                        : dic['option'] = ''
        return dic

    def get_vip_module (self):
        if   self.type=='slv' and self.protocol=='apb': return self.avm_apb
        elif self.type=='slv' and self.protocol=='ahb': return self.avm_ahb
        elif self.type=='slv' and self.protocol=='axi': return self.avm_axi
        elif self.type=='mst' and self.protocol=='apb': return self.avs_apb
        elif self.type=='mst' and self.protocol=='ahb': return self.avs_ahb
        elif self.type=='mst' and self.protocol=='axi': return self.avs_axi
        else: exit()

    def get_vip_symbol (self):
        if   self.type=='slv' and self.protocol=='apb': return 'apb$.$'
        elif self.type=='slv' and self.protocol=='ahb': return 'ahb$.$'
        elif self.type=='slv' and self.protocol=='axi': return 'axi$.$'
        elif self.type=='mst' and self.protocol=='apb': return 'apb$.$'
        elif self.type=='mst' and self.protocol=='ahb': return 'ahb$.$'
        elif self.type=='mst' and self.protocol=='axi': return 'axi$.$'
        else: exit()

    def get_vip_clock (self):
        if   self.protocol=='apb': return 'i_pclk'
        elif self.protocol=='ahb': return 'i_hclk'
        elif self.protocol=='axi': return 'i_aclk'
        else: exit()

    def get_vip_reset (self):
        if   self.protocol=='apb': return 'i_presetn'
        elif self.protocol=='ahb': return 'i_hresetn'
        elif self.protocol=='axi': return 'i_aresetn'
        else: exit()

#------------------------------------------------------------------------------
# alpgen_print - @mark
#------------------------------------------------------------------------------
class alpgen_print():

    def print_rtl(self, file_name):
        self.f_rtl = open (file_name, 'w')
        #with open (file_name, 'w') as f_rtl:
        self.print_module()   ; self.disp('\n')
        self.print_wire()     ; self.disp('\n')
        self.print_assign()   ; self.disp('\n')
        self.print_instance()
        self.print_endmodule()
        self.f_rtl.close()
        #print ('----')
        #print (self.TOP_WIRE_MST)
        #print (self.TOP_WIRE_SLV)
        #print (self.TOP_ASSIGN)

    # Print Function
    def disp(self, i_str):
        if self.FLAG_DISP_MON : sys.stdout.write(i_str)
        if self.FLAG_DISP_FILE: self.f_rtl.write(i_str)

    # print Function
    def print_module(self):
        top_port_len = len(self.JSON['top']['ports'])
        top_port_len = top_port_len - 1
        self.disp('module '+self.JSON['top']['modname']+' (\n')
        for i in enumerate(self.JSON['top']['ports']):
            num = i[0]
            port  = i[1]
            if port['msb']==0 and port['lsb']==0:
                self.disp('    {:8}           {}'.format(port['dir'],port['port']))
            else:
                self.disp('    {:8}[{:>3}:{:>3}]  {}'.format(port['dir'],port['msb'],port['lsb'],port['port']))
            if num==top_port_len: self.disp('\n')
            else                : self.disp(',\n')
        self.disp(');\n')

    # print_wire
    def print_wire(self):
        wire_list = self.TOP_WIRE_MST + self.TOP_WIRE_SLV
        if self.open_o>0: wire_list = [{'name': self.WIRE_NAME_OPEN_O, 'msb': self.open_o-1, 'lsb': 0}] + wire_list
        if self.open_i>0: wire_list = [{'name': self.WIRE_NAME_OPEN_I, 'msb': self.open_i-1 , 'lsb': 0}] + wire_list
        if self.open_b>0: wire_list = [{'name': self.WIRE_NAME_OPEN_B, 'msb': self.open_b-1 , 'lsb': 0}] + wire_list
        len_max_msb, len_max_lsb = self.__max_len_from_wire_list(wire_list)
        for i in wire_list:
            port = i['name']
            msb  = i['msb']
            lsb  = i['lsb']
            self.disp('    wire    ')
            if msb==0 and lsb==0:
                self.disp('{0:{1}}  {2};\n'.format(' ', len_max_msb+len_max_lsb+3, port))
            else:
                self.disp('[{0:{1}}:{2:{3}}]  {4};\n'.format(msb, len_max_msb, lsb, len_max_lsb, port))
    # print_instance
    def print_instance(self):
        max_port_len = self.__max_len_instance_port()
        for i in self.JSON['instance']:
            inst_name = i
            mod_name  = self.JSON['instance'][inst_name]['modname']
            dic_param = self.JSON['instance'][inst_name]['parameter']
            
            # module - parameter - instnace_name
            if len(dic_param)>0:
                self.disp ('    {0}\n'.format(mod_name))
                self.disp ('        #(')
                flag_1st = True
                for key, value in dic_param.items():
                    if flag_1st: flag_1st = False
                    else       : self.disp(', ')
                    self.disp('.{0}({1})'.format(key, value))
                self.disp(')\n')
                self.disp ('    {0} (\n'.format(inst_name))
            else:
                self.disp ('    '+mod_name+' '+inst_name+' (\n')

            # .port ( wire ),
            flag_1st = True
            for port in self.DTOP[inst_name]:
                if flag_1st: flag_1st = False
                else       : self.disp(',\n')
                self.disp ('        '.format())
                self.disp ('.{0:{1}}   '.format(port, max_port_len))
                self.disp ('({0})'.format(self.DTOP[inst_name][port]['wire']))
            self.disp('\n    );\n')
            self.disp('\n')

    #print_assign
    def print_assign(self):
        # itemgetter <------ from operator import itemgetter, attrgetter
        #([assign_name, assign_width, assign_msb, assign_lsb, var_name, var_width, var_msb, var_lsb])
        for i in sorted(self.TOP_ASSIGN, key=itemgetter(0,2)):
            port  = i[0]
            width = i[1]
            msb   = i[2]; len_msb = len(str(msb))
            lsb   = i[3]; len_lsb = len(str(lsb))
            self.disp('    assign  ')
            if(msb==lsb):
                if width<=1: self.disp('{0} = '.format(port))
                else       : self.disp('{0}[{1}] = '.format(port,msb))
            else:
                self.disp('{0}[{1}:{2}] = '.format(port,msb,lsb))
            if len(i)==8:
                var_port  = i[4]
                var_width = i[5]
                var_msb   = i[6]
                var_lsb   = i[7]
                if(var_msb==var_lsb):
                    if var_width<=1: self.disp('{0};\n'.format(var_port))
                    else           : self.disp('{0}[{1}];\n'.format(var_port,var_msb))
                else:
                    self.disp('{0}[{1}:{2}];\n'.format(var_port,var_msb,var_lsb))
            else:
                #value = i[3]
                value = self.conv_dec_to_hex(i[4], (msb-lsb+1))
                self.disp('{0};\n'.format(value))

            # if port=="o_clk_out_0":
            #     print('---------')
            #     print (port)
            #     print (width)
            #     print (msb)
            #     print (lsb)
            #     print (var_port)
            #     print (var_width)
            #     print (var_msb)
            #     print (var_lsb)
            #     exit()

    def print_endmodule(self):
        self.disp('endmodule')

    # # determine backet or not, if all msb/lsb is 0, return False
    # def is_bracket(self, iport, imsb, ilsb):
    #     if imsb>0 or ilsb>0:
    #         return True
    #     for dic_port in self.TOP_WIRE_MST+self.TOP_WIRE_SLV:
    #         if iport==dic_port['name']:
    #             if dic_port['msb']==0 and dic_port['lsb']==0:
    #                 return False
    #             else:
    #                 return True
    #     try:
    #         if self.DTOP['$top'][iport]['msb']==0 and self.DTOP['$top'][iport]['lsb']==0:
    #             return False
    #         else:
    #             return True
    #     except:
    #         print("[LOG] *E, Can not find port name")
    #         print("      - port name = ")
            

                
        #print ('----')
        #print (self.TOP_WIRE_MST)
        #print (self.TOP_WIRE_SLV)
        #print (self.TOP_ASSIGN)


    # convert decimal to hex (verilog format)
    def conv_dec_to_hex(self, dec_value, bit_width):
        return "{0}\'h{1}".format(str(bit_width), str(hex(dec_value)[2:]))

    # max msb/lsb len in wire_list
    def __max_len_from_wire_list (self, idic):
        max_msb = 0
        max_lsb = 0
        for i in idic:
            msb = i['msb']
            lsb = i['lsb']
            if (max_msb<msb): max_msb = msb
            if (max_lsb<lsb): max_lsb = lsb
        return len(str(max_msb)), len(str(max_lsb))
    # max len in instance port list
    def __max_len_instance_port(self):
        port_len = 0
        max_len = 0
        for inst  in self.DTOP:
            if (inst=='$top'):
                continue
            for port in self.DTOP[inst].keys():
                port_len = len(port)
                if max_len<port_len: max_len = port_len
                #print (port+'='+str(port_len)+'='+str(max_len))
        #print ('++++++++++++++++')
        #print (max_len)

        return max_len
    




