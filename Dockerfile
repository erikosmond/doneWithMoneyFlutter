FROM node:lts-buster-slim

# Configure Ubuntu
ENV DEVUSER=developer
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y unzip git curl wget dpkg sudo

# Prepare Flutter
RUN chmod 777 /opt

# Download Chrome for Flutter web development
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb || true
RUN apt -f install -y
RUN dpkg -i google-chrome-stable_current_amd64.deb

# Config for VS Code Container
RUN useradd -ms /bin/bash $DEVUSER
RUN echo "$DEVUSER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /home/$DEVUSER
USER $DEVUSER

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b dev --depth 1 /opt/flutter
ENV PATH="/opt/flutter/bin:${PATH}"

RUN flutter doctor
RUN flutter config --enable-web

# Install firebase
RUN yarn global add firebase-tools


