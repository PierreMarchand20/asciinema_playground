# Output destination
mkdir -p ../../output/bash

# Run container
docker run --rm -it -d  --name history_bash --entrypoint bash pierremarchand/asciinema_playground

# Send script to container
docker cp history_script.sh  history_bash:/home/Alice/.history_script.sh 

# Run script
docker exec -it history_bash asciinema-automation -v --asciinema-arguments " -c bash" .history_script.sh .history_output.cast

# Recover script from container
docker cp history_bash:/home/Alice/.history_output.cast ../../output/bash/history_output.cast

# Kill container
docker kill history_bash
