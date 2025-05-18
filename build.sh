#!/bin/bash

uv venv my-llama-stack --python 3.11
source my-llama-stack/bin/activate

mkdir -p target
cd target && git clone https://github.com/meta-llama/llama-stack.git

cd target/llama-stack && uv pip install -e .

cp -R my-llama-stack-template target/llama-stack/llama_stack/templates/my-llama-stack-template
cd target/llama-stack && llama stack build --template my-llama-stack-template --image-type container




# llama stack build --config build.yaml --image-type container --image-name my-llama-stack

# docker tag my-llama-stack:0.2.5 registry.home.glroland.com/ai/my-llama-stack:1b

# docker build . --file Dockerfile.run_override -t registry.home.glroland.com/llama/stack:1

## docker push registry.home.glroland.com/llama/stack:1
