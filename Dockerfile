FROM python:2.7-alpine
MAINTAINER Joshua Noble <acejam@gmail.com>

ENV P2POOL_VERSION 68f653f243f41783f706d6f2ffe5bc9e05b5a283

WORKDIR /app

RUN apk add --no-cache build-base libffi-dev openssl-dev git && \
    addgroup -S python && adduser -S -g python python

RUN git clone https://github.com/p2pool/p2pool.git && \
    cd p2pool && git reset --hard $P2POOL_VERSION && \
    chown -R python:python p2pool && \
    echo "service_identity" >> requirements.txt && \
    pip install --no-cache-dir -r requirements.txt

USER python
EXPOSE 9332 9333
ENTRYPOINT ["python", "/app/p2pool/run_p2pool.py"]
