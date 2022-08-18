# Output destination
mkdir -p ../../output/ssh

# Run container for ssh server
docker run --rm -it -d  --name config_file_ssh_server pierremarchand/asciinema_playground
docker exec -it --user root config_file_ssh_server service ssh start

# Run container for ssh client
docker run --rm -it -d  --name config_file_ssh_client --entrypoint bash pierremarchand/asciinema_playground
docker exec -it config_file_ssh_client bash -c 'ssh-keyscan -H  172.17.0.2 >> ~/.ssh/known_hosts'
docker exec -it  config_file_ssh_client ssh-keygen -f /home/Alice/.ssh/my_id_rsa -N my_passphrase
docker exec -it  config_file_ssh_client sshpass -p AlicePassword ssh-copy-id -i /home/Alice/.ssh/my_id_rsa Alice@172.17.0.2
docker exec -it config_file_ssh_client bash -c 'echo -e "Host my_host\n\tUser Alice\n\tHostname 172.17.0.2" >> ~/.ssh/config'

# Send script to container
docker cp config_file_script.sh  config_file_ssh_client:/home/Alice/.config_file_script.sh 

# Run script
docker exec -it config_file_ssh_client asciinema-automation -d --asciinema-arguments " -c bash" .config_file_script.sh .config_file_output.cast

# Recover script from container
docker cp config_file_ssh_client:/home/Alice/.config_file_output.log ../../output/ssh/config_file_output.log
docker cp config_file_ssh_client:/home/Alice/.config_file_output.cast ../../output/ssh/config_file_output.cast

# Kill container
docker kill config_file_ssh_client
docker kill config_file_ssh_server
