#!/usr/bin/python

import matplotlib.pyplot as plt

def check(n_max, div, mul, shift):
    for i in range(0, n_max):
	k1 = i/div
	k2 = (i*mul)>>shift
	if(k1 != k2):
	    return False

    return True


n_max = 16384

for mul in range(1, 131072):
    for shift in range(3, 18):
	if(check(n_max, 5, mul, shift)):
	    print("Found: mul %d shift %d" % (mul, shift))