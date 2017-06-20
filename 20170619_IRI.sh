#!/usr/bin/bash

Ctlr-a #get to beginning of line
Ctlr-e #get to end of line
Ctlr-u #delete everything before cursor
Ctlr-k #delete everything after cursor
Ctlr-r #search in command history

### display only explicit columns
cut -f [number of column(s)]
### word count
wc 

### sorting regular
sort
### sorting numerically
sort -n
### sorting reversely
sort -r

### look for unique lines (and count them)
### needs to be sorted FIRST
uniq -c

### search sequence
grep
-c count
-i insensitive
grep A genes.csv | cut -f 3

### for loops
for i in t*.txt; do echo $i; done
for afile in t*.txt; do echo $afile; done
for afile in t*.txt; do echo $afile; cp $afile coyp_of_$afile; done

### jupyter
jupyter notebook
http://localhost:8888/?token=64081fa703635dd417cae5a18be076c9cc063e3c24c9f1e2





