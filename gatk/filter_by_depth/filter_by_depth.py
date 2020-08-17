from multiprocessing import Process, Queue
import sys

def work(id):
    before=0
    linecount=0
    linecount=0
    with open("/lustre/export/home/sylee/Hanchinese/try8/"+id+"/chr22_mother.txt","r") as table :
    id={}
    for line in table:
        line=line.split()
        if(linecount==0):
            before=int(line[2])
            id[line[1]]=0
        else:
            diff=before-int(line[2])
            before=int(line[2])
            id[line[1]]=diff
        linecount=linecount+1
    return id
    
mother=def(mother)
print(mother)