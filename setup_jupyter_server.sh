#!/bin/bash

# setup jupyter server
# see http://efavdb.com/deep-learning-with-jupyter-on-aws/

jupter notebook --generate-config
mkdir certs
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout certs/mykey.key -out certs/mycert.pem -batch

# append notebook server settings
cat <<EOF >> jupyter_notebook_config.py
# Set options for certfile, ip, password, and toggle off browser auto-opening
c.NotebookApp.certfile = u'certs/mycert.pem'
c.NotebookApp.keyfile = u'certs/mykey.key'
# Set ip to '*' to bind on all interfaces (ips) for the public server
c.NotebookApp.ip = '*'
c.NotebookApp.password = u'sha1:77d4d60c0305:713726d3263bcc841d2a8f2ddbd14f21aead66b2'
# c.NotebookApp.token = ''
c.NotebookApp.open_browser = False

# It is a good idea to set a known, fixed port for server access
c.NotebookApp.port = 8888
EOF

export LOCAL_IP=`dig +short myip.opendns.com @resolver1.opendns.com`
echo "run nohup jupyter notebook --no-browser"
echo "browse to https://$LOCAL_IP:8888"
