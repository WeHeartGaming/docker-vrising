FROM ubuntu:latest

RUN dpkg --add-architecture i386 && apt update && apt install --assume-yes \
	wine64 \
	wine32:i386 \
	xvfb \
	lib32gcc-s1 \
	curl \
	&& apt clean && rm -rf /var/cache/apt/archives /var/lib/apt/lists

WORKDIR /app

RUN mkdir -p /app/vrisingserver /app/data/Settings /app/steamcmd

ADD start.sh .

VOLUME [ "/app/vrisingserver", "/app/data" ]

ENTRYPOINT [ "./start.sh" ]
