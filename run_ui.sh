#!/bin/bash

echo "LLama Stack Endpoint Address: $LLAMA_STACK_ENDPOINT"

echo "Starting Llama Stack UI..."
streamlit run /usr/local/lib/python3.12/site-packages/llama_stack/core/ui/app.py --server.port=8080 --server.address=0.0.0.0 --logger.level=debug
