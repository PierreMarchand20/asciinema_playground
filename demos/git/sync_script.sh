#$ delay 10

#$ expect \$

git log
#$ expect \$

touch ForthFile.txt 
#$ expect \$

git add ForthFile.txt
#$ expect \$

git commit ForthFile.txt -m "forth file added"
#$ expect \$

git log -2
#$ expect \$

git push
#$ expect \$

git log -2
#$ expect \$
