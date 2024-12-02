# Use a more minimal Python base image
FROM python:3.9-slim-bullseye

# Set working directory in container
WORKDIR /app

# Only copy requirements first to leverage cache
COPY requirements.txt .

# Combine RUN commands and clean up in the same layer
RUN pip install --no-cache-dir -r requirements.txt && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf ~/.cache/pip/*

# Copy only necessary application files
COPY . .

# Command to run the application
CMD ["python", "run_adcheck.py"]
