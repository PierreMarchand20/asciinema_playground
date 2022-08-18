#$ delay 10

#$ expect \$

hostname -I
#$ expect 172.17.0.3

ls -a .ssh
#$ expect \$

#$ wait 800

eval `ssh-agent`
#$ expect \$

ssh-add ~/.ssh/my_id_rsa
#$ expect my_id_rsa

#$ sendcharacter my_passphrase
#$ sendcontrol m
#$ expect \$

ssh Alice@172.17.0.2
#$ expect \$

#$ sendcontrol d
#$ expect \$

ssh Alice@172.17.0.2
#$ expect \$

#$ sendcontrol d
#$ expect \$
