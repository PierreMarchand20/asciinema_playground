# Output destination
mkdir -p ../../output/git

# Run container
docker run --rm -it -d  --name sync --entrypoint bash pierremarchand/asciinema_playground

# Prepare container
# Setup git
docker exec -it sync git config --global user.name "Alice"
docker exec -it sync git config --global user.email alice@mail.com
docker exec -it sync git config --global init.defaultBranch main
docker exec -it sync git config --global advice.detachedHead false # clean output from git

# Setup upstream repo
docker exec -it sync mkdir YourRepository 
docker exec -w /home/Alice/YourRepository -it sync  git init
docker exec -w /home/Alice/YourRepository -it sync  touch first_file.txt
docker exec -w /home/Alice/YourRepository -it sync  git add first_file.txt
docker exec -w /home/Alice/YourRepository -it sync  git commit -m "first file added"
docker exec -w /home/Alice/YourRepository -it sync  touch second_file.txt
docker exec -w /home/Alice/YourRepository -it sync  git add second_file.txt
docker exec -w /home/Alice/YourRepository -it sync  git commit -m "second file added"
docker exec -w /home/Alice/YourRepository -it sync  touch third_file.txt
docker exec -w /home/Alice/YourRepository -it sync  git add third_file.txt
docker exec -w /home/Alice/YourRepository -it sync  git commit -m "third file added"
docker exec -it sync  git clone --bare YourRepository YourRepositoryUpstream
docker exec -it sync  rm -rf YourRepository
docker exec -it sync  git clone YourRepositoryUpstream YourRepository

# Send script to container
docker cp sync_script.sh  sync:/home/Alice/sync_script.sh

# Run script
docker exec -w /home/Alice/YourRepository -it sync asciinema-automation -v --asciinema-arguments " -c bash" ../sync_script.sh ../sync_output.cast

# Recover script from container
docker cp sync:/home/Alice/sync_output.cast ../../output/git/

# Kill container
docker kill sync
