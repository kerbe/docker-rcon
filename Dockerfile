FROM gcc:latest

RUN git clone https://github.com/kerbe/rcon.git

WORKDIR rcon
RUN gcc -static -o rcon rcon.c

FROM alpine:latest

MAINTAINER kerbe

RUN addgroup -S rcon && adduser -S rcon -G rcon

USER rcon
WORKDIR /home/rcon

COPY --from=0 rcon/rcon .

ENTRYPOINT ["./rcon"]
