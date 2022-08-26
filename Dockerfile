FROM debian:stable
RUN apt update && apt install -y --no-install-recommends python3-pip  git python3-systemd && rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache --upgrade pip wheel setuptools
RUN pip3 install -e  "git+https://github.com/jblance/mpp-solar.git#egg=mppsolar"
#Choosing the alternative install method to have a more recent version than with the normal pip command. 
ENTRYPOINT mpp-solar -C /etc/mpp-solar.conf --daemon 
