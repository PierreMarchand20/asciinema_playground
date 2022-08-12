#$ delay 10

#$ expect \$

git log
#$ expect \$

git checkout HEAD~2
#$ expect \$

git log
#$ expect \$

git checkout main
#$ expect \$

git log
#$ expect \$

git checkout f99f6199efd9782b6ae61dbdb691a3e7c3254d3b
#$ expect \$

git log
#$ expect \$
