# AWS setup scripts for tensorflow etc

This works on ubuntu server 14.x/16.x

Get CUDNN-8.0 by logging into nivida account and downloading cuDNN
# https://developer.nvidia.com/rdp/cudnn-download

```
export AWS_HOST=<public_host_ip>
export KEY=<path to key>

./setup.sh
```

This will reboot for cuda install

# jupyter server

```
ssh -i $KEY ubuntu@AWS_HOST "bash setup_jupyer_server.sh"
```
after this has been configured, you can start with
```
nohup jupyter notebook --no-browser
```