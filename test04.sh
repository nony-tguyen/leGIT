#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Test legit-rm without the flags

./legit-init
./legit-rm                      # Repo does not have any commits
touch a
./legit-add a
./legit-commit -m "1st commit"
./legit-rm hello                # File does not exist in repository
touch hello
./legit-rm hello                # File does not exist in repository
./legit-rm a
./legit-status
./legit-show :a
./legit-commit -m "2nd commit"  # This commit should remove 'a' from showing on status
./legit-status

# legit-rm multiple files
./legit-add hello
./legit-commit -m "3rd commit"
./legit-rm hello hello world hello how are you  # Fails because 'world' is not in repo
./legit-rm hello hello hello    # Should successfully rm 'hello'
./legit-status
./legit-commit -m "4th commit"

# rm a file but continue to commit it and show it exists
echo "hello world" > file1
./legit-add file1
./legit-commit -m "5th commit"
rm file1
./legit-status
./legit-show :file1             # file1 still exists in repo but not in working directory
# file1 continues to exist for each commit
touch x
./legit-add x
./legit-commit -m "6th commit"
./legit-show 5:file1
./legit-show :file1
touch y
./legit-add y
./legit-commit -m "7th commit"
./legit-show 6:file1
./legit-show :file1
touch z
./legit-add z
./legit-commit -m "8th commit"
./legit-show 7:file1
./legit-show :file1
# file1 will no longer exist in index when legit-add'ed
./legit-add file1
./legit-show :file1             # file1 does not exist in index
./legit-commit -m "9th commit"
./legit-show 8:file1            # file1 does not exist in commit 8 
