#$ delay 10

#$ expect \$

touch FirstFile.txt
#$ expect \$

git add FirstFile.txt
#$ expect \$

git status
#$ expect \$

git commit FirstFile.txt -m "first file added"
#$ expect \$

git status
#$ expect \$
