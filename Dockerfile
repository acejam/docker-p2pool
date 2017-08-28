FROM python:2.7-alpine
MAINTAINER Joshua Noble <acejam@gmail.com>

ENV P2POOL_VERSION 17.0

WORKDIR /app

RUN apk add --no-cache build-base libffi-dev openssl-dev git && \
    addgroup -S python && adduser -S -g python python && \
    git clone --branch $P2POOL_VERSION https://github.com/p2pool/p2pool.git && \
    chown -R python:python p2pool

RUN cd p2pool && \
    echo "service_identity" >> requirements.txt && \
    pip install --no-cache-dir -r requirements.txt

USER python
EXPOSE 9332 9333
ENTRYPOINT ["python", "/app/p2pool/run_p2pool.py"]
