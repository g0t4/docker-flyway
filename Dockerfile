FROM debian AS extract-env

ENV FLYWAY_VERSION=4.1.2
ENV FLYWAY_DOWNLOAD_URL=https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz 
ADD ${FLYWAY_DOWNLOAD_URL} /download/flyway.tar.gz
RUN tar -xf /download/flyway.tar.gz
RUN mv /flyway-${FLYWAY_VERSION} /flyway

FROM debian AS runtime-env
COPY --from=extract-env /flyway /flyway 
# treat this image as a flyway command
ENTRYPOINT ["/flyway/flyway"]
# by default run flyway --help
CMD ["--help"]
