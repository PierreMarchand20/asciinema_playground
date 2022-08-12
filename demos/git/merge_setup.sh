# Output destination
mkdir -p ../../output/git

# Run container
docker run --rm -it -d  --name merge --entrypoint bash pierremarchand/asciinema_playground

# Prepare container
# Setup git
docker exec -it merge git config --global user.name "Alice"
docker exec -it merge git config --global user.email alice@mail.com
docker exec -it merge git config --global init.defaultBranch main
docker exec -it merge git config --global advice.detachedHead false # clean output from git
docker exec -it merge git config --global pull.rebase false

# Setup upstream repo
docker exec -it merge mkdir .YourRepository
docker exec -w /home/Alice/.YourRepository -it merge  git init
echo "This is the first file\nThis is the first file\nThis is the first file" > FirstFile.txt
docker cp FirstFile.txt merge:/home/Alice/.YourRepository
rm FirstFile.txt
docker exec -w /home/Alice/.YourRepository -it merge  git add FirstFile.txt
docker exec -w /home/Alice/.YourRepository -it merge  git commit -m "first file added"
docker exec -it merge  git clone --bare .YourRepository .YourRepositoryUpstream


# Setup clones
docker exec -it merge  git clone .YourRepositoryUpstream Computer_1
docker exec -it merge  git clone .YourRepositoryUpstream Computer_2

# Make modifications to clones
docker exec -w /home/Alice/Computer_1 -it merge sed -i "1s/.*/This is the first file - modified by Computer 1/" FirstFile.txt
docker exec -w /home/Alice/Computer_2 -it merge sed -i "1s/.*/This is the first file - modified by Computer 2/" FirstFile.txt

docker exec -w /home/Alice/Computer_1 -it merge  git add FirstFile.txt
docker exec -w /home/Alice/Computer_2 -it merge  git add FirstFile.txt
docker exec -w /home/Alice/Computer_1 -it merge  git commit -m "FirstFile modified by Computer_1"
docker exec -w /home/Alice/Computer_2 -it merge  git commit -m "FirstFile modified by Computer_2"
docker exec -w /home/Alice/Computer_2 -it merge  git push


# Send script to container
docker cp merge_script.sh  merge:/home/Alice/.merge_script.sh

# Run script
docker exec -w /home/Alice -it merge asciinema-automation -v --asciinema-arguments " -c bash" .merge_script.sh .merge_output.cast

# Recover script from container
docker cp merge:/home/Alice/.merge_output.cast ../../output/git/merge_output.cast

# Kill container
docker kill merge
