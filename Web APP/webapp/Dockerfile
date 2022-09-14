FROM python:3.9.10

COPY requirements.txt /app/

RUN pip install -r /app/requirements.txt

COPY . /app
EXPOSE 5007

#CMD ["python", "/app/app.py"]