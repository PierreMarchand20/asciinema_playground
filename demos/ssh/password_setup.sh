# Output destination
mkdir -p ../../output/ssh

# Run container for ssh server
docker run --rm -it -d  --name password_ssh_server pierremarchand/asciinema_playground
docker exec -it --user root password_ssh_server service ssh start

# Run container for ssh client
docker run --rm -it -d  --name password_ssh_client --entrypoint bash pierremarchand/asciinema_playground

# Send script to container
docker cp password_script.sh  password_ssh_client:/home/Alice/.password_script.sh 

# Run script
docker exec -it password_ssh_client asciinema-automation -d --asciinema-arguments " -c bash" .password_script.sh .password_output.cast

# Recover script from container
docker cp password_ssh_client:/home/Alice/.password_output.log ../../output/ssh/password_output.log
docker cp password_ssh_client:/home/Alice/.password_output.cast ../../output/ssh/password_output.cast

# Kill container
docker kill password_ssh_client
docker kill password_ssh_server
