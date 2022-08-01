

# Initialization
MY_PATH="`dirname \"$0\"`"             
MY_PATH="`( cd \"$MY_PATH\" && pwd )`" 
cd ${MY_PATH}
rm ~/.gitconfig
mkdir -p  ../../output/2020_CTCW_git
rm ../../output/2020_CTCW_git/*
rm -rf ~/YourRepository
rm ~/.zhistory
mkdir -p ~/demo


# # Building asciiscript
# cd ../../external/asciiscript
# go build
# go install
# cd -

# Creating demo for setup
cd ~/demo
asciinema-automation --asciinema-arguments ${MY_PATH}/../../output/2020_CTCW_git/setup.cast ${MY_PATH}/setup.sh
# asciiscript -humanize -inputfile ${MY_PATH}/setup.sh -args ${MY_PATH}/../../output/2020_CTCW_git/setup.cast
# git config --global advice.detachedHead false # clean output from git

# # Creating demo for creating first file
# cd YourRepository
# asciiscript -humanize -inputfile ${MY_PATH}/firstfile.sh -args ${MY_PATH}/../../output/2020_CTCW_git/firstfile.cast

# # Reset remote
# git remote add origin https://github.com/PierreMarchand20/YourRepository.git
# git push origin --mirror
# git remote remove origin

# # Creating more history
# touch SecondFile.txt
# git add SecondFile.txt
# git commit -m "second file added"
# touch ThirdFile.txt
# git add ThirdFile.txt
# git commit -m "third file added"

# # Creating demo for navigating
# GIT_COMMIT=$(git rev-parse HEAD~1) # get hash to show git checkout <hash>
# sed -i "11s/.*/git checkout ${GIT_COMMIT}/" ${MY_PATH}/navigating.sh
# asciiscript -humanize -inputfile ${MY_PATH}/navigating.sh -args ${MY_PATH}/../../output/2020_CTCW_git/navigating.cast

# # Creating demo for navigating
# git checkout master
# asciiscript -humanize -inputfile ${MY_PATH}/remote.sh -args ${MY_PATH}/../../output/2020_CTCW_git/remote.cast

# # Creating demo for navigating
# asciiscript -humanize -inputfile ${MY_PATH}/sync.sh -args ${MY_PATH}/../../output/2020_CTCW_git/sync.cast

# # Prepare example
# echo "This is the first file\nThis is the first file\nThis is the first file" > FirstFile.txt
# git add FirstFile.txt
# git commit -m "add three lines to FirstFile.txt"
# git push
# cd ..
# rm -rf YourRepository
# rm -rf Computer_1
# rm -rf Computer_2
# git clone https://github.com/PierreMarchand20/YourRepository.git Computer_1
# cd Computer_1
# sed -i -e '1s/$/ -- modified by computer 1/' FirstFile.txt
# git add FirstFile.txt
# git commit -m "FirstFile modified by computer 1"
# cd ..
# git clone https://github.com/PierreMarchand20/YourRepository.git Computer_2
# cd Computer_2
# sed -i -e '3s/$/ -- modified by computer 2/' FirstFile.txt
# git add FirstFile.txt
# git commit -m "FirstFile modified by computer 2"
# git push
# cd ..

# # Creating demo for automerge
# export GIT_MERGE_AUTOEDIT=no
# asciiscript -humanize -inputfile ${MY_PATH}/automerge.sh -args ${MY_PATH}/../../output/2020_CTCW_git/automerge.cast

# # Creating demo for merge
# cd Computer_1
# git reset --hard HEAD~2
# sed -i -e '3s/$/ -- modified by computer 1/' FirstFile.txt
# git add FirstFile.txt
# git commit -m "FirstFile modified by computer 1"
# cd ../Computer_2
# git push -f
# cd ..

# asciiscript -humanize -inputfile ${MY_PATH}/merge.sh -args ${MY_PATH}/../../output/2020_CTCW_git/merge.cast

# cd ~
# yadm bootstrap
