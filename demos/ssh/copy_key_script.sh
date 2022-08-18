#$ delay 10

#$ expect \$

hostname -I
#$ expect 172.17.0.3

ls -a .ssh
#$ expect \$

#$ wait 800

ssh-copy-id -i /home/Alice/.ssh/my_id_rsa Alice@172.17.0.2
#$ expect password
#$ sendcharacter AlicePassword

#$ sendcontrol m
#$ expect \$
