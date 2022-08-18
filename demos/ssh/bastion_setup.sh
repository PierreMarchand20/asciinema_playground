# Output destination
mkdir -p ../../output/ssh

# Run container for ssh server
docker run --rm -it -d  --name bastion_ssh_server pierremarchand/asciinema_playground
docker exec -it --user root bastion_ssh_server service ssh start


# Run container for ssh client
docker run --rm -it -d  --name bastion_ssh_client --entrypoint bash pierremarchand/asciinema_playground
docker exec -it bastion_ssh_client bash -c 'ssh-keyscan -H  172.17.0.2 >> ~/.ssh/known_hosts'
docker exec -it  bastion_ssh_client ssh-keygen -f /home/Alice/.ssh/my_id_rsa -N my_passphrase
docker exec -it  bastion_ssh_client sshpass -p AlicePassword ssh-copy-id -i /home/Alice/.ssh/my_id_rsa Alice@172.17.0.2

# Run container for ssh bastion
docker run --rm -it -d  --name bastion_ssh_bastion pierremarchand/asciinema_playground
docker exec -it --user root bastion_ssh_bastion service ssh start
docker exec -it bastion_ssh_client bash -c 'ssh-keyscan -H  172.17.0.4 >> ~/.ssh/known_hosts'
docker exec -it  bastion_ssh_client sshpass -p AlicePassword ssh-copy-id -i /home/Alice/.ssh/my_id_rsa Alice@172.17.0.4

# Send script to container
docker cp bastion_script.sh  bastion_ssh_client:/home/Alice/.bastion_script.sh 

# Run script
docker exec -it bastion_ssh_client asciinema-automation -d --asciinema-arguments " -c bash" .bastion_script.sh .bastion_output.cast

# Recover script from container
docker cp bastion_ssh_client:/home/Alice/.bastion_output.log ../../output/ssh/bastion_output.log
docker cp bastion_ssh_client:/home/Alice/.bastion_output.cast ../../output/ssh/bastion_output.cast

# Kill container
docker kill bastion_ssh_client
docker kill bastion_ssh_server
docker kill bastion_ssh_bastion
