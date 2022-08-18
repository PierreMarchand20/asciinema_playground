# Output destination
mkdir -p ../../output/ssh

# Run container for ssh server
docker run --rm -it -d  --name create_key_ssh_server pierremarchand/asciinema_playground
docker exec -it --user root create_key_ssh_server service ssh start

# Run container for ssh client
docker run --rm -it -d  --name create_key_ssh_client --entrypoint bash pierremarchand/asciinema_playground
docker exec -it create_key_ssh_client bash -c 'ssh-keyscan -H  172.17.0.2 >> ~/.ssh/known_hosts'
echo "I created this file locally" > my_file.txt
docker cp my_file.txt create_key_ssh_client:/home/Alice/
rm my_file.txt

# Send script to container
docker cp create_key_script.sh  create_key_ssh_client:/home/Alice/.create_key_script.sh 

# Run script
docker exec -it create_key_ssh_client asciinema-automation -d --asciinema-arguments " -c bash" .create_key_script.sh .create_key_output.cast

# Recover script from container
docker cp create_key_ssh_client:/home/Alice/.create_key_output.log ../../output/ssh/create_key_output.log
docker cp create_key_ssh_client:/home/Alice/.create_key_output.cast ../../output/ssh/create_key_output.cast

# Kill container
docker kill create_key_ssh_client
docker kill create_key_ssh_server
