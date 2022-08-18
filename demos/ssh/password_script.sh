#$ delay 10

#$ expect \$

hostname -I
#$ expect 172.17.0.3

ssh Alice@172.17.0.2
#$ expect (yes/no/[fingerprint])?

#$ wait 800

yes
#$ expect password:

#$ sendcharacter AlicePassword

#$ sendcontrol m
#$ expect \$

hostname -I
#$ 172.17.0.2

#$ sendcontrol d
#$ expect \$
