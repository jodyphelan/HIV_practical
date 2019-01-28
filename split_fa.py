import pathogenseq as ps
import sys

f = ps.fasta(sys.argv[1]).fa_dict
O = open("samples.txt","w")
for s in f:
	open(s+".fa","w").write(">%s\n%s\n" % (s,f[s]))
	O.write(s+"\n")
O.close()
