#!/bin/bash

export LLAMA_PATH=$HOME/.llama
export DISTRO=registry.home.glroland.com/llama/stack:1
export LLAMA_STACK_PORT=8321
export LLAMA_MODEL=llama3.2-vision:latest
export EMBEDDING_MODEL=sentence-transformers/all-mpnet-base-v2

docker run -d -p $LLAMA_STACK_PORT:$LLAMA_STACK_PORT -v $LLAMA_PATH:/root/.llama $DISTRO --port $LLAMA_STACK_PORT --env INFERENCE_MODEL=$LLAMA_MODEL --env EMBEDDING_MODEL=$EMBEDDING_MODEL --env MILVUS_ENDPOINT=http://db.home.glroland.com:19530 --env MILVUS_TOKEN=root:Milvus --env OLLAMA_URL=http://envision.home.glroland.com:11434

