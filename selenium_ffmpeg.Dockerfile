
ARG CI_REGISTRY
ARG CI_PROJECT_NAMESPACE

FROM ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/lazy_images/selenium:latest

RUN apk add --update --no-cache git clang make nasm pkgconf openssl-dev

RUN [ -d FFmpeg ] || git clone https://github.com/FFmpeg/FFmpeg.git
RUN cd FFmpeg && ./configure --enable-openssl --enable-protocol=https --enable-nonfree && make -j && make install && cd ..
RUN rm -rf FFmpeg

RUN apk del git clang make nasm pkgconf openssl-dev

RUN apk add --update --no-cache openssl
