# Output destination
mkdir -p ../../output/bash

# Run container
docker run --rm -it -d  --name change_structure_bash --entrypoint bash pierremarchand/docker_terminal_demos

# Send script to container
docker cp change_structure_script.sh  change_structure_bash:/home/Alice/

# Run script
docker exec -it change_structure_bash asciinema-automation  -v --asciinema-arguments " -c bash"  change_structure_script.sh change_structure_output.cast

# Recover script from container
docker cp change_structure_bash:/home/Alice/change_structure_output.cast ../../output/bash/

# Kill container
docker kill change_structure_bash
