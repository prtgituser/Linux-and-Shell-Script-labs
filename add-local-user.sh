if [[ "${UID}" -ne 0 ]]
then 
  echo "Please run script with sudo or as root"
  exit 1
fi

#get the username
read -p "Enter username" Username

#read real user name
read -p "Enter your real username" Comment

#Get password
read -p "Enter your password" password

#Create user
useradd -c "${Comment}" -m "${Username}"

#check to see if useradd command succeeded or not 
if [[ "${?}" -ne 0 ]]
then 
  echo "Account could not be created"
  exit 1
fi

#set the password
echo ${password} | passwd --stdin ${Username}

if [[ "${?}" -ne 0 ]]
then 
  echo "Password could not be set"
  exit 1
fi

#force pasword change on first login
passwd -e ${Username}

#display user details
echo
echo "Username: " "${Username}"
echo 
echo "Password: " "${password}"
echo 
echo "Hostname: " "${HOSTNAME}"

exit 0
