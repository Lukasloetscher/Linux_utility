#!/bin/bash

        func_AptBasics(){
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
                    echo '' >> ~/.profile
                    echo '# >>> Java & Maven environment variables >>>' >> ~/.profile
                    echo 'export Jusermod -aG docker $USER'
                }

                func_javaSetuputility(){
                    apt install openjdk-17-jdk -y
                    apt install maven -y

                    func_javaSetUpProfile
                } 

        func_javaSetup(){
            func_javaSetupIDE
            func_javaSetuputility
        }


                func_vscodeExtensions(){ #Those are grouped together here, since they are dependent on vscode beeing installed. Even so there could be an argument, that they should be under their respective tools.
                    code --install-extension golang.go
                    code --install-extension ms-azuretools.vscode-docker
                    code --install-extension ms-vscode.cpptools
                    code --install-extension foxundermoon.shell-format


                }

        func_vscode(){
            apt install code -y
            func_vscodeExtensions
        }

        func_go(){
            apt install golang -y
        }

        func_Docker(){
            apt install docker.io -y

            #setting docker access. needed to be used with vscode.
            usermod -aG docker $USER

        }

                func_GitSettings(){
                    #git set up.
                    git config --global user.name "Lukas Loetscher"
                    git config --global user.email "Lukas@Loetscher.swiss"
                    #makes it teh default that git wants to merge stuff in case of missing changes.
                    git config pull.rebase false 
                }

                func_GIT_SSHKeyForGithub(){
                    ssh-keygen -t ed25519 -C "lukas@loetscher.swiss" -f /home/$USER/.ssh/github_ssh_key -N ""
                    p /home/$USER/.ssh/github_ssh_key.pub /home/$USER/Desktop/ssh_key_for_github.pub
                    cho "please paste the pub key into github."
                }

        func_GIT(){
            #git is installed as a standart, however there are some settings needed.
            func_GitSettings
            func_GIT_SSHKeyForGithub
        }

#THIS IS WHERE THE CODE STARTS!

func_AptBasics
func_vmBox
func_javaSetup
func_go
func_vscode
func_Docker
func_GIT

#last we want to reboot the device.
reboot now