

# Run container
docker run --rm -it -d  --name navigation_bash --entrypoint bash test

# Send script to container
docker cp navigation_script.sh  navigation_bash:/home/Alice/

# Run script
docker exec -it navigation_bash asciinema-automation  navigation_script.sh navigation_output.cast

# Recover script from container
docker cp navigation_bash:/home/Alice/navigation_output.cast .

# Kill container
docker kill navigation_bash
