#!/usr/bin/python

import matplotlib.pyplot as plt


phi=[1222]


k=1
for i in range(1, 1000):
    phi.append((phi[-1] + k) % 16384)
    k+=3

phi_d = phi[0]

phi_div = [phi[0]]
bias=0
offset=phi[0]

for i in range(1, 1000):
    if(phi_d > phi[i]):
	bias+=1
	if( bias >= 5 ):
	    bias = 0
    phi_div.append(((phi[i]-offset)/5 + bias * (16384/5) + offset) % 16384)
    phi_d=phi[i]


plt.plot(phi)
plt.plot(phi_div)
plt.grid()
plt.show()
