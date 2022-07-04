
# FROM ubuntu:20.04
# WORKDIR /var/www/html

# COPY ./ /var/www/html/

# ENV DEBIAN_FRONTEND noninteractive
# ENV TZ=UTC

# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# RUN apt-get update \
#     && apt-get install -y gnupg gosu curl ca-certificates zip unzip git supervisor sqlite3 libcap2-bin vim\
#     && mkdir -p ~/.gnupg \
#     && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf \
#     && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E5267A6C \
#     && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C300EE8C \
#     && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
#     && apt-get update \
#     && apt-get install -y php8.1-cli php8.1-dev \
#        php8.1-pgsql php8.1-sqlite3 php8.1-gd \
#        php8.1-curl php8.1-memcached \
#        php8.1-imap php8.1-mysql php8.1-mbstring \
#        php8.1-xml php8.1-zip php8.1-bcmath php8.1-soap \
#        php8.1-intl php8.1-readline \
#        php8.1-msgpack php8.1-igbinary php8.1-ldap \
#        php8.1-redis \
#     && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
#     && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
#     && apt-get install -y nodejs \
#     && apt-get -y autoremove \
#     && apt-get clean \
#     && apt-get install -y zsh \
#     && apt-get install -y wget \
#     && apt-get install -y php-xdebug \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
#     && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.1

# # Xdebug settings.
# COPY ./VM/xdebug.ini /etc/php/8.0/mods-available/xdebug.ini

# # Supervisor.
# # COPY ./VM/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# # Add admin user
# RUN useradd -ms /bin/bash -u 1337 admin

# RUN composer update

# # Make some ZSH configuration.
# ENV TERM xterm
# ENV ZSH_THEME agnoster

# # Expose ports.
# EXPOSE 8000
# EXPOSE 9000

# CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
FROM ubuntu:20.04

WORKDIR /var/www/html

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y gnupg gosu curl ca-certificates zip unzip git supervisor sqlite3 libcap2-bin \
    && mkdir -p ~/.gnupg \
    && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf \
    && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E5267A6C \
    && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C300EE8C \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
    && apt-get update \
    && apt-get install -y php8.1-cli php8.1-dev \
       php8.1-pgsql php8.1-sqlite3 php8.1-gd \
       php8.1-curl php8.1-memcached \
       php8.1-imap php8.1-mysql php8.1-mbstring \
       php8.1-xml php8.1-zip php8.1-bcmath php8.1-soap \
       php8.1-intl php8.1-readline \
       php8.1-msgpack php8.1-igbinary php8.1-ldap \
       php8.1-redis \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN apt-get update \
    && apt-get install -y php-xdebug

RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.1

# Xdebug settings.
COPY ./vm/xdebug.ini /etc/php/8.1/mods-available/xdebug.ini

COPY ./vm/php.ini /etc/php/8.1/cli/conf.d/php.ini
# RUN chmod +x /usr/local/bin/start-container

EXPOSE 8000
EXPOSE 9000

CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
