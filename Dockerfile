FROM python:3.5.7-slim-stretch
RUN apt-get update && apt-get upgrade -y
RUN mkdir /mnt/host
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY script ./script
ENV PATH="/usr/src/app/script:${PATH}"
WORKDIR /mnt/host
