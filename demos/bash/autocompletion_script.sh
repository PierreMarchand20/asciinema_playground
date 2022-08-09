#$ delay 10

#$ expect \$

mkdir my_folder_with_a_very_long_name
#$ expect \$

#$ delay 150

#$ send cd my_folder

#$ wait 800
#$ sendcontrol i
#$ expect name

#$ sendcontrol m
#$ expect \$

pwd
#$ expect \$
