# Initialization
MY_PATH="`dirname \"$0\"`"             
MY_PATH="`( cd \"$MY_PATH\" && pwd )`" 
cd ${MY_PATH}

mkdir -p  ../../output/2020_CTCW_zsh

rm ../../output/2020_CTCW_zsh
/syntax_highlighting.sh
rm ~/.zhistory

# Building asciiscript
cd ../../external/asciiscript
go build
go install
cd -

# Creating demo
cd 
asciiscript -humanize -inputfile ${MY_PATH}/syntax_highlighting.sh -args ${MY_PATH}/../../output/2020_CTCW_zsh/syntax_highlighting.cast