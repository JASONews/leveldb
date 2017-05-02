#i/usr/bin/python

import sys
import math

def dev(l):
	t = 0
	for i in l:
		t += float(i)
	avg = float(t) / len(l)
	t = 0
	for i in l:
		t += (float(i) - avg)**2
	return math.sqrt(t/len(l))

		
f = open(sys.argv[1])

header = f.readline()
t = []

for i in f:
    t.append(tuple(i.split(',')))

t.sort()

avg=[]
i = 0
cur = t[i][0]
total = 0
perops = 0
wa = 0
ic = 0
count = 0

devtotal = []
devperops = []
devic = []
devwa = []

while i < len(t):
    if t[i][0] == cur:
        total += float(t[i][1])
	perops += float(t[i][2])
	ic += float(t[i][3])
	wa += float(t[i][4])
	devtotal.append(t[i][1])
	devperops.append(t[i][2])
	devic.append(t[i][3])
	devwa.append(t[i][4])
	i += 1
        count+=1
    elif cur > 0:
        avg.append("%s,%f,%f,%f,%f,%f,%f,%f,%f" % (cur, total/float(count),dev(devtotal), perops/float(count), dev(devperops), ic/float(count), dev(devic), wa/float(count), dev(devwa)))
        cur = t[i][0]
        count = 0
	wa = 0
	ic = 0
	perops=0
        total = 0
	devtotal=[]
	devperops=[]
	devwa=[]
	devic=[]

avg.append("%s,%f,%f,%f,%f,%f,%f,%f,%f" % (cur, total/float(count),dev(devtotal), perops/float(count), dev(devperops), ic/float(count), dev(devic), wa/float(count), dev(devwa)))
f2 = open(sys.argv[1]+"_avg.csv",mode='w')
f2.write(header)
for i in avg:
    f2.write(i+"\n");


