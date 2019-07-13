#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Testing legit-commit with the "-a" option

./legit-init
echo "hello" > a
echo "hi" > b
./legit-add a b
./legit-commit -m "1st commit"
echo "world" >> a
echo "earth" > b
./legit-commit -m -a "2nd commit"       # Wrong order
./legit-commit -a -m "2nd commit"       
./legit-commit -a -m "3rd commit"       # nothing to commit

# This should perform the same results as rm --> legit-add --> legit-commit
rm a
rm b
./legit-status                          # shows a and b as file deleted
./legit-commit -a -m "3rd commit"       # removes the file from index and commits it
./legit-status                          # a and b no longer appear

# Remove a file from index, -a should no longer add it
touch x y z newfile
./legit-add x y z newfile
./legit-commit -m "4th commit"
./legit-rm --cached newfile
./legit-commit -a -m "5th commit"       # displays: nothing to commit
echo 1 > x
echo 2 > y
echo 3 > z
echo 4 > newfile
./legit-commit -a -m "5th commit"
./legit-show 4:newfile                  # newfile does not exist in commit 4


# Test files being swapped
echo "a" > file1
echo "b" > file2
./legit-add a b
./legit-commit -m "6th commit"
cp file1 temp
cp file2 file1
cp temp  file2                          # file1 and file2 are swapped
./legit-status
./legit-commit -a -m "7th commit"
