#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Test legit-log and legit-show

# Testing usage
./legit-init
./legit-log                         # Error: no commits yet
./legit-show                        # Error: no commits yet
echo "hello world" > a.txt
./legit-add a.txt
./legit-commit -m "1st commit"

./legit-log hello there             # No cmd line args permitted
./legit-log 
# Invalid usage for legit-show
./legit-show      
./legit-show ":"
./legit-show 1:a.txt                # Unknown commit '1'
./legit-show 100:a.txt              # Unknown commit '2'
./legit-show hello:a.txt            # Unknown commit 'hello'
./legit-show :b                     # 'b' not found in index
./legit-show 0:b                    # 'b' not found in commit 0
./legit-show 0:a.txt hello        

# Correct
./legit-show 0:a.txt
./legit-show :a.txt

# Checking if first commit can still be seen after several commits
# have been made after removing 'a.txt'
./legit-rm a.txt
./legit-commit -m "2nd"
echo "1" > new
./legit-add new
./legit-commit -m "3rd"
echo "2" >> new
./legit-commit -a -m "4th"
 echo "3" >> new
./legit-commit -a -m "5th" 
echo "4" >> new
./legit-commit -a -m "6th"
echo "5" >> new
./legit-commit -a -m "7th"  

# Current commit number is 6
./legit-show 6:a.txt                # not found in commit 6
./legit-show 0:a.txt                # Should display "hello world"
./legit-log                         # Should display commits from latest to earliest
