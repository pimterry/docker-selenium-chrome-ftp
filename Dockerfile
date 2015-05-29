FROM node
MAINTAINER Tim Perry <pimterry@gmail.com>

USER root

# Lots of this has come verbatim from Selenium's NodeChrome docker image, which is almost (but not quite)
# a useful approach to doing the same thing.

#==============
# VNC and Xvfb
#==============
RUN apt-get update -qqy \
  && apt-get -qqy install xvfb \
  && rm -rf /var/lib/apt/lists/*

#===============
# Google Chrome
#===============
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/*

#======
# Java
#======
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    ca-certificates \
    openjdk-7-jre-headless \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/\/dev\/urandom/\/dev\/.\/urandom/' ./usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

#==========
# Selenium
#==========
RUN npm install -g selenium-standalone \
 && selenium-standalone install

#=====================================
# (Somewhat arbitrary) config options
#=====================================
ENV GEOMETRY 1360x1020x24
ENV DISPLAY :99.0

#=================================
# Add a script to make it easy to
# start up selenium etc
#=================================
RUN echo 'xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR" selenium-standalone start' > /usr/local/bin/start-selenium \
 && chmod +x /usr/local/bin/start-selenium
