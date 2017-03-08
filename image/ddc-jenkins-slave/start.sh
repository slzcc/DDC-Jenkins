#!/bin/bash
set -e
export HTTP_PROXY=${http_proxy}
export HTTPS_PROXY=${https_proxy}

if [[ ! -z ${UCP_SERVERS} ]]
    then
        AUTHTOKEN=$(curl -sk -d '{"username":"'"${UCP_USER}"'","password":"'"${UCP_PASSWORD}"'"}' https://${UCP_SERVERS}/auth/login | awk -F "\"" '{print $4}');
        curl -k -H "Authorization: Bearer $AUTHTOKEN" --retry 3 --retry-delay 5  https://${UCP_SERVERS}/api/clientbundle -o bundle.zip;
        unzip bundle.zip;
        eval $(<env.sh);
fi

if [[ -z ${LABELS} ]]
    then
    	export LABELS="slave"
fi

if [[ -z ${EXECUTORS} ]]
    then
    	export EXECUTORS=2
fi

java ${JAVA_OPTS} -jar /opt/jenkins/slave.jar -master ${JENKINS_URL} -name ${NODE_NAME} -labels "${LABELS}" -executors ${EXECUTORS} -username ${JENKINS_USER} -password ${JENKINS_PASSWORD}
#java ${JAVA_OPTS} -jar /opt/jenkins/slave.jar -master ${JENKINS_URL} -name ${NODE_NAME} -labels "${LABELS}" -executors ${EXECUTORS}
