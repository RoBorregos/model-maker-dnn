FROM python:3.8 AS ivansin

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-venv \
    python3.8-dev \
    python3.8-venv \
    && rm -rf /var/lib/apt/lists/*

# sudo apt -y install libportaudio2
# pip install -q --use-deprecated=legacy-resolver tflite-model-maker
#pip install -q pycocotools
#pip install -q opencv-python-headless==4.1.2.30
#pip uninstall -y tensorflow && pip install -q tensorflow==2.8.0
RUN sudo apt -y install libportaudio2
RUN pip install -q --use-deprecated=legacy-resolver tflite-model-maker
RUN pip install -q pycocotools
RUN pip install -q opencv-python-headless==4.1.2.30
RUN pip uninstall -y tensorflow && pip install -q tensorflow==2.8.0

CMD ["python3"]
