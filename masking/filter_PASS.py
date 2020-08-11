outfile=open("/lustre/export/home/sylee/Hanchinese/try7/triodenovo/VQSR_filter_pass.vcf","w")

vcflist=[]
tablelist=[]
with open("/home/selee/VQSR/intermediate/MV.cgp.default.applyVQSR.tranch99.9.vcf","r") as vcf :
    for line in vcf:
        if(line.startswith("#")):outfile.write(line)
        else:
            tmp=line.split()
            if(tmp[6]=='PASS'):outfile.write(line)