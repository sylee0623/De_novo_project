#PBS -lvnode=biglab3
#PBS -N datapreprocessing
#PBS -j oe
#PBS -o Datapreprocessing.log

work_dir=/lustre/export/home/sylee/Hanchinese/try3

#reference
reference=/lustre/export/home/sylee/ucsc_hg19/ucsc.hg19.fasta
GATK_bundle=/lustre/export/home/sylee/ucsc_hg19

# excute BQSR

cd ${work_dir}/result/gatk/

# excute BQSR
ls *.sorted.markdup.bam| while read id; do
    /lustre/export/home/sylee/programfile/gatk-4.1.7.0/gatk --java-options "-Xmx5g -Xms5g" \
    BaseRecalibrator \
        -R $GATK_bundle/ucsc.hg19.fasta \
        -I ${work_dir}/result/gatk/$id \
        --known-sites $GATK_bundle/dbsnp_138.hg19.vcf \
        --known-sites $GATK_bundle/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf \
        -O `basename $id .bam`.recal_data.table
done

# gatk ApplyBQSR 
ls *sorted.markdup.bam| while read id; do
    /lustre/export/home/sylee/programfile/gatk-4.1.7.0/gatk --java-options "-Xmx5g -Xms5g" \
    ApplyBQSR \
        --bqsr-recal-file `basename $id .bam`.recal_data.table \
        -R $GATK_bundle/ucsc.hg19.fasta \
        -I $id \
        -O `basename $id .bam`.BQSR.bam
done

ls *sorted.markdup.BQSR.bam| while read id; do /share/apps/programs/samtools/1.7/bin/samtools index $id; done
