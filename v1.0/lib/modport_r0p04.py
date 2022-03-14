# =================================================================
# Copyright (C) 2011 Alphachips Co. ,All Rights Reserved
# Alphachips Co. Proprietary & Confidential
# File Name   : modport.py 
# Description :
# Author      : Yun Kyoung Ro ( roy@alphachips.com )
# =================================================================
#
# History     :
#  2020-09-05  jimmy : modify remove parameter list
#  2017-08-31  jimmy : Correct get parameter function
#  2014-07-08  jimmy : instance_info class is added
#  2011-04-05  jimmy : /* */ comment error correction 
#  2011-02-11  1st Release
#
# =================================================================


import os
import sys
import re

class con_info :
    con_wire = ''
    con_inst = ''
    con_port = ''

class port_info :
    module_name = ''
    dir = ''
    type = ''
    width = 0
    name = ''
    msb = ''
    lsb = ''
    parameter_list = []
#    con_info_list = []
    
    def get_port_str (self) :
        msb_str = str(self.msb)
        lsb_str = str(self.lsb)
        port_str = self.dir+' '+'['+msb_str+':'+lsb_str+'] '+self.name
        return port_str

class instance_info :
    module_name = ''
    module_index = 0
    instance_name = ''
    port_info_list = []
    param_list = []

    def get_instance_str(self) :
        s = self.module_name
        if self.param_list != [] :
            s = s+'\t#(\n'
            for i, param in enumerate(self.param_list) :
                if i != len(self.param_list)-1 :
                    s = s+'\t.'+param[0]+'('+param[1]+'),\n'    
                else :
                    s = s+'\t.'+param[0]+'('+param[1]+')\n'    
            s = s+')\n'
        s = s+'\t'+self.instance_name + '(\n'
        for i, pi in enumerate(self.port_info_list) :
            if pi.con_info_list != None :
                if len(pi.con_info_list) > 0 :
                    con_wire = pi.con_info_list[0].con_wire
                else :
                    con_wire = ''
            else :
                con_wire = ''
            if i != len(self.port_info_list)-1 :
                s = s+'\t.'+pi.name+'\t\t( '+con_wire+' ),\n'
            else :
                s = s+'\t.'+pi.name+'\t\t( '+con_wire+' )\n'
        s = s+');\n'

        return s

    def get_empty_instance_str(self) :
        s = self.module_name
        if self.param_list != [] :
            s = s+'\t#(\n'
            for i, param in enumerate(self.param_list) :
                if i != len(self.param_list)-1 :
                    s = s+'\t.'+param[0]+'('+param[1]+'),\n'    
                else :
                    s = s+'\t.'+param[0]+'('+param[1]+')\n'    
            s = s+')\n'
        s = s+'\t'+self.instance_name + '(\n'
        for i, pi in enumerate(self.port_info_list) :
            con_wire = ''
            if i != len(self.port_info_list)-1 :
                s = s+'\t.'+pi.name+'\t\t( '+con_wire+' ),\n'
            else :
                s = s+'\t.'+pi.name+'\t\t( '+con_wire+' )\n'
        s = s+');\n'

        return s

class modport :

# strbits = 1 : ADDR_WIDTH-1
# strbits = 0 : 31

    def __init__ (self, fn, defs, params, strbits=1) :
        self.port_info_set = []
        self.port_list = []
        self.port_info_list = []
        self.module_name = ''
        self.dic_param = {}
