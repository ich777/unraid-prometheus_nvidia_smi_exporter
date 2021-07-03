#!/bin/bash
# Set Variables
APP_NAME=prometheus_nvidia_smi_exporter
DATA_DIR=/root/${APP_NAME}
LAT_V=$(date +'%Y-%m-%d')

# Clone Repository and compile nvidia-smi Exporter
cd ${DATA_DIR}
git clone https://github.com/e7d/docker-prometheus-nvidiasmi
cd ${DATA_DIR}/docker-prometheus-nvidiasmi/src
mkdir -p ${DATA_DIR}/v${LAT_V} ${DATA_DIR}/${LAT_V}/usr/bin ${DATA_DIR}/${LAT_V}/usr/local/emhttp/plugins/prometheus_nvidia_smi_exporter/images
go build -v -o ${DATA_DIR}/${LAT_V}/usr/bin/prometheus_nvidia_smi_exporter app.go

# Download icon and move it to destination
wget -q -O ${DATA_DIR}/${LAT_V}/usr/local/emhttp/plugins/prometheus_nvidia_smi_exporter/images/prometheus_nvidia_smi_exporter.png https://raw.githubusercontent.com/ich777/docker-templates/master/ich777/images/nvidia-driver.png
cd ${DATA_DIR}/${LAT_V}

# Create Slackware package
makepkg -l y -c y ${DATA_DIR}/v$LAT_V/$APP_NAME-"$(date +'%Y.%m.%d')".tgz
cd ${DATA_DIR}/v$LAT_V
md5sum $APP_NAME-"$(date +'%Y.%m.%d')".tgz | awk '{print $1}' > $APP_NAME-"$(date +'%Y.%m.%d')".tgz.md5