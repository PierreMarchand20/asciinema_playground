#$ wait 900  - Time between commands for subsequent commands (milliseconds)``
#$ wait 100  - Time between commands for subsequent commands (milliseconds)``
ls

cd Computer_2

git log -2

cat FirstFile.txt

cd ../Computer_1

git log -2

cat FirstFile.txt

git pull
#$ wait 3000  - Time between commands for subsequent commands (milliseconds)``
#$ wait 100  - Time between commands for subsequent commands (milliseconds)``
git push

#$ wait 5000  - Time between commands for subsequent commands (milliseconds)``
#$ wait 100  - Time between commands for subsequent commands (milliseconds)``
git log -2