#        self.dic_param_update = {}
        #self.parameter_info = {}  # not use
        self.parameter_list = []
        #self.param_name = []
        #self.param_value = []
        #self.param_name_set = []
        #self.param_value_set = []
        self.wire_list = []
        self.defs_list = defs
        self.string_bit = strbits

        # Parameter Update
        if type(params)==dict:
            self.dic_param_update = params
        else:
            assert(0), '[ERROR] params input type must be \'dict\' type'

        # Port Read
        self.modf = open(fn)
        lines = self.modf.read()
        lines = lines.split('endmodule')

        for line in lines :
            new_line = line

            if new_line.find('module') == -1 : break

            while  (new_line.find('//') > -1) or (new_line.find('/*') > -1) :
                new_line = self.del_comment_line(new_line)

            self.make_port_info(new_line)

            self.port_info_set.append(self.port_info_list)

            ## update parameter information
            #self.param_name_set.append(self.param_name)
            #self.param_value_set.append(self.param_value)

            self.port_list = []
            self.port_info_list = []
            self.module_name = ''
            #self.parameter_info = {}
            self.wire_list = []
            #self.param_name = []
            #self.param_value = []



    def del_last_comma (self, port_list) :
        port = port_list[-1]
        s = port.find(',') 
        if s > 0 : 
            port  = port[:-1]
        port_list[-1] = port
    
    #def del_comment (self, line) :
    #    com = line.find('//')
    #    line = line[0:com]
    def remove_bit_str_space (self, str) :
        start = str.find('[')
        end = str.find(']')
        if start == -1 : return str
        pre = str[:start-1]
        post = str[end+1:]
        post = post.strip()
        bit_str = str[start:end+1]
        bit_str_new = ''
        for ch in bit_str :
            if ch != ' ' and ch != '    ' :
                bit_str_new = bit_str_new+ch
        return pre+' '+bit_str_new+' '+post
    
    def make_port_list (self, lines) :
        for port in lines :
            port.strip()
            port.expandtabs()
            port = self.remove_bit_str_space(port)
            port = port.split()    
            num = len(port)
            if num > 0 :
                if port[-1] == ',' :
                    del port[-1]
                self.port_list.append(port)

    def calc_bitwidth (self, bit_str) :
        bit_str = bit_str.split(':')
        msb_str = bit_str[0]
        lsb_str = bit_str[1]
        msb_str = msb_str.split('[')
        if msb_str[1].isdigit() > 0  :
            msb = int(msb_str[1])
        else :
            msb = msb_str[1]
        lsb_str = lsb_str.split(']')

        if lsb_str[0].isdigit() > 0 :
            lsb = int(lsb_str[0])
        else :
            lsb = lsb_str[0]

        if str(msb).isdigit() > 0 and str(lsb).isdigit() > 0 :
            return int(msb)-int(lsb)+1
        else :
            #rs = str(msb)+'-'+str(lsb)+'+1'
            #rs = str(msb[:-2])
            rs = str(msb)
            return rs

    def calc_parameter (self, line) :
        if self.string_bit==1 or line.isdigit()==True :
            return line
        else:
            return eval(line, self.dic_param)
#        else:
#            for i, param in enumerate(self.parameter_list) :
#                start = line.find(param[0])
#                width = len(param[0])
#                if start > -1 :
#                    return eval(line[:start]+self.param[1]+line[start+width:])

    def get_msb(self, bit_str) :
        bit_str = bit_str.strip()
        bit_str = bit_str.split(':')
        msb_str = bit_str[0]
        lsb_str = bit_str[1]
        msb_str = msb_str.split('[')
        if msb_str[1].isdigit() > 0  :
            msb = int(msb_str[1])
        else :
            #msb = msb_str[1]
            msb = self.calc_parameter(msb_str[1])
        return msb

    def get_lsb(self, bit_str) :
        bit_str = bit_str.strip()
        bit_str = bit_str.split(':')
        lsb_str = bit_str[1]
        lsb_str = lsb_str.split(']')

        if lsb_str[0].isdigit() > 0 :
            lsb = int(lsb_str[0])
        else :
            #lsb = lsb_str[0]
            lsb = self.calc_parameter(lsb_str[0])

        return lsb

    def get_parameter (self, line) :
        s = line.find('parameter')
        if s<0: return True
        line = line[s:]
        s = line.find(')')
        line = line[0:s-1]
        line = line.replace('parameter','').replace('\n','')
        plist = line.split(',')
        for pl in plist :
            key, value = pl.split('=')
            self.dic_param[key.strip()] = int(value.strip())
        return True

    def __get_parameter (self, line) :
        searchObj = re.finditer(r'\s*parameter(\s*(\w*)\s*=\s*(.*)([,|;])\s*)+', line)
        for pat in searchObj:
            new_str = pat.group(0)
            s = new_str.find('parameter')
            sub_str = new_str[s+1:]
            subObj = re.finditer(r'\s*(\w*)\s*=\s*(.*)([,|;])', sub_str)
            for subpat in subObj :
                name = subpat.group(1)
                value = subpat.group(2)
                #self.parameter_info[name] = value   # not use
                self.parameter_list.append((name, value))
                #self.param_name.append(name)
                #self.param_value.append(value)
        #print (self.parameter_list)



