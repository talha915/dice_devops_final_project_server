FROM python:3.9-slim

VOLUME /serverdata

WORKDIR /serverdata

COPY requirements.txt .

COPY app /serverdata/app
COPY app/random_text_file.txt /serverdata/app/random_text_file.txt

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /serverdata && chmod 777 /serverdata

EXPOSE 8000

CMD ["uvicorn", "app.index:app", "--host", "0.0.0.0", "--port", "8000"]