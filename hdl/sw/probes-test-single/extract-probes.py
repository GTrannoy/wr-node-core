#!/usr/bin/python

import sys
import subprocess
import string
import struct

T_PROF_START = 2
T_PROF_STOP = 3
T_TRIGGER = 1
T_DEFINE = 0

ACT_START_REC = 0
ACT_STOP_REC = 1
ACT_TRIGGER = 2

class TPUChannel:
  def __init__(self, action, pc, core_id ):
    self.action=action
    self.pc=pc
    self.core_id=core_id
    self.channel_id=0




def process_file(filename,ch,core_id):
    t = subprocess.check_output(["objdump", "-h", filename])
    for l in t.split('\n'):
      toks = l.split()
      if(len(toks) > 1 and toks[1] == ".mt_probes"):
        size=int(toks[2],16)
        file_offset=int(toks[5],16)
        f=open(sys.argv[1],"rb")
        f.seek(file_offset)
        data=f.read(size)
        offs = 0
        while(offs < len(data)):
    #      print(len(data))
          tag=struct.unpack_from(">I", data, offs )[0]
    #      print(tag)
          offs+=4
          if(tag == T_PROF_START):
            (id,addr)=struct.unpack_from(">II", data, offs )
            offs+=8
            print("config %x %x %x %x %x" % ( ch, ACT_START_REC, core_id, addr, id ) )
            ch+=1
          if(tag == T_PROF_STOP):
            (id,addr)=struct.unpack_from(">II", data, offs )
            offs+=8
            print("config %x %x %x %x %x" % ( ch, ACT_STOP_REC, core_id, addr, id ) )
            ch+=1
    #        print("profile_stop %x %x %x" % ( 0, id, addr ) )
          elif(tag == T_TRIGGER):
            (id,addr)=struct.unpack_from(">II", data, offs )
            offs+=8
    #        print("trigger %x %x %x" % ( 0, id, addr ) )
            print("config %x %x %x %x %x" % ( ch, ACT_TRIGGER, core_id, addr, id ) )
            ch+=1

          elif(tag == T_DEFINE):
            id=struct.unpack_from(">I", data, offs )[0]
            offs+=4
            name=""
            while(data[offs] != chr(0)):
    #          print(data[offs])
              name += data[offs]
              offs+=1

            offs+=len(name)+1
            print ("name %x %s" % ( id, name ) )
    return ch

ch = 0
for i in range(1, len(sys.argv)):
    ch = process_file(sys.argv[i], ch, i - 1)
