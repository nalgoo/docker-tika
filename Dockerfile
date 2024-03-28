FROM apache/tika:2.9.1.0-full

# switch to root so we can install packages
USER 0

ARG S6_OVERLAY_VERSION=3.1.6.2

ADD clean.sh /etc/cron.hourly/

RUN apt-get update && \
    apt-get install --yes --no-install-recommends cron tesseract-ocr-slk tesseract-ocr-ces && \
    apt-get clean -y && \
    mkdir /tika-extras && \
    wget https://repo1.maven.org/maven2/com/github/jai-imageio/jai-imageio-jpeg2000/1.4.0/jai-imageio-jpeg2000-1.4.0.jar -O /tika-extras/jai-imageio-jpeg2000-1.4.0.jar && \
    chmod +x /etc/cron.hourly/clean.sh

ENTRYPOINT []

CMD ["/bin/sh", "-c", "/usr/sbin/cron && exec java -cp \"/tika-server-standard-${TIKA_VERSION}.jar:/tika-extras/*\" org.apache.tika.server.core.TikaServerCli -h 0.0.0.0 $0 $@"]

# revert to previous user
USER $UID_GID

