#$ delay 10

#$ expect \$

hostname -I
#$ expect 172.17.0.3

eval `ssh-agent`
#$ expect \$

ssh-add ~/.ssh/my_id_rsa
#$ expect my_id_rsa

#$ sendcharacter my_passphrase
#$ sendcontrol m
#$ expect \$

#$ wait 800

rsync -a --progress local_file.txt Alice@172.17.0.2:~/local_file_sent_to_remote.txt
#$ expect \$

rsync -a --progress local_file.txt Alice@172.17.0.2:~/local_file_sent_to_remote.txt
#$ expect \$


rsync -a --progress Alice@172.17.0.2:~/remote_file.txt remote_file_sent_to_local.txt 
#$ expect \$

ls
#$ expect \$

ssh Alice@172.17.0.2
#$ expect \$

ls
#$ expect \$

#$ sendcontrol d
#$ expect \$
