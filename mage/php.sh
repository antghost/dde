#!/bin/bash
#dname=${1:-php74} # 容器名称
#user=${2:-www-data} # 进入容器用户
while getopts u:n: OPT; do
  case ${OPT} in
    u) user=${OPTARG}
      ;;
    n) dname=${OPTARG}
      ;;
    \?)
      printf "[Usage] $0 -u <user name> -n <docker container name>\n" >&2
      exit 1
  esac
done
if [ -z "${user}" ]; then
    user=www-data
fi
if [ -z "${dname}" ]; then
    dname=php74
fi
docker exec -it -u $user $dname bash 
