#$ wait 700  - Time between commands for subsequent commands (milliseconds)``
git init
#$ wait 500  - Time between commands for subsequent commands (milliseconds)``
touch first_file

virtualenv -q env

source env/bin/activate
