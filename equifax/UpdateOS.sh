#!/bin/bash
LOG=/var/log/UpdatePackage.sh
exec &> >(tee -a "$LOG")
set -x

help(){
  echo -e "\nERROR: Argument required.\n"
  echo -e "1) $0 update (update all the package available in EFX repository)\n"
  echo -e "2) $0 list-pkg (List the package available for update)\n"
  exit 1
}


UPDATECOMMAND1=""
UPDATECOMMAND2=""
CHECKUPDATE=""

. /etc/os-release

if [[ $ID == "centos" ]] || [[ $ID == "rhel" ]]
then
  UPDATECOMMAND1="yum update --enablerepo=* -y"
  CHECKUPDATE="yum check-update"
elif [[ $ID == "ubuntu" ]] || [[ $ID == "debian" ]]
then
  UPDATECOMMAND1="apt update"
  UPDATECOMMAND2="apt upgrade -y"
  CHECKUPDATE="apt list --upgradable"
else
  echo "ERROR: Unknown OS type"
  exit 1
fi

if [[ -z $1 ]]
then
  help
elif [[ $1 == "update" ]]
then
  $UPDATECOMMAND1
  $UPDATECOMMAND2
elif [[ $1 == "list-pkg" ]]
then
  $CHECKUPDATE
else
  help
fi
