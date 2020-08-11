linecount=0
content=[]
chrN="0"

chrlist=["chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20","chr21""chr22","chrX"]
with open("/lustre/export/home/mhchoi/2.Reference/0.Chromosome_files/0.GRCh37.p13/3.Renewal_download/RepeatMasker_data/hg19.fa.out") as vcf :
        for line in vcf :
            linecount=linecount+1
            tmp=line.split()
            if(linecount<=3) : continue
            else :
                start_pos=int(tmp[5])
                end_pos=int(tmp[6])
                if(chrN==tmp[4]):
                    for denovo_line in content :
                        if(denovo_line[0].startswith("#")):continue
                        elif(end_pos<int(denovo_line[1])) : break
                        elif(start_pos<=int(denovo_line[1])) : content.remove(denovo_line)
                else : 
                    print("chr :",chrN,"after_remove :",len(content))
                    outfile=open("/lustre/export/home/sylee/Hanchinese/try7/triodenovo/masking/"+chrN+"delete_repeat"+".vcf","w")
                    for i in content :
                        line="\t".join(i)
                        outfile.write("%s"%(line))
                    outfile.close()
                    chrN=tmp[4]
                    chrlist.remove(tmp[4])
                    content=[]
                    with open("/lustre/export/home/selee/triodenovo/triodenovo_masking/"+chrN+".triodenovo.vcf","r") as denovo :
                        for denovo_line in denovo:
                            tmp_denovo=denovo_line.split("\t")
                            content.append(tmp_denovo)
                        print("chr :",chrN,"before_remove :",len(content))