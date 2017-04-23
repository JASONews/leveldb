#i/usr/bin/python

import sys

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
wa = 0
ic = 0
count = 0

while i < len(t):
    if t[i][0] == cur:
        total += float(t[i][1])
	ic += float(t[i][2])
	wa += float(t[i][3])
        i += 1
        count+=1
    elif cur > 0:
        avg.append("%s,%f,%f,%f" % (cur, total/float(count), ic/float(count), wa/float(count)))
        cur = t[i][0]
        count = 0
	wa = 0
	ic = 0
        total = 0

f2 = open(sys.argv[1]+"_avg.csv",mode='w')
f2.write(header)
for i in avg:
    f2.write(i+"\n");
