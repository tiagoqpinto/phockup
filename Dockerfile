FROM ghcr.io/linuxserver/baseimage-alpine:3.18

VOLUME /mnt/input
VOLUME /mnt/output

ENV CRON ""
ENV OPTIONS ""

COPY . /opt/phockup
RUN chmod +x /opt/phockup/entrypoint.sh

RUN apk --no-cache add python3 py3-pip exiftool \
    && pip install --no-cache-dir -r /opt/phockup/requirements.txt \
    && ln -s /opt/phockup/phockup.py /usr/local/bin/phockup \
    && apk add bash \
    && apk add flock

ENTRYPOINT ["/opt/phockup/entrypoint.sh"]
