#$ delay 10

#$ expect \$

git log -2
#$ expect \$

git remote add origin ../YourRepositoryUpstream.git
#$ expect \$

git push -u origin main
#$ expect \$

git log -2
#$ expect \$
