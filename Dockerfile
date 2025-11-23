FROM public.ecr.aws/docker/library/alpine:3.14

# Install Python and pip without caching, then upgrade pip.
RUN apk add --no-cache python3 py3-pip \
    && pip install --upgrade pip

WORKDIR /app

# Copy only requirements first for better layer caching.
COPY src/requirements.txt /app/src/requirements.txt
RUN pip install --no-cache-dir -r /app/src/requirements.txt

# Copy the rest of the application source.
COPY . /app/

EXPOSE 8000

CMD ["python3", "src/application.py"]