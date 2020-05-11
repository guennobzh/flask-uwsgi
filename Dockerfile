FROM python:alpine

# Install uwsgi dependencies 
RUN apk add --update --no-cache \
    python3-dev \
    build-base \
    linux-headers \
    pcre-dev

# Create account 
RUN addgroup -S uwsgi && adduser -S uwsgi -G uwsgi

# Create directorys
RUN mkdir /venv && chown uwsgi:uwsgi /venv
RUN mkdir /app && chown uwsgi:uwsgi /app

# Switch user
USER uwsgi

# Define virtual environment path
ENV VIRTUAL_ENV=/venv
   
# Create virtual environment directory
RUN python3 -m venv $VIRTUAL_ENV

# Add virtual environment bin to path
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install uwsgi and flask in virtual environment
RUN pip install --no-cache-dir  \
    wheel \
    uwsgi \
    flask

# Copy demo app in app directory
COPY demoapp/* /app/

# Copy lunch script
COPY run.py /

WORKDIR /app

EXPOSE 3000

CMD ["python", "/run.py"]
