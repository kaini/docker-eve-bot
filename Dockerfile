FROM debian:stretch

RUN apt-get update && \
    apt-get install -y protobuf-compiler python-protobuf git && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --gid 1234 evebot && \
    adduser --disabled-password --disabled-login --gecos "" --uid 1234 --gid 1234 evebot

WORKDIR /home/evebot
USER evebot

RUN git clone https://github.com/frymaster/eve-bot.git

WORKDIR /home/evebot/eve-bot

RUN git checkout e8c651cfd3624e0f28da9103086b7725153f24ac && \
    rm -rf .git && \
    protoc --python_out=. Mumble.proto

ENTRYPOINT ["/usr/bin/python", "./eve-bot.py"]
