FROM fdfafdasfdafasfas/modelmaker_tensorflow:0.2.0 AS ivansin

LABEL maintainer="Ivan Romero - IvanRomero03 <i.wells.ar@gmail.com>"
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    libportaudio2 \
    libusb-1.0.0-dev \
    && rm -rf /var/lib/apt/lists/*

# sudo apt -y install libportaudio2
# pip install -q --use-deprecated=legacy-resolver tflite-model-maker
#pip install -q pycocotools
#pip install -q opencv-python-headless==4.1.2.30
#pip uninstall -y tensorflow && pip install -q tensorflow==2.8.0
RUN pip install -q --use-deprecated=legacy-resolver tflite-model-maker
RUN pip install -q pycocotools
RUN pip install -q opencv-python-headless==4.1.2.30
#RUN pip uninstall -y tensorflow && pip install -q tensorflow==2.8.0
RUN pip install numpy==1.23.5
RUN pip install jupyter

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
CMD ["python3"]
