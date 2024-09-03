import os
import hashlib
import random, string
from fastapi import FastAPI, HTTPException
from fastapi.responses import FileResponse

app = FastAPI()

data_dir = "/serverdata"
file_path = os.path.join(data_dir, "random_data.txt")


def generate_random_text(size=1024):
    """Generate random text of specified size."""
    return "".join(random.choices(string.ascii_letters + string.digits, k=size))


def create_random_file():
    """Create a file with random content."""
    os.makedirs(data_dir, exist_ok=True)  # Ensure directory is created
    with open(file_path, "w") as f:
        f.write(generate_random_text())


@app.get("/generate_file")
async def generate_file():
    try:
        # Create the file with random content
        create_random_file()

        # Read the content of the file
        with open(file_path, "r") as existing_file:
            file_content = existing_file.read()

        # Calculate checksum
        checksum = hashlib.sha256(file_content.encode()).hexdigest()

        # Return the file with checksum in headers
        return FileResponse(
            path=file_path, filename="random_data.txt", headers={"checksum": checksum}
        )
    except Exception as e:
        # Log the exception and return a 500 error
        print(f"Error: {e}")
        raise HTTPException(status_code=500, detail=str(e))  # Return the actual error
