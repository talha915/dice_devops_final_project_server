import os
import random
import string
import hashlib
from fastapi import FastAPI  # type: ignore
from fastapi.responses import FileResponse, JSONResponse  # type: ignore

app = FastAPI()

# Directory to save the file
data_dir = "/serverdata"
file_path = os.path.join(data_dir, "random_data.txt")


def generate_random_text(size=1024):
    return "".join(random.choices(string.ascii_letters + string.digits, k=size))


def create_random_file():
    with open(file_path, "w") as f:
        f.write(generate_random_text())


def calculate_checksum(file_path):
    sha256_hash = hashlib.sha256()
    with open(file_path, "rb") as f:
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()


@app.get("/getfile")
def get_file():
    create_random_file()
    checksum = calculate_checksum(file_path)
    return JSONResponse(content={"filename": "random_data.txt", "checksum": checksum})


@app.get("/download")
def download_file():
    return FileResponse(file_path, filename="random_data.txt")


if __name__ == "__main__":
    os.makedirs(data_dir, exist_ok=True)
