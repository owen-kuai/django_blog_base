FROM alpine:3.11
WORKDIR /app

COPY ./requirements.txt .

RUN apk --update --no-cache add python3 py3-pip py-gunicorn nginx mariadb-connector-c \
    && apk --update --no-cache add --virtual .build-deps \
        tzdata \
        python3-dev \
		mariadb-connector-c-dev \
		gcc \
		musl-dev \
        jpeg-dev \
        zlib-dev \
        freetype-dev \
        lcms2-dev \
        openjpeg-dev \
        tiff-dev \
        tk-dev \
        tcl-dev \
        harfbuzz-dev \
        fribidi-dev \
        # mysqlclient dependencies
        # Pillow dependencies

	&& pip3 install --upgrade pip setuptools gevent \
	&& mkdir -p /run/nginx \
    && pip3 install -r requirements.txt \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del .build-deps
