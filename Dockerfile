FROM docker.io/ollama/ollama:latest AS ollama

FROM cgr.dev/chainguard/wolfi-base

RUN apk add --no-cache libstdc++

COPY --from=ollama /usr/bin/ollama /usr/bin/ollama
COPY --from=ollama /usr/lib/ollama/libggml-cpu-* /usr/lib/ollama/
COPY --from=ollama /usr/lib/ollama/libggml-base.so /usr/lib/ollama/libggml-base.so

# Environment variable setup
ENV OLLAMA_HOST=0.0.0.0

# Expose port for the service
EXPOSE 11434

ENTRYPOINT ["/usr/bin/ollama"]
CMD ["serve"]