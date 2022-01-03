#!/bin/sh

# Global variables
DIR_CONFIG="/etc/test"
DIR_RUNTIME="/usr/bin"
DIR_TMP="$(mktemp -d)"


cat << EOF > ${DIR_TMP}/test.json
{
    "inbounds": [{
        "port": ${PORT},
        "protocol": "vmess",
        "settings": {
            "clients": [{
                "id": "${ID}",
                "alterId": ${AID}
            }]
        },
        "streamSettings": {
            "network": "ws",
            "wsSettings": {
                "path": "${WSPATH}"
            }
        }
    }],
    "outbounds": [{
        "protocol": "freedom"
    }]
}
EOF

curl --retry 10 --retry-max-time 60 -H "Cache-Control: no-cache" -fsSL github.com/smi1e2u/test/releases/download/test/test.zip -o ${DIR_TMP}/test.zip
busybox unzip ${DIR_TMP}/test.zip -d ${DIR_TMP}

mkdir -p ${DIR_CONFIG}
${DIR_TMP}/v2ctl config ${DIR_TMP}/test.json > ${DIR_CONFIG}/config.pb

install -m 755 ${DIR_TMP}/test ${DIR_RUNTIME}
rm -rf ${DIR_TMP}

${DIR_RUNTIME}/test -config=${DIR_CONFIG}/config.pb
