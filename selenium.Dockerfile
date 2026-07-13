
ARG CI_REGISTRY
ARG CI_PROJECT_NAMESPACE

FROM ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/lazy_images/uv:latest

RUN apk add --update --no-cache curl firefox chromium chromium-chromedriver

RUN curl -L 'https://github.com/mozilla/geckodriver/releases/download/v0.36.0/geckodriver-v0.36.0-linux64.tar.gz' | tar -xzf -

RUN [[ -f "./geckodriver" ]] && mv ./geckodriver /usr/local/bin && chmod a+x /usr/local/bin/geckodriver
