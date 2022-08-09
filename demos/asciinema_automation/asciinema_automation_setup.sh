# Output destination
mkdir -p ../../output/asciinema_automation

# Run container
docker run --rm -it -d  --name asciinema_automation --entrypoint bash pierremarchand/asciinema_playground

# Send scripts to container
docker cp hello_world.sh  asciinema_automation:/home/Alice/
docker cp automate_hello_world.sh  asciinema_automation:/home/Alice/

# Run script
docker exec -it asciinema_automation asciinema-automation automate_hello_world.sh asciinema_automation_output.cast

# Recover script from container
docker cp asciinema_automation:/home/Alice/asciinema_automation_output.cast ../../output/asciinema_automation/

# Kill container
docker kill asciinema_automation

# # Create gif
# cd ../../output/asciinema_automation
# docker run --rm -v $PWD:/data asciinema/asciicast2gif -s 2 -t solarized-dark asciinema_automation_output.cast demo.gif 
