FROM alpine:latest

# Install Python and pip without caching, then upgrade pip.
RUN apt-get update && apt-get install -y \
    python3 python3-pip && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip

WORKDIR /app

# Copy only requirements first for better layer caching.
COPY src/requirements.txt /app/src/requirements.txt
RUN pip install --no-cache-dir -r /app/src/requirements.txt

# Copy the rest of the application source.
COPY . /app/

EXPOSE 8000

CMD ["python3", "src/application.py"]