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

# Claude Code + JS tooling
RUN npm install -g \
    @anthropic-ai/claude-code \
    pnpm \
    bun

# Install uv
RUN pip install --no-cache-dir uv

COPY . .

# Install FCC dependencies
RUN uv sync

# Create persistent workspace
RUN mkdir -p /projects

WORKDIR /projects

EXPOSE 8082

CMD ["uv", "run", "fcc-server"]
