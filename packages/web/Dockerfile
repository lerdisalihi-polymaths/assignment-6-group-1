FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose port
EXPOSE 80

# Run with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:80", "--workers", "2", "server:app"]
