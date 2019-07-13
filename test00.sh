#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Testing for edges cases and invalid inputs into legit-add

./legit-init hello       # legit-init can not have any command line args
./legit-init                 
./legit-init             # .legit already exists

./legit-add              # usage error
touch a
./legit-add a
./legit-add b            # file does not exist
./legit-commit -m "1st commit"
mkdir random_dir
./legit-add random-dir   # not a regular file

# Checking multiple files passed in as command line args
touch b
./legit-add b b b b b b b
./legit-status
touch c d e f g h i
./legit-add c d e f g h i
./legit-status

echo "file with same contents" > file1
echo "file with same contents" > file2
./legit-add file1 file2
./legit-status

