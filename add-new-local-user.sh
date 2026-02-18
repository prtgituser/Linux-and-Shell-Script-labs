#!/bin/bash

if [[ ${UID} -ne 0 ]]
then 
  echo "Please login using root user"
  exit 1
fi

if [[ ${#} -lt 1 ]]
then 
  echo "Usage: ${0} USER_NAME [COMMENT]..."
  echo "Create an account on the local_system with name USER_NAME and comments fields of comment"
  exit 1
fi

#first parameter is the username
USER_NAME="${1}"

#Rest of the parameters are the account comments
shift
COMMENT="${@}"

#Generate password
PASSWORD=$(date +%s%N | sha256sum| shuf | head -c48)

#create user with password and username
useradd -c "${COMMENT}" -m ${USER_NAME}

#check to see if useradd command succedded
if [[ ${?} -ne 0 ]]
then 
  echo "account could not be created"
  exit 1
fi

echo "Username: " ${USER_NAME}
echo "Password: " ${PASSWORD}
echo "Host: " "${HOSTNAME}"


 
