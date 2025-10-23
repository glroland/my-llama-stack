ARG LLAMA_STACK_TAG=my-llama-stack

FROM llama-stack:${LLAMA_STACK_TAG}

ENV RUN_CONFIG_PATH=/app/run.yaml

ADD my-llama-stack-run.yaml /app/run.yaml

RUN mkdir -p /.llama/distributions
