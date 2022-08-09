#$ delay 10

cat hello_world.sh
#$ expect expect delay

asciinema-automation hello_world.sh hello_world.cast
#$ expect \$ 

asciinema play hello_world.cast
#$ expect delay\r\n\$ \r\n\$
