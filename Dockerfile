FROM python:3 AS compile-image
MAINTAINER Julian-Samuel Gebühr

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential gcc

RUN python -m venv /opt/venv
# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --no-cache-dir matrix-registration-bot

FROM python:3-slim

COPY --from=compile-image /opt/venv /opt/venv

VOLUME ["/data"]
WORKDIR /data

# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"
CMD ["matrix-registration-bot"]
