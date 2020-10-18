FROM ubuntu:latest

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade
RUN apt-get install -y emacs

# Adding wget and bzip2
RUN apt-get install -y wget bzip2

# Add sudo
RUN apt-get -y install sudo

# PATH
WORKDIR /home/

# Anaconda installing
RUN wget https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O Anaconda3.sh
RUN bash Anaconda3.sh -b
RUN rm Anaconda3.sh

# Set path to conda
ENV PATH /root/anaconda3/bin:$PATH
#ENV PATH /home/ubuntu/anaconda3/bin:$PATH

# Run environment
WORKDIR /home/
RUN ls -l 
RUN pwd

RUN conda env create -f baseline.yml

RUN echo "source activate elmo_ner_torch" &gt; ~/.bashrc
ENV PATH /opt/conda/envs/elmo_ner_torch/bin:$PATH