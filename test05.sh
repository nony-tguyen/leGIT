#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Test legit-rm without the flags, checking all edge cases
./legit-init

# Removing from index and adding it again
touch a
./legit-add a
./legit-commit -m "1st commit"
./legit-rm --cached a
./legit-add a
./legit-commit -m "2nd commit"          # nothing to commit

# Testing the different cases of legit-rm and its error messages
# Case: file has changes staged in index --> error msg
echo "b" > b
./legit-add b
./legit-rm b
./legit-commit -m "2nd commit"
echo "new b" > b
./legit-add b
./legit-rm b
./legit-rm --force b                    # works

# Case: file in index is different to both working file and repository
echo "c" > c
./legit-add c
./legit-commit -m "3rd commit"
echo "c1" > c
./legit-add c
echo "c2" > c
./legit-rm c
./legit-rm --cached c
./legit-rm --force --cachedc            # works

# Case: file in repository is different to working file
echo "d" > d
./legit-add d
./legit-commit -m "4th commit"
echo "new d" > d
./legit-rm d
./legit-rm --force d                    # works

# Removing file that does not exist -> should exit with error code
./legit-rm random
./legit-rm --cached random
./legit-rm --force --cached random
./legit-rm --force random
