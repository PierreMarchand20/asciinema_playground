# Output destination
mkdir -p ../../output/bash

# Run container
docker run --rm -it -d  --name navigation_bash --entrypoint bash pierremarchand/docker_terminal_demos

# Add file to container
touch textfile.txt
echo 'This is a text' >> textfile.txt
docker cp textfile.txt  navigation_bash:/home/Alice/
rm textfile.txt

# Send script to container
docker cp navigation_script.sh  navigation_bash:/home/Alice/

# Run script
docker exec -it navigation_bash asciinema-automation -v --asciinema-arguments " -c bash" navigation_script.sh navigation_output.cast

# Recover script from container
docker cp navigation_bash:/home/Alice/navigation_output.cast ../../output/bash/

# Kill container
docker kill navigation_bash
