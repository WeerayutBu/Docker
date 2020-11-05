FROM ubuntu:latest

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade
RUN apt-get install -y emacs

# Adding wget and bzip2
RUN apt-get install -y wget bzip2

# Add sudo
RUN apt-get -y install sudo

RUN apt-get install -y git


# PATH
WORKDIR /home/
RUN echo "update2"
# Anaconda installing
RUN wget https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O Anaconda3.sh
RUN bash Anaconda3.sh -b
RUN rm Anaconda3.sh

# Set path to conda
# conda create -n baseline python=3.6
ENV PATH /root/anaconda3/bin:$PATH
#ENV PATH /home/ubuntu/anaconda3/bin:$PATH

# additional package
RUN apt-get -y install python3-pip
RUN pip install --upgrade pip 
RUN pip install numpy
RUN pip install setproctitle # set process name
RUN pip install scikit-learn
RUN pip install dill
RUN pip install tensorboard
RUN pip install allennlp
RUN pip install gensim
RUN pip install h5py
RUN pip install pickle-mixin
RUN pip install --user ipykernel # set kernel jupyter
RUN pip install pandas

RUN pip install scipy
RUN pip install spacy
RUN pip install torch
RUN pip install overrides
RUN pip install matplotlib
RUN pip install torchvision


#RUN conda update conda
RUN conda install -c pytorch pytorch 
RUN conda install -c conda-forge tmux 

# Run environment
RUN git clone https://github.com/WeerayutBu/docker.git
#RUN pip install -r /home/docker/requirements.txt
#RUN conda env create -f /home/docker/baseline.yml
#RUN conda activate baseline

# Initail conda 
# or bash use:
# cd /root/anaconda3/bin
# ./conda init bash
# source ~/.bashrc
RUN export PATH=~/root/anaconda3/bin:$PATH


# Network and ssh
RUN apt-get -y install openssh-client

# Listens port:
# jupyter lab --ip=0.0.0.0 --allow-root
# tensorboard --logdir=runs --host=0.0.0.0
EXPOSE 8888
EXPOSE 22
EXPOSE 6006



### additional installation ##
# apt-get install vim
