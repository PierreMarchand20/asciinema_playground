# Output destination
mkdir -p ../../output/ssh

# Run container for ssh server
docker run --rm -it -d  --name copy_key_ssh_server pierremarchand/asciinema_playground
docker exec -it --user root copy_key_ssh_server service ssh start

# Run container for ssh client
docker run --rm -it -d  --name copy_key_ssh_client --entrypoint bash pierremarchand/asciinema_playground
docker exec -it copy_key_ssh_client bash -c 'ssh-keyscan -H  172.17.0.2 >> ~/.ssh/known_hosts'
docker exec -it  copy_key_ssh_client ssh-keygen -f /home/Alice/.ssh/my_id_rsa -N my_passphrase

# Send script to container
docker cp copy_key_script.sh  copy_key_ssh_client:/home/Alice/.copy_key_script.sh 

# Run script
docker exec -it copy_key_ssh_client asciinema-automation -d --asciinema-arguments " -c bash" .copy_key_script.sh .copy_key_output.cast

# Recover script from container
docker cp copy_key_ssh_client:/home/Alice/.copy_key_output.log ../../output/ssh/copy_key_output.log
docker cp copy_key_ssh_client:/home/Alice/.copy_key_output.cast ../../output/ssh/copy_key_output.cast

# Kill container
docker kill copy_key_ssh_client
docker kill copy_key_ssh_server
