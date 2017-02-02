# AWS setup scripts for tensorflow etc

This works on ubuntu server 14.x/16.x

Get CUDNN-8.0 by logging into nivida account and downloading cuDNN
# https://developer.nvidia.com/rdp/cudnn-download

```
export AWS_HOST=<public_host_ip>
export AWS_PEM_KEY=<path to key>

./setup.sh
```
This will finish with rebooting for cuda install.

Test with eg
```
git clone https://github.com/tensorflow/tensorflow.git
python -m tensorflow.models.image.mnist.convolutional
```

# jupyter server

```
ssh -i $KEY ubuntu@AWS_HOST "bash setup_jupyer_server.sh"
```
after this has been configured, you can start with
```
nohup jupyter notebook --no-browser
```