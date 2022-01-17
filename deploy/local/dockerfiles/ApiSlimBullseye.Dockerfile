FROM ruby:3.1.0-slim-bullseye

#Local deps
RUN apt update \
  && apt upgrade -y \
  && apt install -y \
  build-essential sqlite3 postgresql postgresql-client \
  libyaml-dev zlib1g zlib1g-dev libpq-dev libzip-dev \
  libssl-dev libsasl2-dev libxml2-dev zlib1g-dev libpng-dev libcurl4-openssl-dev libmcrypt-dev libsqlite3-dev\
  apt-utils net-tools bash git nano curl htop tzdata nodejs zip unzip gnupg pkg-config imagemagick libmagickwand-dev

WORKDIR /app

COPY ./deploy/local/.env /app/

COPY ./deploy/local/bin/install-rails.sh /usr/local/bin/install-rails
RUN chmod +x /usr/local/bin/install-rails

COPY ./deploy/local/bin/craft-app.sh /usr/local/bin/craft-app
RUN chmod +x /usr/local/bin/craft-app

COPY ./deploy/local/bin/bundle-deps.sh /usr/local/bin/bundle-deps
RUN chmod +x /usr/local/bin/bundle-deps

COPY ./deploy/local/bin/init-app.sh /usr/local/bin/init-app
RUN chmod +x /usr/local/bin/init-app

EXPOSE 3030

#CMD ["/usr/local/bin/init-app"]