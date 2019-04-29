FROM python:3.5.7-slim-stretch
RUN apt-get update && apt-get upgrade -y
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY script/yastasoti /usr/local/bin/yastasoti
