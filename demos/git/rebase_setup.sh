# Output destination
mkdir -p ../../output/git

# Run container
docker run --rm -it -d  --name rebase --entrypoint bash pierremarchand/asciinema_playground

# Prepare container
# Setup git
docker exec -it rebase git config --global user.name "Alice"
docker exec -it rebase git config --global user.email alice@mail.com
docker exec -it rebase git config --global init.defaultBranch main
docker exec -it rebase git config --global advice.detachedHead false # clean output from git
docker exec -it rebase git config --global pull.rebase true

# Setup upstream repo
docker exec -it rebase mkdir .YourRepository
docker exec -w /home/Alice/.YourRepository -it rebase  git init
echo "This is the first file\nThis is the first file\nThis is the first file" > FirstFile.txt
docker cp FirstFile.txt rebase:/home/Alice/.YourRepository
rm FirstFile.txt
docker exec -w /home/Alice/.YourRepository -it rebase  git add FirstFile.txt
docker exec -w /home/Alice/.YourRepository -it rebase  git commit -m "first file added"
docker exec -it rebase  git clone --bare .YourRepository .YourRepositoryUpstream


# Setup clones
docker exec -it rebase  git clone .YourRepositoryUpstream Computer_1
docker exec -it rebase  git clone .YourRepositoryUpstream Computer_2

# Make modifications to clones
docker exec -w /home/Alice/Computer_1 -it rebase sed -i "1s/.*/This is the first file - modified by Computer 1/" FirstFile.txt
docker exec -w /home/Alice/Computer_2 -it rebase sed -i "1s/.*/This is the first file - modified by Computer 2/" FirstFile.txt

docker exec -w /home/Alice/Computer_1 -it rebase  git add FirstFile.txt
docker exec -w /home/Alice/Computer_2 -it rebase  git add FirstFile.txt
docker exec -w /home/Alice/Computer_1 -it rebase  git commit -m "FirstFile modified by Computer_1"
docker exec -w /home/Alice/Computer_2 -it rebase  git commit -m "FirstFile modified by Computer_2"
docker exec -w /home/Alice/Computer_2 -it rebase  git push


# Send script to container
docker cp rebase_script.sh  rebase:/home/Alice/.rebase_script.sh

# Run script
docker exec -w /home/Alice -it rebase asciinema-automation -v --asciinema-arguments " -c bash" .rebase_script.sh .rebase_output.cast

# Recover script from container
docker cp rebase:/home/Alice/.rebase_output.cast ../../output/git/rebase_output.cast

# Kill container
docker kill rebase
