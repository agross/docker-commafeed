FROM openjdk:8-alpine
LABEL maintainer "Alexander Groß <agross@therightstuff.de>"

EXPOSE 8082

HEALTHCHECK --start-period=30s \
            CMD wget --server-response --output-document=/dev/null http://localhost:8082 || exit 1

RUN echo Installing packages && \
    apk add --no-cache \
            bash \
            wget

RUN COMMAFEED_VERSION=2.4.0 && \
    \
    DOWNLOAD_URL=https://github.com/Athou/commafeed/releases/download/$COMMAFEED_VERSION/commafeed.jar && \
    echo Downloading $DOWNLOAD_URL to $(pwd) && \
    wget "$DOWNLOAD_URL" --progress bar:force:noscroll --output-document commafeed.jar

CMD ["java", "-jar", "commafeed.jar", "server", "/config/config.yml"]
