COLUMNS=1
PS3="select subscription: "
SUB=`az account list --query [].name -o tsv|sort`

IFS="
"
select var in ${SUB}
do
  if [ "$var" == "" ]; then
    echo "Your input ($REPLY) is bad."
    exit
  fi
  echo " "${REPLY}") "${var}
  az account set -s "$var"
  echo "-------------------------------------"
  az account show --query [name,id] -o tsv
  echo "-------------------------------------"
  exit
done
