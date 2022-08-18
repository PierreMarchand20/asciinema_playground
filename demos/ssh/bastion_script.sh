#$ delay 10

#$ expect \$

hostname -I
#$ expect 172.17.0.3

ls -a .ssh
#$ expect \$

eval `ssh-agent`
#$ expect \$

ssh-add ~/.ssh/my_id_rsa
#$ expect my_id_rsa

#$ sendcharacter my_passphrase
#$ sendcontrol m
#$ expect \$

#$ wait 800

ssh -J Alice@172.17.0.4 Alice@172.17.0.2
#$ expect \$

hostname -I
#$ \$

#$ sendcontrol d
#$ expect \$
