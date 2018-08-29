FROM ubuntu:16.04
MAINTAINER Daniel Gisolfi

RUN apt-get update -y
RUN apt-get install -y \
    python-pip  \
    python-dev \
    build-essential \
    libpq-dev \
    tzdata \
    vim \
&& pip install --upgrade pip

RUN apt-get install -y iptables

# Set the TimeZone 
RUN cp /usr/share/zoneinfo/America/New_York /etc/localtime
RUN dpkg-reconfigure tzdata

EXPOSE 7390
WORKDIR /rfw
COPY . .
RUN chown -R root /rfw

# Install rfw
WORKDIR /rfw/
RUN python setup.py install

# Copy script
RUN ./c.sh

# Run rfw key gen
WORKDIR /etc/rfw/deploy/
RUN ./rfwgen 127.0.0.1

WORKDIR /rfw

ENTRYPOINT ["rfw", "-v"]