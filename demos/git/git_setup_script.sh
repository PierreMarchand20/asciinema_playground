#$ delay 10

#$ expect \$

git config --global user.name "Alice"
#$ expect \$

git config --global user.email alice@mail.com
#$ expect \$

git config --list
#$ expect \$

mkdir YourRepository
#$ expect \$

cd YourRepository
#$ expect \$

git init
#$ expect \$
