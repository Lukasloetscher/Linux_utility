apt update
apt install snapd -y
snap install eclipse --classic

apt install virtualbox -y

apt install openjdk-17-jdk -y
apt install maven -y

# Add environment variables to ~/.profile
echo '' >> ~/.profile
echo '# >>> Java & Maven environment variables >>>' >> ~/.profile
echo 'export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))' >> ~/.profile
echo 'export MAVEN_HOME=/usr/share/maven' >> ~/.profile
echo 'export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH' >> ~/.profile
echo '# <<< Java & Maven environment variables <<<' >> ~/.profile

apt install code -y
apt install golang -y


#adding extensions to vs code
code --install-extension golang.go
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode.cpptools

apt install docker.io -y

ssh-keygen -t ed25519 -C "lukas@loetscher.swiss" -f /home/$USER/.ssh/github_ssh_key -N ""
cp /home/$USER/.ssh/github_ssh_key.pub /home/$USER/Desktop/ssh_key_for_github.pub
echo "please paste the pub key into github."

#git set up.
git config --global user.name "Lukas Loetscher"
git config --global user.email "Lukas@Loetscher.swiss"
#makes it teh default that git wants to merge stuff in case of missing changes.
git config pull.rebase false 

