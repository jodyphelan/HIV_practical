import subprocess
import sys
from itertools import islice
import re

reads = []
for l in subprocess.Popen("samtools view tmp.bam ref:940-941", shell = True, stdout=subprocess.PIPE).stdout:
	row = l.rstrip().split()
	reads.append(row[0])

fraction = float(sys.argv[1])
threshold =  int(len(reads)*fraction)
i = 0
F = open("HIV.pol.sample09_1.fq")
l1 = F.readline()
while True:
	l2 = F.readline()
	l3 = F.readline()
	l4 = F.readline()
	if "HIV.pol.sample" in l1 and l1.rstrip()[1:-2] in reads:
		if i<threshold:
			l2 = re.sub("TGTGGTAAG","TGTGAAAAG",l2)
			i+=1
	sys.stdout.write("%s%s%s%s" % (l1,l2,l3,l4))
	l1 = F.readline()
	if l1=="":break
