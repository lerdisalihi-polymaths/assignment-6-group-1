FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY src/ ./src/

# Expose port
EXPOSE 3000

# Run with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:3000", "--workers", "4", "src.app:app"]
