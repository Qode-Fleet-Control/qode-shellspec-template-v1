# Built by .github/workflows/deploy.yml (context ., file Dockerfile) and pushed
# to Artifact Registry.
#
# A job image, not a server: FROM the official ShellSpec image (debian variant, so the
# specs can also run under bash), as a non-root user. Its entrypoint is `shellspec`; the
# default command runs every spec under spec/ (options in .shellspec) and exits 0 when
# they pass.

FROM shellspec/shellspec-debian:0.28.1
ARG BUILD_ID=""
ENV BUILD_ID=$BUILD_ID
RUN useradd -m -u 10001 app
WORKDIR /src
COPY --chown=app:app . .
USER app
CMD ["--format", "documentation"]
