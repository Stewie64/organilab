# Use an official Python runtime as a parent image
FROM python:3.6.4-stretch
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /organilab/logs/
WORKDIR /organilab

RUN apt-get update && \
    apt-get install -y  libxslt-dev libxml2-dev python3-setuptools python3-cffi libcairo2 libffi-dev libpq-dev nginx supervisor python3-gdal

ADD requirements.txt /organilab

RUN pip install --upgrade --trusted-host pypi.python.org --no-cache-dir pip && \
pip install --trusted-host pypi.python.org --no-cache-dir -r requirements.txt && \
pip install --trusted-host pypi.python.org --no-cache-dir gunicorn

RUN apt-get -y autoremove && \
     apt-get -y clean   && \
     rm -rf /var/lib/apt/lists/*

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY docker/nginx-app.conf /etc/nginx/sites-available/default
COPY docker/supervisor-app.conf /etc/supervisor/conf.d/

ADD src /organilab

RUN python manage.py collectstatic --settings=organilab.settings
RUN chown -R www-data:www-data /organilab

EXPOSE 80

CMD ["supervisord", "-n"]
