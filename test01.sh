#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Testing successful and unsuccessful commits

./legit-init
touch a 
./legit-add a
# The following should fail
./legit-commit 
./legit-commit "no m flag passed in"
./legit-commit -m ""
./legit-commit "-m hello"

# Correct
./legit-commit -m "1st commit"

touch b
./legit-add b
./legit-commit -m "2nd commit"

./legit-add c
./legit-commit -m "3rd commit"        # 'c' did not get added, so no commit

# Changing contents of the file then changing back again
echo "hello" > file1
./legit-add file1                     # file1 contains "hello"
./legit-commit -m "3rd commit"
./legit-status
echo "hello 1" > file1
./legit-status                        # file1 contains "hello1"
echo "hello" > file1
./legit-status
./legit-commit -m "4th commit"        # nothing to commit, file still the same as committed version

# Committing a renamed version of a file
echo "hi" > text1
./legit-add text1
./legit-commit -m "4th commit"
./legit-status
mv text1 text2
./legit-status                        # text2 is untracked while text1 is deleted
./legit-add text2
./legit-status                        # text2 added to index, text1 file deleted
./legit-commit -m "5th commit"
