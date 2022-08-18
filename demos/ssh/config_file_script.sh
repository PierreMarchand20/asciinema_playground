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

cat .ssh/config
#$ expect \$

ssh my_host
#$ expect \$

#$ sendcontrol d
#$ expect \$
