#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Test the different statuses
./legit-init

# Testing status of file when removed and added again
echo "hello world" > a.txt
./legit-add a.txt
./legit-commit -m "1st commit"
./legit-status                          # Should "same as repo"
./legit-rm a.txt
./legit-status                          # Should display "deleted"
# Create same file again
echo "hello world" > a.txt
./legit-status                          # Should display "untracked"
./legit-add a.txt                       
./legit-status                          # Now displays "same as repo" again
./legit-commit -m "2nd commit"          # 'nothing to commit' despite the changes made

# Testing different status not shown in the spec
echo "1" > file1
./legit-add file1
./legit-commit -m "2nd commit"
echo "2" >> file2
./legit-add file2                       # status: "file changed, different changes staged for commit"
rm file2
./legit-status                          # status: "file deleted, different changes staged for commit"
