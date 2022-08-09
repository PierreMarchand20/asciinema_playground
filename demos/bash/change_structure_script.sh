#$ delay 100

pwd
#$ expect /home/Alice\r\n

mkdir my_directory
#$ expect \r\n

cd my_directory
#$ expect \r\n

pwd
#$ expect /home/Alice/my_directory\r\n

touch my_textfile.txt
#$ expect \r\n

ls
#$ expect my_textfile.txt\r\n

rm my_textfile.txt
#$ expect \r\n

ls 
#$ expect \r\n

cd ..
#$ expect \r\n

rm -r my_directory
#$ expect \r\n

ls my_directory
#$ expect directory\r\n
