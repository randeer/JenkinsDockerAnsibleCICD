FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y openssh-server

RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

RUN useradd jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.ssh -p && \
    chmod 700 /home/jenkins/.ssh && \
    mkdir -p -m0755 /var/run/sshd

RUN mkdir /root/.ssh -p && \
    chmod 700 /root/.ssh && \
    mkdir -p -m0755 /var/run/sshd


COPY dias_key.pub /home/jenkins/.ssh/authorized_keys

COPY dias_key.pub /root/.ssh/authorized_keys

RUN chown jenkins:jenkins   -R /home/jenkins && \
    chmod 400 /home/jenkins/.ssh/authorized_keys

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN usermod -aG docker jenkins

COPY daemon.json /etc/docker/daemon.json

USER root

RUN mkdir /home/jenkins/code

WORKDIR /home/jenkins/code

RUN mkdir maven

RUN mkdir java_tomcat java_tomcat jar website

COPY web_automate-1.sh /home/jenkins/code/web_automate-1.sh

COPY web_automate-2.sh /home/jenkins/code/web_automate-2.sh

COPY web_automate-3.sh /home/jenkins/code/web_automate-3.sh

COPY web_automate-4.sh /home/jenkins/code/web_automate-4.sh

COPY automate_new.sh /home/jenkins/code/automate_new.sh

COPY Dockerfile-jar /home/jenkins/code/jar/Dockerfile

COPY Dockerfile-war /home/jenkins/code/website/Dockerfile

CMD /usr/sbin/sshd -D