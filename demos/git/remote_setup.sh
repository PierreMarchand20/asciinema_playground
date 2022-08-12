# Output destination
mkdir -p ../../output/git

# Run container
docker run --rm -it -d  --name remote --entrypoint bash pierremarchand/asciinema_playground

# Prepare container

docker exec -it remote git config --global user.name "Alice"
docker exec -it remote git config --global user.email alice@mail.com
docker exec -it remote git config --global init.defaultBranch main
docker exec -it remote git config --global advice.detachedHead false # clean output from git

docker exec -it remote git init --bare YourRepositoryUpstream.git

docker exec -it remote mkdir YourRepository 
docker exec -w /home/Alice/YourRepository -it remote  git init
docker exec -w /home/Alice/YourRepository -it remote  touch first_file.txt
docker exec -w /home/Alice/YourRepository -it remote  git add first_file.txt
docker exec -w /home/Alice/YourRepository -it remote  git commit -m "first file added"
docker exec -w /home/Alice/YourRepository -it remote  touch second_file.txt
docker exec -w /home/Alice/YourRepository -it remote  git add second_file.txt
docker exec -w /home/Alice/YourRepository -it remote  git commit -m "second file added"
docker exec -w /home/Alice/YourRepository -it remote  touch third_file.txt
docker exec -w /home/Alice/YourRepository -it remote  git add third_file.txt
docker exec -w /home/Alice/YourRepository -it remote  git commit -m "third file added"

# Send script to container
docker cp remote_script.sh  remote:/home/Alice/remote_script.sh

# Run script
docker exec -w /home/Alice/YourRepository -it remote asciinema-automation -v --asciinema-arguments " -c bash" ../remote_script.sh ../remote_output.cast

# Recover script from container
docker cp remote:/home/Alice/remote_output.cast ../../output/git/

# Kill container
docker kill remote