#    def del_comment_line (self, line) :
#        # delete comment line
#        s = line.find('//')
#        e = line[s+2:].find('\n') + s + 2
#        if s > -1 :
#            #new_line = line[:s]+line[e+1:]
#            new_line = line[:s]+'\n'+line[e+1:]
#            return new_line
#        else :
#            new_line = line
#            return new_line 

    def del_comment_line (self, line) :
        # delete comment line
        comm_s = line.find('//')
        star_s = line.find('/*')

        # comment //
        if   (comm_s > -1) and ((star_s==-1) or (comm_s<star_s)) :
            end_line = line[comm_s+2:].find('\n')
            new_line = line[:comm_s]+'\n'+line[(comm_s+2)+(end_line+1):]
        # comment /*
        elif (star_s > -1) and ((comm_s==-1) or (star_s<comm_s)) :
            end_line = line[star_s+2:].find('*/')
            new_line = line[:star_s]+'\n'+line[(star_s+2)+(end_line+2):]
        else:
            print ('[ERROR]')
            print (line)
            print (line.find('//'))
            print (line.find('/*'))
            assert(0)

        return new_line

    def get_task_line (self, lines) :
        task_line_list = []
        for num, line in enumerate(lines) :
            if line.find('task') > -1 and line.find('endtask') == -1 :
                start = num
            if line.find('endtask') > -1 :
                end = num
                task_line_list.append((start, end))

        return task_line_list

    def get_function_line (self, lines) :
        function_line_list = []
        for num, line in enumerate(lines) :
            if line.find('function') > -1 and line.find('endfunction') == -1 :
                start = num
            if line.find('endfunction') > -1 :
                end = num
                function_line_list.append((start, end))

        return function_line_list

    def del_comment (self, line) :
        cs = line.find('//')
        if cs > 0 :
            new_line = line[:cs-1]
        elif cs == 0 :
            new_line = ''
        else :
            new_line = line

        return new_line

    def del_empty_line (self, lines) :
        # delete comment line
        for num, line in enumerate(lines) :
            line = line.strip()
            if line == '' :
                del lines[num]
                self.del_empty_line(lines)



    def make_port_lines (self, lines) :
        for num, line in enumerate(lines) :
            s = line.find(';')
            if s>0 :
                end_line = num-1
                break            

        lines = lines[:end_line]
        return lines

    def make_port_defs (self, lines) :
        stms = lines.split(';')
        # remove character before module name
        start = stms[0].find('module')
        stms[0] = stms[0][start:]
        n = stms[0].find('(')
        if stms[0][n-1] != ' ' and stms[0][n-1] != '    ':
            stms[0] = stms[0][:n] + ' '+ stms[0][n:]

        # get module name
        st = stms[0].split()
        self.module_name = st[1]

        s = stms[0].find('#')
        e = stms[0].find(')')

        # remove parameter list
        s = stms[0].find('#')
        e = stms[0].find(')')
        if s>0:
            self.param_str = stms[0][s+1:e+1]
            stms[0] = stms[0][:s-1]+stms[0][e+1:]
        else:
            self.param_str = ''

        stms[0] = stms[0].split(',')

        # remove '//' comment line
        num = len(stms[0])
        for i in range(num) :
            stms[0][i] = self.del_comment(stms[0][i])            

        # remove '(',  ')' port definition parenthesis
        start = stms[0][0].find('(')
        stms[0][0] = stms[0][0][start+1:]    
        end = stms[0][-1].find(')')
        
        stms[0][-1] = stms[0][-1][:end]
    
        port_def = []
        task_line = []
        function_line = []

        for st in stms[0] :
            if re.match('\*sinput\s*', st) != None or re.match('\s*output\s*', st) != None or re.match('\s*inout\s*', st) != None :
                port_def = stms[0]
                break

        if len(port_def) > 0 : 
            for num, st in enumerate(port_def) :
                start = st.find('input') or st.find('output') or st.find('inout') 
                if start > -1 :
                    port_def[num] = port_def[num][start:]
        else :
            stms = stms[1:]

            for num, st in enumerate(stms) :
                stms[num] = stms[num].strip()
                 
            task_line = self.get_task_line(stms)
            function_line = self.get_function_line(stms)

            for s, e in task_line :
                num = e-s+1
                for i in range(num) :
                    stms[s+i] = '//'+stms[s+i]

            for s, e in function_line :
                num = e-s+1
                for i in range(num) :
                    stms[s+i] = '//'+stms[s+i]

            for num, st in enumerate(stms) :
                stms[num] = self.del_comment(stms[num])


            for num, st in enumerate(stms) :
                start = -1
                if re.match('\s*input\s*', st) != None :
                    start = st.find('input')
                    dir = 'input'
                elif re.match('\s*output\s*', st) != None :
                    start = st.find('output')
                    dir = 'output'
                elif re.match('\s*inout\s*', st) != None :
                    start = st.find('inout')
                    dir = 'inout'

                if start > -1 :
                    st = st[start:]

                    bit_start = st.find('[')
                    bit_end = st.find(']')
                    if bit_start > -1 :
                        bit_str = st[bit_start:bit_end+1]
                    else :
                        bit_str = ''

                    if bit_end > -1 :
                        #sig_name = st[bit_end+1:]
                        sig_name = st[bit_end:]
                    else :
                        if dir == 'input' or dir == 'inout' :
                            sig_name = st[5:]
                        else :
                            sig_name = st[6:]

                    # Roy 2014-9-16
                    sig_name_list = sig_name.split(',')
                    for i in range(len(sig_name_list)) :
                        sig_name_list[i] = sig_name_list[i].strip()

                    new_bit_str = ''
                    for ch in bit_str :
                        if ch != ' ' and ch != '    ' :
                            new_bit_str = new_bit_str + ch

                    bit_str = new_bit_str
                    if bit_str != '' :
                        st_tmp = [dir, bit_str] 
                    else :
                        st_tmp = [dir]


                    for i in range(len(sig_name_list)) :
                        st_tmp.append(sig_name_list[i])
                        

                    wire_str = ''
                    for i in range(len(st_tmp)) :
                        wire_str = wire_str+st_tmp[i]+' '

                    #for n, i  in enumerate(st_tmp) :
                    #    s = i.find(',')
                    #    if s > -1 :
                    #        st_tmp[n] = st_tmp[n][:s]

                    #print st_tmp

                    if st_tmp[1][0] == '[' :
                        if len(st_tmp) > 3 :
                            for i in range(len(st_tmp)-2) :
                                st = dir+' '+st_tmp[1]+' '+st_tmp[i+2]
                                port_def.append(st)
                        else :
                            port_def.append(wire_str)
                    else :
                        if len(st_tmp) > 2 :
                            for i in range(len(st_tmp)-1) :
                                st = dir+' '+st_tmp[i+1]
                                port_def.append(st)
                        else :
                            port_def.append(wire_str)

                    #port_def.append(st)
        return port_def 

    def remove_ifdefs (self, lines, defs_list) :
        start = lines.find('`ifdef')
        end = lines.find('`endif')+6
        ifdef_line = lines[start:end]
        if_else_p = re.compile(r'.*?`ifdef\s+(\w+)(.*)`else', re.S)
        else_end_p = re.compile(r'.*?`else(.*)`endif', re.S)
        if_end_p =  re.compile(r'.*?`ifdef\s+(\w+)(.*)`endif', re.S)
        m = if_else_p.match(ifdef_line)
        if m != None :
            def_word = m.group(1)
            if_else_str = m.group(2)
            m = else_end_p.match(ifdef_line)
            else_end_str = m.group(1)
            if def_word in defs_list :
                ifdef_str =  if_else_str
            else :
                ifdef_str =  else_end_str
        else :
            m = if_end_p.match(ifdef_line)
            def_word = m.group(1)
            if def_word in defs_list :
                ifdef_str = m.group(2)
            else :
                ifdef_str = ''

        new_line =  lines[:start-1]+' '+ifdef_str+' '+lines[end+1:]

        return new_line    

    def remove_star_comment (self, lines) :
        tmp_lines = lines
        start = tmp_lines.find('/*')
        end = tmp_lines.find('*/')+3
        if start > 1 :
            new_line =  tmp_lines[:start-1]+' '+tmp_lines[end:]
        else :
            new_line = tmp_lines[end:]
        
        return new_line    

    def make_port_info (self, lines) :
        self.parameter_list = []
        self.get_parameter(lines)
        # Parameter Update by Input
        if len(self.dic_param_update)>0:
            for key, value in self.dic_param_update.items():
                self.dic_param[key] = value

        end_line = 0

        while lines.find('`ifdef') > -1 :
            lines = self.remove_ifdefs (lines, self.defs_list)

        while lines.find('/*') > -1 :
            lines = self.remove_star_comment (lines)

        lines = self.make_port_defs(lines)
        self.make_port_list (lines)

        for pl in self.port_list :
            num = len(pl)
            pi = port_info()
            pi.dir = pl[0]

            if pl[1].find('[') > -1 and num == 3 :
                pi.type = 'wire'
            elif pl[1].find('[') == -1 and num == 2 :
                pi.type = 'wire'
            else :
                pi.type = pl[1]

            if pl[1].find('[') > -1 :
                pi.width = self.calc_bitwidth(pl[1])
                pi.msb = self.get_msb(pl[1])
                pi.lsb = self.get_lsb(pl[1])
            elif num > 2 and pl[2].find('[') > -1 :
                pi.width = self.calc_bitwidth(pl[2])
                pi.msb = self.get_msb(pl[2])
                pi.lsb = self.get_lsb(pl[2])
            else :
                pi.width = 1
                pi.msb = 0
                pi.lsb = 0
            pi.name = pl[-1]
            pi.module_name = self.module_name
            pi.param_str = self.param_str
            pi.parameter_list = self.parameter_list
            #print(pi.parameter_list)
            self.port_info_list.append(pi)

        #print self.port_list
        self.modf.close()

    def make_wire_def (self, of, prefix, postfix) :
        for pi in self.port_info_list :
            if str(pi.width).isdigit() > 0 :
                of.write( pi.type+'    '+'['+str(int(pi.width)-1)+':0]    '+prefix+pi.name+postfix+';\n')
            else :
                width_str = pi.width
                m = re.match('[0-9a-zA-Z_*(*)*]+', width_str)
                pi.width = m.group()
                tmpl = width_str.split('-')
                if len(tmpl) > 1 :
                    surfix = '-'+tmpl[1]
                else :
                    surfix = ''
                #m = re.search('[^a-zA-Z_*]+', width_str)
                #if m == None :
                #    surfix = ''        
                #else :
                #    surfix = m.group()
                of.write( pi.type+'    '+'['+prefix+pi.width+postfix+surfix+':0]    '+prefix+pi.name+postfix+';\n')

            self.wire_list.append(prefix+pi.name+postfix)

    def make_default_assign (self, name, val) :
        assign_list = []
        for wire in self.wire_list :
            if wire.find(name) > -1 :
                s = 'assign '+wire+' = '+str(val)+';'
                assign_list.append(s)
        return assign_list    

    def set_module_name (self, module_name) :
        for pl in self.port_info_set :
            pi = pl[0]
            if pi.module_name == module_name :
                self.port_info_list = pl
                return 1
        else :
            print ('*E, Not find '+module_name+' in port information list')
            return -1

    def make_port_wire_list (self, insf, prefix, tag_list, inst_num) :
        self.wire_list = []
        post_list = []
        for pre, post in tag_list :
            if pre == prefix :
                post_list.append(post)

        for i in range(inst_num) : 
            if post_list == [] :
                postfix = ''
            else :
                postfix = post_list[i]
            self.make_wire_def (insf, prefix, postfix)
            insf.write('\n\n')

    def make_instance (self, inst_name, fname, prefix, tag_list, inst_num) :
        insf = open(fname, 'w')

        self.make_port_wire_list(insf, prefix, tag_list, inst_num)

        post_list = []
        inst_list = []

        for pre, post in tag_list :
            if pre == prefix :
                post_list.append(post)

        for i in range(inst_num) : 
            if post_list == [] :
                postfix = ''
            else :
                postfix = post_list[i]

            self.module_name = self.port_info_list[0].module_name
            s = self.module_name + ' ' + prefix+inst_name + postfix +' ' '(\n'
            insf.write(s)
            inst_list.append(prefix+inst_name+postfix)

            end_num = len(self.port_info_list) - 1
            for num, pi in enumerate(self.port_info_list) :
                if num != end_num :
                    s = '    .'+pi.name+'    ( '+prefix+pi.name+postfix+' ),\n'
                else :
                    s = '    .'+pi.name+'    ( '+prefix+pi.name+postfix+' )\n'
                
                insf.write(s)

            s = ');\n\n'
            insf.write(s)

        insf.close()
        return inst_list

    def make_instance (self, inst_name, param_list) :

        param_str = '#('
        i = 0
        for param in param_list :
            if i != len(param_list)-1 :
                param_str = param_str+'.'+param[0]+'('+param[1]+'), \n'
            else :
                param_str = param_str+'.'+param[0]+'('+param[1]+') \n'
            i = i+1
        param_str = param_str+') \n'
        self.module_name = self.port_info_list[0].module_name
        s = self.module_name + ' ' + param_str +inst_name + ' ' '(\n'

        end_num = len(self.port_info_list) - 1
        for num, pi in enumerate(self.port_info_list) :
            if num != end_num :
                s = s+'    .'+pi.name+'    ( '+pi.con_wire+' ),\n'
            else :
                s = s+'    .'+pi.name+'    ( '+pi.con_wire+' )\n'
            
        s = s+');\n\n'

        return s

    def get_wire_list (self, wname) :
        wlist = []
        for wire in self.wire_list :
            if wire.find(wname) > 0 :
                wlist.append(wire)    
        return wlist

