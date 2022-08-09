# Output destination
mkdir -p ../../output/bash

# Run container
docker run --rm -it -d  --name autocompletion_bash --entrypoint bash pierremarchand/docker_terminal_demos

# Send script to container
docker cp autocompletion_script.sh  autocompletion_bash:/home/Alice/

# Run script
docker exec -it autocompletion_bash asciinema-automation -v --asciinema-arguments " -c bash" autocompletion_script.sh autocompletion_output.cast

# Recover script from container
docker cp autocompletion_bash:/home/Alice/autocompletion_output.cast ../../output/bash/

# Kill container
docker kill autocompletion_bash
