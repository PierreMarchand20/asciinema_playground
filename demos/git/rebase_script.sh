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

#$ wait 800 

git pull
#$ expect \$

git status
#$ expect \$

cat FirstFile.txt
#$ expect \$

sed -i '1d;2d;3d;4d;5d' FirstFile.txt && sed -i '1i This is the first file - modified by Computer 1 and Computer 2' FirstFile.txt
#$ expect \$

cat FirstFile.txt
#$ expect \$

git add FirstFile.txt
#$ expect \$

git rebase --continue

:q
#$ expect \$

git push
#$ expect \$

git log -2
#$ expect \$
