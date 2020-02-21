FROM openjdk:8-jdk
LABEL maintainer="Rowan Gaffney <rowan.gaffney@usda.gov>"

WORKDIR /opt
RUN wget https://ccl.northwestern.edu/netlogo/6.1.1/NetLogo-6.1.1-64.tgz && \
  tar xzf NetLogo-6.1.1-64.tgz && ln -sf "NetLogo 6.1.1" netlogo && \
  rm -f NetLogo-6.1.1-64.tgz
