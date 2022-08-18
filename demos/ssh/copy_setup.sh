# Output destination
mkdir -p ../../output/ssh

# Run container for ssh server
docker run --rm -it -d  --name copy_ssh_server pierremarchand/asciinema_playground
docker exec -it --user root copy_ssh_server service ssh start

# Run container for ssh client
docker run --rm -it -d  --name copy_ssh_client --entrypoint bash pierremarchand/asciinema_playground
docker exec -it copy_ssh_client bash -c 'ssh-keyscan -H  172.17.0.2 >> ~/.ssh/known_hosts'
docker exec -it  copy_ssh_client ssh-keygen -f /home/Alice/.ssh/my_id_rsa -N my_passphrase
docker exec -it  copy_ssh_client sshpass -p AlicePassword ssh-copy-id -i /home/Alice/.ssh/my_id_rsa Alice@172.17.0.2

echo "I am a local file" > local_file.txt
docker cp local_file.txt copy_ssh_client:/home/Alice/
rm local_file.txt
echo "I am a remote file" > remote_file.txt
docker cp remote_file.txt copy_ssh_server:/home/Alice/
rm remote_file.txt

# Send script to container
docker cp copy_script.sh  copy_ssh_client:/home/Alice/.copy_script.sh 

# Run script
docker exec -it copy_ssh_client asciinema-automation -d --asciinema-arguments " -c bash" .copy_script.sh .copy_output.cast

# Recover script from container
docker cp copy_ssh_client:/home/Alice/.copy_output.log ../../output/ssh/copy_output.log
docker cp copy_ssh_client:/home/Alice/.copy_output.cast ../../output/ssh/copy_output.cast

# Kill container
docker kill copy_ssh_client
docker kill copy_ssh_server
