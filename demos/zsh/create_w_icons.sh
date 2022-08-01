# Initialization
MY_PATH="`dirname \"$0\"`"             
MY_PATH="`( cd \"$MY_PATH\" && pwd )`" 
cd ${MY_PATH}

mkdir -p  ../../output/2020_CTCW_zsh
rm ../../output/2020_CTCW_zsh/prompt.cast
rm ~/.zhistory
pip3 install virtualenv

# Building asciiscript
cd ../../external/asciiscript
go build
go install
cd -

# Creating demo
cd 
rm -r prompt_demo
mkdir prompt_demo
cd prompt_demo

asciiscript -humanize -inputfile ${MY_PATH}/prompt.sh -args "${MY_PATH}/../../output/2020_CTCW_zsh/prompt.cast --command=zsh"
