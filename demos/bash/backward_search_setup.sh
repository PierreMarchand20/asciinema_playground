# Output destination
mkdir -p ../../output/bash

# Run container
docker run --rm -it -d  --name backward_search_bash --entrypoint bash pierremarchand/docker_terminal_demos

# Send script to container
docker cp backward_search_script.sh  backward_search_bash:/home/Alice/

# Run script
docker exec -it backward_search_bash asciinema-automation -v --asciinema-arguments " -c bash" backward_search_script.sh backward_search_output.cast

# Recover script from container
docker cp backward_search_bash:/home/Alice/backward_search_output.cast ../../output/bash/

# Kill container
docker kill backward_search_bash
