FROM apache/tika:2.9.2.0-full

# switch to root so we can install packages
USER 0

ADD clean.sh /

RUN apt-get update && \
    apt-get install --yes --no-install-recommends cron tesseract-ocr-slk tesseract-ocr-ces imagemagick python3-pip && \
    apt-get clean -y && \
    pip3 install scikit-image && \
    mkdir /tika-extras && \
    wget https://repo1.maven.org/maven2/com/github/jai-imageio/jai-imageio-jpeg2000/1.4.0/jai-imageio-jpeg2000-1.4.0.jar -O /tika-extras/jai-imageio-jpeg2000-1.4.0.jar && \
    chmod +x /clean.sh && \
    chmod o+w+t /run

ENTRYPOINT []

CMD ["/bin/sh", "-c", "/usr/sbin/cron && exec java -cp \"/tika-server-standard-${TIKA_VERSION}.jar:/tika-extras/*\" org.apache.tika.server.core.TikaServerCli -h 0.0.0.0 $0 $@"]

# run as nobody
# USER nobody

RUN crontab -l | { cat; echo "* * * * * /bin/sh -c /clean.sh"; } | crontab -
