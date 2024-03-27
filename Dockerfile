FROM apache/tika:2.9.1.0-full

# switch to root so we can install packages
USER 0

RUN apt-get update && \
    apt-get install --yes --no-install-recommends tesseract-ocr-slk tesseract-ocr-ces && \
    apt-get clean -y && \
    mkdir /tika-extras && \
    wget https://repo1.maven.org/maven2/com/github/jai-imageio/jai-imageio-jpeg2000/1.4.0/jai-imageio-jpeg2000-1.4.0.jar -O /tika-extras/jai-imageio-jpeg2000-1.4.0.jar


# revert to previous user
USER $UID_GID

