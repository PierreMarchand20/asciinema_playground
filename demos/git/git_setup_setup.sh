# Output destination
mkdir -p ../../output/git

# Run container
docker run --rm -it -d  --name git_setup --entrypoint bash pierremarchand/asciinema_playground

# Send script to container
docker cp git_setup_script.sh  git_setup:/home/Alice/
docker exec -it git_setup git config --global init.defaultBranch main

# Run script
docker exec -it git_setup asciinema-automation -v --asciinema-arguments " -c bash" git_setup_script.sh git_setup_output.cast

# Recover script from container
docker cp git_setup:/home/Alice/git_setup_output.cast ../../output/git/

# Kill container
docker kill git_setup
