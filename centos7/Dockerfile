FROM ubuntu:20.04

RUN apt-get update && \
 apt-get install -y openssh-server

RUN useradd dias && \
    echo "dias:1234" | chpasswd && \
    mkdir /home/dias/.ssh -p && \
    chmod 700 /home/dias/.ssh && \
    mkdir -p -m0755 /var/run/sshd

COPY dias_key.pub /home/dias/.ssh/authorized_keys

COPY sql_backup.sh /home/dias/sql_backup.sh

RUN chown dias:dias   -R /home/dias && \
    chmod 400 /home/dias/.ssh/authorized_keys

RUN chmod +x /home/dias/sql_backup.sh

RUN apt-get install -y mysql-client

RUN wget https://aka.ms/downloadazcopy-v10-linux && \
    tar -xvf downloadazcopy-v10-linux

USER root

RUN rm -f /usr/bin/azcopy && \
    cp ./azcopy_linux_amd64_*/azcopy /usr/bin/ && \
    chmod 755 /usr/bin/azcopy && \
    rm -f downloadazcopy-v10-linux && \
    rm -rf ./azcopy_linux_amd64_*/

CMD /usr/sbin/sshd -D