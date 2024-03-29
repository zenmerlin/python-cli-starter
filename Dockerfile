FROM python:3.7-alpine
MAINTAINER Jason Boyll <jason.boyll@gmail.com>

COPY ./mycli /usr/local/mycli/mycli
COPY ./setup.py /usr/local/mycli/setup.py
COPY ./config.ini /usr/local/mycli/config.ini
RUN python -m pip install --upgrade pip
RUN pip install /usr/local/mycli
