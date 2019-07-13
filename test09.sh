#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Test implementation of merge using reference implementation

2041 legit-init
seq 1 10 > num.txt
2041 legit-add num.txt
2041 legit-commit -m "1st commit"
2041 legit-branch b1

# Test successful merge with b1
2041 legit-checkout b1
echo 11 >> num.txt
2041 legit-commit -a -m "2nd commit in b1"

2041 legit-checkout master
2041 legit-merge b1 -m "merge1"

# Test unsuccessful merge with b2 i.e. merge conflict
2041 legit-branch b2
2041 legit-checkout b2
echo 22 >> num.txt
2041 legit-commit -a -m "3rd commit in b2"

2041 legit-checkout master
echo 12 >> num.txt
2041 legit-commit -a -m "3rd commit in master"
2041 legit-merge b2 -m "failed merge"
2041 legit-log
2041 legit-status
