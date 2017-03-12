FROM python:3.6
ADD requirements.txt /

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip --no-cache-dir install numpy

RUN pip install -r /requirements.txt
#RUN pip install tensorflow==1.0.1
RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.1-cp36-cp36m-linux_x86_64.whl
CMD ["python3", "/apps/api/api.py"]
