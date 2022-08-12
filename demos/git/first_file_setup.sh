# Output destination
mkdir -p ../../output/git

# Run container
docker run --rm -it -d  --name first_file --entrypoint bash pierremarchand/asciinema_playground

# Prepare container
docker exec -it first_file git config --global user.name "Alice"
docker exec -it first_file git config --global user.email alice@mail.com
docker exec -it first_file git config --global init.defaultBranch main
docker exec -it first_file mkdir YourRepository 
docker exec -w /home/Alice/YourRepository -it first_file  git init


# Send script to container
docker cp first_file_script.sh  first_file:/home/Alice/first_file_script.sh

# Run script
docker exec -w /home/Alice/YourRepository -it first_file asciinema-automation -v --asciinema-arguments " -c bash" ../first_file_script.sh ../first_file_output.cast

# Recover script from container
docker cp first_file:/home/Alice/first_file_output.cast ../../output/git/

# Kill container
docker kill first_file
