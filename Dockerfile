FROM ubuntu:20.04

# Configure Ubuntu
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y unzip git curl wget dpkg

# Install Flutter
RUN chmod 777 /opt
RUN git clone https://github.com/flutter/flutter.git -b dev --depth 1 /opt/flutter
ENV PATH="/opt/flutter/bin:${PATH}"

# Download Chrome for Flutter web development
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb || true
RUN apt -f install -y
RUN dpkg -i google-chrome-stable_current_amd64.deb

RUN flutter doctor
RUN flutter config --enable-web

# Config for VS Code Container
RUN useradd -ms /bin/bash developer
WORKDIR /home/developer
# USER developer