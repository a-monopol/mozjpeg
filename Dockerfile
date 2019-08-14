From golang

# Runtimeを含む静的ライブラリとしてビルド
ENV CFLAGS --static

WORKDIR /go

RUN apt update \
	&& apt install -y \
	   autoconf \
	   automake \
	   libtool \
	   nasm \
	   yasm \
       --no-install-recommends && rm -r /var/lib/apt/lists/*

COPY mozjpeg-3.3.1.tar.gz /go
RUN tar zxvf mozjpeg-3.3.1.tar.gz -C /go/src --strip=1

WORKDIR /go/src

RUN ls -l && autoreconf -fiv \
	&& ./configure --disable-shared --enable-static \
	&& make clean

# docer run で ライブラリのビルド
CMD ["make", "install", "prefix=/go/build"]