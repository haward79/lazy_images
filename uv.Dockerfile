
FROM alpine:3.23.3

RUN apk add --update --no-cache curl

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN ln -f -s "$HOME/.local/bin/uv" /usr/local/bin/uv
RUN ln -f -s "$HOME/.local/bin/uvx" /usr/local/bin/uvx
