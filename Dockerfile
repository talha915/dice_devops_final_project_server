# Use the official Python base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Create the /serverdata directory where the volume will be mounted
RUN mkdir /serverdata

# Copy the FastAPI application code into the container
COPY . /app

# Expose the port on which the FastAPI server will run
EXPOSE 8000

# Command to run the FastAPI server using Uvicorn
CMD ["uvicorn", "index:app", "--host", "0.0.0.0", "--port", "8000"]
