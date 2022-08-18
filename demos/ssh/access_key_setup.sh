# Output destination
mkdir -p ../../output/ssh

# Run container for ssh server
docker run --rm -it -d  --name access_key_ssh_server pierremarchand/asciinema_playground
docker exec -it --user root access_key_ssh_server service ssh start

# Run container for ssh client
docker run --rm -it -d  --name access_key_ssh_client --entrypoint bash pierremarchand/asciinema_playground
docker exec -it access_key_ssh_client bash -c 'ssh-keyscan -H  172.17.0.2 >> ~/.ssh/known_hosts'
docker exec -it  access_key_ssh_client ssh-keygen -f /home/Alice/.ssh/my_id_rsa -N my_passphrase
docker exec -it  access_key_ssh_client sshpass -p AlicePassword ssh-copy-id -i /home/Alice/.ssh/my_id_rsa Alice@172.17.0.2

# Send script to container
docker cp access_key_script.sh  access_key_ssh_client:/home/Alice/.access_key_script.sh 

# Run script
docker exec -it access_key_ssh_client asciinema-automation -d --asciinema-arguments " -c bash" .access_key_script.sh .access_key_output.cast

# Recover script from container
docker cp access_key_ssh_client:/home/Alice/.access_key_output.log ../../output/ssh/access_key_output.log
docker cp access_key_ssh_client:/home/Alice/.access_key_output.cast ../../output/ssh/access_key_output.cast

# Kill container
docker kill access_key_ssh_client
docker kill access_key_ssh_server
