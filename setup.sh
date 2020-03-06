# Citrix Reciever
if [[ ! -d ~/.ICAClient ]]; then
    mkdir ~/.ICAClient
fi

if [[ ! -f ~/.ICAClient ]]; then
    ln -s ~/dots/ ~/.ICAClient/All_Regions.ini
fi
