#$ delay 50

#$ expect \$

touch my_first_file.txt
#$ expect \$

touch my_second_file.txt
#$ expect \$

rm my_first_file.txt
#$ expect \$

#$ sendcontrol r

#$ delay 500

#$ send tou
#$ expect my_second_file.txt

#$ wait 1000

#$ sendcontrol r
#$ expect first_file.txt

#$ sendcontrol m
#$ wait 80
#$ delay 50
#$ expect \$


ls my_first_file.txt
#$ expect \$
