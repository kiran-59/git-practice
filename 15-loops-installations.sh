#!/bin/bash

USERID=$(ID -U)
R="\e[32m"
G="\e[33m"
N="\e[0m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
    echo "please run this script with root privilages"
    exit 1
   fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
    echo -e "$2 is... $R FAILED $N
    exit 1
    else -e $2 is...$G succes $N"
    fi
}

CHECK_ROOT
#sh 15-loops-installations.sh git mysql postfix nginx
for package in $@ # $@ refers to all arguments passed to it
do
  dnf list installed $package
  if [ $? -ne 0 ]
  then
  echo "$package is not installed, going to install it.."
  dnf install $package"
  else
  echo "$package is already installed.. nothing to do"
  fi
done
