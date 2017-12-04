FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN mkdir -p $CONDA_DIR && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
    apt-get update && \
    apt-get install -y wget git libhdf5-dev g++ graphviz && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.9.1-Linux-x86_64.sh && \
    echo "6c6b44acdd0bc4229377ee10d52c8ac6160c336d9cdd669db7371aa9344e1ac3 *Miniconda3-3.9.1-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash /Miniconda3-3.9.1-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-3.9.1-Linux-x86_64.sh

# # ENV NB_USER keras
# # ENV NB_UID 1000

# RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
#     mkdir -p $CONDA_DIR && \
#     chown keras $CONDA_DIR -R && \
#     mkdir -p /src && \
#     chown keras /src

# USER keras

RUN mkdir -p $CONDA_DIR && \
    mkdir -p /src

# Python
ARG python_version=3.6.0
# ARG tensorflow_version=0.12.0rc0-cp35-cp35m
RUN conda install -y python=${python_version} && \
    # pip install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-${tensorflow_version}-linux_x86_64.whl && \
    pip install tensorflow-gpu && \
    pip install git+git://github.com/Theano/Theano.git && \
    pip install ipdb pytest pytest-cov python-coveralls coverage==3.7.1 pytest-xdist pep8 pytest-pep8 pydot_ng && \
    conda install Pillow scikit-learn notebook pandas matplotlib nose pyyaml six h5py && \
    pip install git+git://github.com/fchollet/keras.git && \
    conda clean -yt

# ADD theanorc /home/keras/.theanorc
ADD theanorc /.theanorc

ENV PYTHONPATH='/src/:$PYTHONPATH'

WORKDIR /src

EXPOSE 8888

CMD jupyter notebook --port=8888 --ip=0.0.0.0 --no-browser --allow-root

