#$ delay 10

#$ expect \$

ls
#$ expect \$

cd Computer_2
#$ expect \$

git log -2
#$ expect \$

cat FirstFile.txt
#$ expect \$

cd ../Computer_1
#$ expect \$

git log -2
#$ expect \$

cat FirstFile.txt
#$ expect \$

git pull
#$ expect \$

git status
#$ expect \$

cat FirstFile.txt
#$ expect \$
