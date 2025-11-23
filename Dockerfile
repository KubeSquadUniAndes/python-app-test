FROM alpine:3.14

# Install Python and pip using Alpine package manager
RUN apk update && apk add --no-cache \
    python3 \
    py3-pip \
    && python3 -m pip install --upgrade pip \
    && rm -rf /var/cache/apk/*

WORKDIR /app

# Copy only requirements first for better layer caching.
COPY src/requirements.txt /app/src/requirements.txt
RUN pip install --no-cache-dir -r /app/src/requirements.txt

# Copy the rest of the application source.
COPY . /app/

EXPOSE 8000

CMD ["python3", "src/application.py"]