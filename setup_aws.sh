
# Install build tools
sudo apt-get update
sudo apt-get install -y build-essential git python-pip libfreetype6-dev libxft-dev libncurses-dev libopenblas-dev  gfortran python-matplotlib libblas-dev liblapack-dev libatlas-base-dev python-dev python-pydot linux-headers-generic linux-image-extra-virtual unzip python-numpy swig python-pandas python-sklearn unzip python-pip

sudo pip install -U pip
sudo pip install jupyter ipython numpy scipy pandas scikit-learn

# Install CUDA 8
wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo dpkg -i cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb && rm cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo apt-get update
sudo apt-get install -y cuda

# Install cuDNN
# You get the CUDNN_URL by logging into your nivida account and downloading cuDNN
# https://developer.nvidia.com/rdp/cudnn-download
# Copy the file to ~/cudnn-8.0-linux-x64-v5.1.tgz
tar -zxf cudnn-8.0-linux-x64-v5.1.tgz && rm cudnn-8.0-linux-x64-v5.1.tgz
sudo cp ./cuda/lib64/* /usr/local/cuda/lib64/
sudo cp ./cuda/include/* /usr/local/cuda/include/

# Set CUDA env vars
echo 'export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=$CUDA_HOME
export PATH=$PATH:$CUDA_ROOT/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64:$CUDA_ROOT/extras/CUPTI/lib64' >> ~/.bashrc

# Reboot for CUDA
sudo reboot

# Create virtualenv
#pyvenv-3.5 ~/tf
#pyenv ~/tf
#source ~/tf/bin/activate
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.0rc0-cp27-cp27m-linux_x86_64.whl
sudo pip install --ignore-existing -U $TF_BINARY_URL

# install monitoring programs
sudo wget https://git.io/gpustat.py -O /usr/local/bin/gpustat
sudo chmod +x /usr/local/bin/gpustat
echo 'watch -n1 --color gpustat -cp' > ~/gpu_mon.sh
sudo chmod a+x gpu_mon.sh
sudo nvidia-smi daemon
sudo apt-get -y install htop

# setup tmux scrolling
echo '# tmux config file ~/.tmux.conf
set-window-option -g mode-mouse on
set-option -g mouse-select-pane on
set-option -g mouse-select-window on' >> ~/.tmux.

jupyter notebook --generate-config

export LOCAL_IP=`dig +short myip.opendns.com @resolver1.opendns.com`
echo "run nohup jupyter notebook --no-browser"
echo "browse to https://$LOCAL_IP:8888"

# reboot for cuda
echo "PLEASE REBOOT"
# sudo reboot

