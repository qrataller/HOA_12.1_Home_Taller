#!/bin/bash

# Creating temporary directories
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Copy directories and .py files to temporary directories
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.


# Creating dockerfile
echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/">> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 8080" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile

# Build the Docker container
cd tempdir
docker build --no-cache -t sampleapp .

# Start the container
docker run -t -d -p 8080:8080 --name samplerunning sampleapp

# Verify
docker ps -a