if __name__ == "__main__" :
    
    #defs_list = ['DWC_DDR3PHY_V2', 'DDR_PROD_DDR3']
    #top_port = modport('./DWC_DDR3PHY.v', defs_list)
    #top_port.set_module_name('DWC_DDR3PHY')
    #top_port.make_instance('u_DDR3PHY', 'ddr3_phy_inst.v', '', [], 1)

    defs_list = []
#top_port = modport('./s926.v', defs_list)
#    top_port.set_module_name('s926')
#    top_port.make_instance('u_s926', 's926_inst.v', '', [], 1)

    top_port = modport('./AhbMToAxiWrapper.v', defs_list)
    #$top_port = modport('platform_top.v')

    #ahbm_num = 0
    #axim_num = 0

    for ps in top_port.port_info_set :
        for pi in ps :
            print ('Module Name  : '+pi.module_name)
            print ('Name  : '+pi.name)
            print ('Dir   : '+pi.dir)
            print ('Type  : '+pi.type)
            print ('Width : '+str(pi.width))
            print ('MSB   : '+str(pi.msb))
            print ('LSB   : '+str(pi.lsb))
            print ('\n\n')
    
    #print 'Total Number of AHB Maater port = '+str(ahbm_num)

    #top_port.make_instance('u_platform_top', 'platform_inst.v')

    #top_port.set_module_name('platform_top')
    #top_port.make_instance('u_platform_top', 'platform_inst.v', '', [], 1)
    #top_port.make_instance('u_vm_ahb', 'vm_ahb_cbus_inst.v', 'c_', 3)
    #top_port.make_instance('u_vm_ahb', 'vm_ahb_lbus_inst.v', 'l_', 6)
    #top_port.make_instance('u_axi_slave', 'axi_cbus_slave_inst.v', 'c_', 1)
    #top_port.make_instance('u_axi_slave', 'axi_bbus_slave_inst.v', 'b_', 1)
