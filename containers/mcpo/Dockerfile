FROM python:3.12-slim

# Install Node.js and npm (required by the npx-based MCP servers).
RUN apt-get update && apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN node -v && npm -v && npx --version

WORKDIR /app

COPY config.json config.json

# `uv` provides the `uvx` launcher used to run mcpo and the uvx-based MCP servers.
RUN pip install --no-cache-dir uv

EXPOSE 80

# Use the shell form so $API_KEY (injected from Secrets Manager) is expanded at runtime.
# In the JSON/exec form the variable would be passed literally as the string "$API_KEY".
CMD uvx mcpo --host 0.0.0.0 --port 80 --api-key "$API_KEY" --config /app/config.json

# To run mcpo without API key authentication, replace the CMD above with:
# CMD uvx mcpo --host 0.0.0.0 --port 80 --config /app/config.json
