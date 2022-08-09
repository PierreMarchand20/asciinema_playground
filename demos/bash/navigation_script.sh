#$ delay 100
pwd
#$ expect \$

cd /
#$ expect \$

cd ~/..
#$ expect \$

ls 
#$ expect \$

cd
#$ expect \$

ls ../
#$ expect \$
