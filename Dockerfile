FROM apache/tika:2.9.1.0-full

# switch to root so we can install packages
USER 0

RUN apt-get update && \
	apt-get install --yes --no-install-recommends tesseract-ocr-slk tesseract-ocr-ces && \
	apt-get clean -y

# revert to previous user
USER $UID_GID

