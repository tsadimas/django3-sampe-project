# Use an existing docker image as a base
FROM python:3.10-alpine3.17

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /usr/data


RUN apk update && apk add gcc  libc-dev

RUN addgroup -S appuser && adduser -S appuser -G appuser  --home /usr/data

ENV PATH=$PATH:/usr/data/.local/bin


# COPY requirements.txt
COPY ./requirements.txt ./

RUN pip install -r requirements.txt
# Copy main.py file
COPY ./myproject ./

USER root
RUN chown -R appuser:appuser /usr/data

USER appuser:appuser

EXPOSE 8000/tcp

# Tell what to do when it starts as a container
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]