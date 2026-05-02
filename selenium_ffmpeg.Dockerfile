
ARG CI_REGISTRY
ARG CI_PROJECT_NAMESPACE

FROM ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/lazy_images/selenium:latest

ARG dev_pkgs='git clang make nasm pkgconf openssl-dev x264-dev x265-dev libvpx-dev aom-dev libass-dev lame-dev'
ARG runtime_pkgs='openssl x264-libs x265-libs libvpx aom-libs libass lame'

RUN apk add --update --no-cache $dev_pkgs

RUN [ -d FFmpeg ] || git clone https://github.com/FFmpeg/FFmpeg.git
RUN cd FFmpeg && ./configure --enable-openssl --enable-protocol=https --enable-nonfree --enable-gpl --enable-libx264 --enable-libx265 --enable-libvpx --enable-libass --enable-libmp3lame --enable-libaom --extra-ldflags='-Wl,-z,stack-size=2097152' && make -j && make install && cd ..
RUN rm -rf FFmpeg

RUN apk del $dev_pkgs

RUN apk add --update --no-cache $runtime_pkgs
