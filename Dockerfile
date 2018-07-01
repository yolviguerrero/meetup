FROM python:3.5

WORKDIR /meetup/
COPY requirements.txt /meetup/
RUN pip3 install -r requirements.txt
RUN echo "Hello from Dockerfile" > /etc/hello.txt
