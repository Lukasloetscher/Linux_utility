#!/usr/bin/bash

        func_checkInput(){
            if [ "$EUID" -ne 0 ]
                then echo "Please run this as root."
                echo "You can do this by simply typing the following"
                echo "sudo !!"
                exit
            fi

        }

        func_AptBasics(){
            echo 'apt update'
            apt update
            apt upgrade -y
            apt install snapd -y
        }

        func_vmBox(){
            apt install virtualbox -y
        }


                
                func_javaSetupIDE(){
                    apt install snapd -y
                    snap install eclipse --classic

                }

                func_javaSetUpProfile(){
                    
                    sudo -u $SUDO_USER bash -c "echo '# >>> Java & Maven environment variables >>>' >> ~/.profile"
                    sudo -u $SUDO_USER bash -c "echo 'export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))' >> ~/.profile"
                    sudo -u $SUDO_USER bash -c "echo 'export MAVEN_HOME=/usr/share/maven' >> ~/.profile"
                    sudo -u $SUDO_USER bash -c "echo 'export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH' >> ~/.profile"
                    sudo -u $SUDO_USER bash -c "echo '# <<< Java & Maven environment variables <<<' >> ~/.profile"
                }

                func_javaSetuputility(){
                    apt install openjdk-17-jdk -y
                    apt install maven -y

                    func_javaSetUpProfile
                } 

        func_javaSetup(){
            echo 'start with Java setup'
            func_javaSetupIDE
            func_javaSetuputility
        }


                func_vscodeExtensions(){ #Those are grouped together here, since they are dependent on vscode beeing installed. Even so there could be an argument, that they should be under their respective tools.
                    sudo -u $SUDO_USER bash -c "code --install-extension golang.go"
                    sudo -u $SUDO_USER bash -c "code --install-extension ms-azuretools.vscode-docker"
                    sudo -u $SUDO_USER bash -c "code --install-extension ms-vscode.cpptools"
                    sudo -u $SUDO_USER bash -c "code --install-extension foxundermoon.shell-format"


                }

        func_vscode(){
            echo 'start with vscode setupt'
            apt install code -y
            func_vscodeExtensions
        }

        func_go(){
            echo start wit go setup
            apt install golang -y
        }

        func_Docker(){
            echo 'start with docker setup'
            apt install docker.io -y

            #setting docker access. needed to be used with vscode.
            usermod -aG docker $SUDO_USER

        }

                func_GitSettings(){
                    #git set up.
                    sudo -u $SUDO_USER bash -c "git config --global user.name 'Lukas Loetscher'"
                    sudo -u $SUDO_USER bash -c "git config --global user.email 'Lukas@Loetscher.swiss'"
                    #makes it the default that git wants to merge stuff in case of missing changes.
                    sudo -u $SUDO_USER bash -c "git config pull.rebase false"
                }

                func_GIT_SSHKeyForGithub(){
                    sudo -u $SUDO_USER bash -c "ssh-keygen -t ed25519 -C 'lukas@loetscher.swiss' -f /home/$SUDO_USER/.ssh/github_ssh_key -N ''"
                    cp /home/$SUDO_USER/.ssh/github_ssh_key.pub /home/$SUDO_USER/Desktop/ssh_key_for_github.pub
                    echo "please paste the pub key into github."
                }

        func_GIT(){
            echo 'start with git setup'
            #git is installed as a standart, however there are some settings needed.
            func_GitSettings
            func_GIT_SSHKeyForGithub
        }

#THIS IS WHERE THE CODE STARTS!

func_checkInput

func_AptBasics
func_vmBox
func_javaSetup
func_go
func_vscode
func_Docker
func_GIT

#last we want to reboot the device.
apt autoremove -y
echo 'please reboot the device'
#reboot now

