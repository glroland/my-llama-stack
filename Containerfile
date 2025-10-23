ARG LLAMA_STACK_TAG=my-llama-stack

FROM llama-stack:${LLAMA_STACK_TAG}

ADD my-llama-stack-run.yaml /app/run.yaml
