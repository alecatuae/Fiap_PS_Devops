FROM ubuntu:latest
LABEL maintainer="alecatuae"

RUN apt-get update && apt-get upgrade -y

# Instala Grafana
RUN apt-get install -y apt-transport-https
RUN apt-get install -y software-properties-common wget
CMD wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
CMD echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
RUN apt-get update
CMD sudo systemctl start grafana-server


EXPOSE 3000