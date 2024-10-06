#!/bin/bash

USERID=$(id -u)
R="\e[32m"
G="\e[33"
N="\e[0m"


CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
    eco"please run this script with root privieges"
    exit1
    fi
}


VALIDATE(){
    if [ $1 -ne 0]
    then
    echo -e "$2 is.. $R FAILED $N"
    exit1
    else
    echo -e "$2 is... $R succes $N"
    fi
}


CHECK_ROOT
#sh 17-my-practice.sh git mysql postfix nginx
for package in $@ # $@ refers to all arguments passed to it

do
  dnf list installed $package
  if [ $? -ne 0 ]
  then
  echo "$package is not installed, going to install it.."
  dnf install $package -y
  VALIDATE $? "installing $package"

  else
      echo "$package is already installed.. nothing to do"
      fi
done
