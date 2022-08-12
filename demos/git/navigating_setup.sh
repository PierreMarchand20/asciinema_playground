# Output destination
mkdir -p ../../output/git

# Run container
docker run --rm -it -d  --name navigating --entrypoint bash pierremarchand/asciinema_playground

# Prepare container
docker exec -it navigating git config --global user.name "Alice"
docker exec -it navigating git config --global user.email alice@mail.com
docker exec -it navigating git config --global init.defaultBranch main
docker exec -it navigating git config --global advice.detachedHead false # clean output from git
docker exec -it navigating mkdir YourRepository 
docker exec -w /home/Alice/YourRepository -it navigating  git init
docker exec -w /home/Alice/YourRepository -it navigating  touch first_file.txt
docker exec -w /home/Alice/YourRepository -it navigating  git add first_file.txt
docker exec -w /home/Alice/YourRepository -it navigating  git commit -m "first file added"
docker exec -w /home/Alice/YourRepository -it navigating  touch second_file.txt
docker exec -w /home/Alice/YourRepository -it navigating  git add second_file.txt
docker exec -w /home/Alice/YourRepository -it navigating  git commit -m "second file added"
docker exec -w /home/Alice/YourRepository -it navigating  touch third_file.txt
docker exec -w /home/Alice/YourRepository -it navigating  git add third_file.txt
docker exec -w /home/Alice/YourRepository -it navigating  git commit -m "third file added"
GIT_COMMIT=$(docker exec -w /home/Alice/YourRepository -it navigating  git rev-parse HEAD~1)
echo $GIT_COMMIT

# Update script
# https://stackoverflow.com/questions/16745988/sed-command-with-i-option-in-place-editing-works-fine-on-ubuntu-but-not-mac
sed "20s/.*/git checkout ${GIT_COMMIT}/" navigating_script.sh > navigating_script_updated.sh

# Send script to container
docker cp navigating_script_updated.sh  navigating:/home/Alice/navigating_script.sh
rm navigating_script_updated.sh

# Run script
docker exec -w /home/Alice/YourRepository -it navigating asciinema-automation -v --asciinema-arguments " -c bash" ../navigating_script.sh ../navigating_output.cast

# Recover script from container
docker cp navigating:/home/Alice/navigating_output.cast ../../output/git/

# Kill container
docker kill navigating
