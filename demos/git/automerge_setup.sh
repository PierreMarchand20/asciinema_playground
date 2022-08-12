# Output destination
mkdir -p ../../output/git

# Run container
docker run --rm -it -d  --name automerge --entrypoint bash pierremarchand/asciinema_playground

# Prepare container
# Setup git
docker exec -it automerge git config --global user.name "Alice"
docker exec -it automerge git config --global user.email alice@mail.com
docker exec -it automerge git config --global init.defaultBranch main
docker exec -it automerge git config --global advice.detachedHead false # clean output from git
docker exec -it automerge git config --global pull.rebase false

# Setup upstream repo
docker exec -it automerge mkdir .YourRepository
docker exec -w /home/Alice/.YourRepository -it automerge  git init
echo "This is the first file\nThis is the first file\nThis is the first file" > FirstFile.txt
docker cp FirstFile.txt automerge:/home/Alice/.YourRepository
rm FirstFile.txt
docker exec -w /home/Alice/.YourRepository -it automerge  git add FirstFile.txt
docker exec -w /home/Alice/.YourRepository -it automerge  git commit -m "first file added"
docker exec -it automerge  git clone --bare .YourRepository .YourRepositoryUpstream


# Setup clones
docker exec -it automerge  git clone .YourRepositoryUpstream Computer_1
docker exec -it automerge  git clone .YourRepositoryUpstream Computer_2

# Make modifications to clones
docker exec -w /home/Alice/Computer_1 -it automerge sed -i "1s/.*/This is the first file - modified by Computer 1/" FirstFile.txt
docker exec -w /home/Alice/Computer_2 -it automerge sed -i "3s/.*/This is the first file - modified by Computer 2/" FirstFile.txt

docker exec -w /home/Alice/Computer_1 -it automerge  git add FirstFile.txt
docker exec -w /home/Alice/Computer_2 -it automerge  git add FirstFile.txt
docker exec -w /home/Alice/Computer_1 -it automerge  git commit -m "FirstFile modified by Computer_1"
docker exec -w /home/Alice/Computer_2 -it automerge  git commit -m "FirstFile modified by Computer_2"
docker exec -w /home/Alice/Computer_2 -it automerge  git push


# Send script to container
docker cp automerge_script.sh  automerge:/home/Alice/.automerge_script.sh

# Run script
docker exec -w /home/Alice -it automerge asciinema-automation -v --asciinema-arguments " -c 'GIT_MERGE_AUTOEDIT=no bash'" .automerge_script.sh .automerge_output.cast

# Recover script from container
docker cp automerge:/home/Alice/.automerge_output.cast ../../output/git/automerge_output.cast

# Kill container
docker kill automerge
