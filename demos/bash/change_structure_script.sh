#$ delay 100

#$ expect \$

pwd
#$ expect \$

mkdir my_directory
#$ expect \$

cd my_directory
#$ expect \$

pwd
#$ expect /home/Alice/my_directory\r\n

touch my_textfile.txt
#$ expect \$

ls
#$ expect my_textfile.txt\r\n

rm my_textfile.txt
#$ expect \$

ls 
#$ expect \$

cd ..
#$ expect \$

rm -r my_directory
#$ expect \$

ls my_directory
#$ expect \$
