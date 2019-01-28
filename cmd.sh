python split_fa.py HIV_pol.consensus.renamed.fas
cat index.txt | parallel --col-sep "\t" "wgsim {1}.fa {2}_1.fq {2}_2.fq -N 500 -e 0.005 -1 150 -2 150"
bwa mem ref.fa HIV.pol.sample09_1.fq | samtools view -b - | samtools sort -o tmp.bam -
samtools index tmp.bam
python  simulate_mixed_call.py 0.1 | python remove_sames.py | gzip -c > tmp.fq.gz

cut -f2 index.txt > samples.txt
cat samples.txt | parallel "cat {}_1.fq | python remove_sames.py | gzip -c > {}.fq.gz"
mv tmp.fq.gz HIV.pol.sample09.fq.gz

rm *_1.fq rm *_2.fq tmp*

#bwa index ref.fa 
#cat samples.txt | parallel "bwa mem ref.fa {}.fq.gz | samtools view -b - | samtools sort -o {}.bam -"
#cat samples.txt | parallel "samtools index {}.bam"
#cat samples.txt |  parallel "bcftools mpileup -f ref.fa {}.bam | bcftools call -mvOz > {}.vcf.gz"
#cat samples.txt | parallel "bcftools index {}.vcf.gz"
#cat samples.txt| parallel  "bcftools consensus  -f ref.fa {}.vcf.gz | sed 's/ref/{}/'" > consensus.aln.fa


#CTTACCACA - TGTGGTAAG
#CTTTTCACA - TGTGAAAAG
