FROM louislam/uptime-kuma:base-debian AS upload-artifact
WORKDIR /
RUN apt update && \
    apt --yes install curl file

COPY --from=build /app /app

ARG VERSION
ARG GITHUB_TOKEN
ARG TARGETARCH
ARG PLATFORM=debian
ARG FILE=$PLATFORM-$TARGETARCH-$VERSION.tar.gz
ARG DIST=dist.tar.gz

RUN chmod +x /app/extra/upload-github-release-asset.sh

# Full Build
# RUN tar -zcvf $FILE app
# RUN /app/extra/upload-github-release-asset.sh github_api_token=$GITHUB_TOKEN owner=louislam repo=uptime-kuma tag=$VERSION filename=$FILE

# Dist only
RUN cd /app && tar -zcvf $DIST dist
RUN /app/extra/upload-github-release-asset.sh github_api_token=$GITHUB_TOKEN owner=louislam repo=uptime-kuma tag=$VERSION filename=/app/$DIST
