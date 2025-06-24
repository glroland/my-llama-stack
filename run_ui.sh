#!/bin/bash

echo "LLama Stack Endpoint Address: $LLAMA_STACK_ENDPOINT"

echo "Starting Llama Stack UI..."
streamlit run /usr/local/lib/python3.11/site-packages/llama_stack/distribution/ui/app.py --server.port=8080 --server.address=0.0.0.0 --logger.level=debug
