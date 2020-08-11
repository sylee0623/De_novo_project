work_dir=/lustre/export/home/sylee/Hanchinese/try3

#reference
reference=/lustre/export/home/sylee/ucsc_hg19/ucsc.hg19.fasta
GATK_bundle=/lustre/export/home/sylee/ucsc_hg19

for ((a=1;a<=5;a++))
do
qsub -lvnode=biglab1 -j oe -o HC${i} -N HC${i} -- /lustre/export/home/sylee/programfile/gatk-4.1.7.0/gatk --java-options "-Xmx5g -Xms5g" HaplotypeCaller \
    --input /lustre/export/home/sylee/Hanchinese/try3/result/gatk/daughter.sorted.markdup.BQSR.bam \
    --output /lustre/export/home/sylee/Hanchinese/try3/result/gatk/HaplotypeCaller/chr${a}.hc.g.vcf.gz \
    --reference ${reference} \
    --emit-ref-confidence GVCF \
    --native-pair-hmm-threads 32 \
    --L chr$a
done;

for ((a=6;a<=10;a++))
do
qsub -lvnode=biglab2 -j oe -o HC${i} -N HC${i} -- /lustre/export/home/sylee/programfile/gatk-4.1.7.0/gatk --java-options "-Xmx5g -Xms5g" HaplotypeCaller \
    --input /lustre/export/home/sylee/Hanchinese/try3/result/gatk/daughter.sorted.markdup.BQSR.bam \
    --output /lustre/export/home/sylee/Hanchinese/try3/result/gatk/HaplotypeCaller/chr${a}.hc.g.vcf.gz \
    --reference ${reference} \
    --emit-ref-confidence GVCF \
    --native-pair-hmm-threads 32 \
    --L chr$a
done;

for ((a=11;a<=22;a++))
do
qsub -lvnode=biglab3 -j oe -o HC${i} -N HC${i} -- /lustre/export/home/sylee/programfile/gatk-4.1.7.0/gatk --java-options "-Xmx5g -Xms5g" HaplotypeCaller \
    --input /lustre/export/home/sylee/Hanchinese/try3/result/gatk/daughter.sorted.markdup.BQSR.bam \
    --output /lustre/export/home/sylee/Hanchinese/try3/result/gatk/HaplotypeCaller/chr${a}.hc.g.vcf.gz \
    --reference ${reference} \
    --emit-ref-confidence GVCF \
    --native-pair-hmm-threads 32 \
    --L chr$a
done;

qsub -lvnode=biglab3 -j oe -o HC${i} -N HC${i} -- /lustre/export/home/sylee/programfile/gatk-4.1.7.0/gatk --java-options "-Xmx5g -Xms5g" HaplotypeCaller \
    --input /lustre/export/home/sylee/Hanchinese/try3/result/gatk/daughter.sorted.markdup.BQSR.bam \
    --output /lustre/export/home/sylee/Hanchinese/try3/result/gatk/HaplotypeCaller/chrX.hc.g.vcf.gz \
    --reference ${reference} \
    --emit-ref-confidence GVCF \
    --native-pair-hmm-threads 32 \
    --L chrX
