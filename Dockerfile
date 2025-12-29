FROM python:3.10-slim

# Set environment to avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install essential system packages
RUN apt-get update && apt-get install -y git build-essential && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install MLC LLM
RUN pip install --upgrade pip && \
    pip install mlc-llm

# Create a working directory
WORKDIR /workspace

# Volume for models
VOLUME ["/root/.cache/mlc_llm"]

# Default command: Start MLC API Server
# --device cpu forces CPU usage (safe for Dokploy without GPU passthrough config)
CMD ["python", "-m", "mlc_llm.serve", "--host", "0.0.0.0", "--port", "11434", "--device", "cpu"]