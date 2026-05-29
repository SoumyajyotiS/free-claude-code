FROM python:3.14

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    build-essential \
    ripgrep \
    fd-find \
    sudo \
    ca-certificates

# Install Claude Code
RUN npm install -g \
    @anthropic-ai/claude-code \
    pnpm \
    bun

# Install uv
RUN pip install --no-cache-dir uv

COPY . .

# Install dependencies
RUN uv sync --frozen

# IMPORTANT: install FCC package itself
RUN uv pip install -e .

# Persistent workspace
RUN mkdir -p /projects

WORKDIR /projects

EXPOSE 8082

CMD ["/app/.venv/bin/fcc-server"]
