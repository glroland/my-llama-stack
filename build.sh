#!/bin/bash

uv venv my-llama-stack --python 3.12
source my-llama-stack/bin/activate

uv pip install -r requirements.txt

llama stack build --config build.yaml --image-type container --image-name my-llama-stack

# docker tag my-llama-stack:0.2.5 registry.home.glroland.com/ai/my-llama-stack:1b

# docker build . --file Dockerfile.run_override -t registry.home.glroland.com/llama/stack:1

## docker push registry.home.glroland.com/llama/stack:1
