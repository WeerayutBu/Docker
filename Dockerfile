FROM python:3.11-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl \
 && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y curl
RUN pip install --upgrade pip


WORKDIR /workspace

# Install Python deps (adjust if you use requirements.txt)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Hugging Face cache location inside container
ENV HF_HOME=/cache

# FastAPI port (documentation)
EXPOSE 8080

# Start the app (adjust module path if needed)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
