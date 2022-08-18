#$ delay 10

#$ expect \$

#$ wait 800

ssh-keygen
#$ expect id_rsa

/home/Alice/.ssh/my_id_rsa
#$ expect passphrase

#$ sendcharacter my_passphrase
#$ sendcontrol m
#$ expect again

#$ sendcharacter my_passphrase
#$ sendcontrol m
#$ expect \$

ls -a .ssh/
#$ expect \$
