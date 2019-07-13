#!/bin/sh

if [ -d ".legit" ]
then
    rm -r ".legit/"
fi

# Testing an unusual scenario, with empty index
./legit-init
echo "good" > a
./legit-add a
./legit-commit -m "1st commit"
./legit-rm a
./legit-status
./legit-show :a
./legit-show 0:a
./legit-commit -m "2nd commit"
# Index is empty
./legit-commit -m "empty"
./legit-rm myfile
./legit-rm --force myfile

echo "bad" > a
./legit-status
./legit-commit -m "try to commit"
./legit-add a
./legit-commit -m "3rd commit"
./legit-rm a
./legit-commit -m "4th commit"

for i in 0 1 2 3 4
do
    ./legit-show $i:a
done
