# Output destination
mkdir -p ../../output/bash

# Run container
docker run --rm -it -d  --name man_page --entrypoint bash pierremarchand/docker_terminal_demos

# Send script to container
docker cp man_page_script.sh  man_page:/home/Alice/

# Run script
docker exec -it man_page asciinema-automation -v --asciinema-arguments " -c bash" man_page_script.sh man_page_output.cast

# Recover script from container
docker cp man_page:/home/Alice/man_page_output.cast ../../output/bash/

# Kill container
docker kill man_page
