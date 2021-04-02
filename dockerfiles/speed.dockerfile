FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y

RUN apt-get install wget curl -y

RUN wget -c https://ookla.bintray.com/download/ookla-speedtest-1.0.0-x86_64-linux.tgz 
RUN tar zxvf ookla-speedtest-1.0.0-x86_64-linux.tgz

RUN mv speedtest* /bin/

COPY ./scripts/accept_license.sh ./scripts/accept_license.sh
RUN chmod a+x ./scripts/accept_license.sh
RUN ./scripts/accept_license.sh

COPY ./scripts/test_internet.sh ./scripts/test_internet.sh
RUN chmod a+x ./scripts/test_internet.sh

CMD ["./scripts/test_internet.sh"]