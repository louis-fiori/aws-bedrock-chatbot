FROM python:3.12-slim

# Install Node.js and npm
RUN apt-get update && apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN node -v && npm -v && npx --version

WORKDIR /app

COPY config.json config.json

# Install MCPO and uvx
RUN pip install mcpo uv

EXPOSE 80

CMD ["uvx", "mcpo", "--host", "0.0.0.0", "--port", "80", "--api-key", "$API_KEY", "--config", "/app/config.json"]

# Uncomment the following line if you want to run mcpo directly without API key
# CMD ["uvx", "mcpo", "--host", "0.0.0.0", "--port", "80", "--config", "/app/config.json"]