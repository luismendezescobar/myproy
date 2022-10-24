FROM python:latest
WORKDIR /app
ADD . /app


RUN pip install -r requirements.txt

EXPOSE 80

CMD ["python",pets-adopt.py]