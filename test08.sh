#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Test implementation of branch and checkout using reference implementation
2041 legit-init
touch commonfile
2041 legit-add commonfile
2041 legit-commit -m "available to everyone"
2041 legit-branch b1

# Make several commits to master, and verify commits are not in branch b1
echo "hello world" > n.txt
2041 legit-add n.txt
2041 legit-commit -m "2nd commit in master"
echo "hello 2nd world" > m.txt
2041 legit-add m.txt
2041 legit-commit -m "3rd commit in master"
2041 legit-status
cat n.txt m.txt
2041 legit-log

# Note the difference in time when the branches are created
2041 legit-branch b2

2041 legit-checkout b1
# Does not show n.txt and m.txt
2041 legit-status
2041 legit-log


2041 legit-checkout b2
# Should all show the same as master branch
2041 legit-status
cat n.txt m.txt
2041 legit-log

2041 legit-checkout master
2041 legit-branch -d master
2041 legit-branch -d b1
2041 legit-branch -d b2
