FROM python:3.10-alpine3.17

WORKDIR /usr/data

COPY ./requirements.txt ./

RUN pip install  -r requirements.txt

COPY ./myproject /usr/data/

EXPOSE 8000/tcp


CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]