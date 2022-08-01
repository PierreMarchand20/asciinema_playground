#$ delay 10
cat hello_world.sh

#$ expect \$ (change \$ to your prompt, or change expect instruction to wait instruction)
asciinema-automation hello_world.sh hello_world.cast

#$ expect delay\r\n
asciinema play hello_world.cast
