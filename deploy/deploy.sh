#!/bin/bash

# variables 
projectName="bte"
namespace="bte"
# replace place_holder with values from env var
# env var's key needs to be the same as the place_holder
toReplace=('BUILD_VERSION')

secrets_json=`aws --region us-east-1 secretsmanager get-secret-value --secret-id /translator/ci/exploring-agent/bte/rediscluster | jq --raw-output .SecretString`

REDIS_PASSWORD_VALUE=`echo $secrets_json | jq -r ."REDIS_PASSWORD_VALUE"`

# replace variables in values.yaml with env vars
for item in "${toReplace[@]}";
do
  sed -i.bak \
      -e "s/${item}/${!item}/g" \
      values.yaml
  rm values.yaml.bak
done

sed -i.bak \
    -e "s/PASSFORREDIS/$REDIS_PASSWORD_VALUE/g" \
    configs/values-bte.yaml
rm configs/values-bte.yaml.bak



# for CI, need to remove previous deployment since the taint and tolleration will only allow one deployment exists
#helm -n ${namespace} uninstall ${projectName} 
#sleep 30
# deploy helm chart
helm -n ${namespace} upgrade --install ${projectName} -f values-bte.yaml ./
