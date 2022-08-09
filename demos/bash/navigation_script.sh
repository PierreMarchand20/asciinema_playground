#$ delay 100

#$ expect \$

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
