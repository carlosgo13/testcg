FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev python3

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY *.py /app/

EXPOSE 8080

ENTRYPOINT [ "python3" ]

CMD [ "app.py" ]