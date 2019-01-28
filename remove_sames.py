import sys
import re

for l in sys.stdin:
	if "HIV.pol.sample" in l:
		#@HIV.pol.sample01.FJ199575_cl3_360_827_0:0:0_0:0:0_2/1
		l = re.sub("\.\w+_\w+","",l)
	sys.stdout.write(l)
		
		 
