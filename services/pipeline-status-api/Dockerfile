FROM python:3.15
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY . .

# Disable development dependencies
ENV UV_NO_DEV=1

# Sync the project into a new environment, asserting the lockfile is up to date
WORKDIR .
RUN uv sync --locked

CMD ["uv","run","uvicorn","main:app","--host","0.0.0.0"]