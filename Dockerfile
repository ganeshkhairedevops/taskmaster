# ===========================
# Stage 1 — Build dependencies
# ===========================
FROM python:3.9-slim AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y gcc && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies into a wheel directory
COPY requirements.txt .
RUN pip wheel --no-cache-dir --wheel-dir /app/wheels -r requirements.txt


# ===========================
# Stage 2 — Final runtime image
# ===========================
FROM python:3.9-slim

WORKDIR /app

# Install only the built wheels (no gcc needed)
COPY --from=builder /app/wheels /wheels
RUN pip install --no-cache-dir /wheels/*

# Copy code
COPY app.py .
COPY templates/ templates/

# Create non-root user
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5000/health || exit 1

CMD ["python", "app.py"]
