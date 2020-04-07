FROM ruby:2.5.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
nodejs yarn build-essential libpq-dev imagemagick git-all nano

ENV CHROMIUM_DRIVER_VERSION 2.46

RUN apt-get update && apt-get -y --no-install-recommends install zlib1g-dev liblzma-dev wget xvfb unzip libnss3 nodejs \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -  \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list \
    && echo "deb http://ftp.de.debian.org/debian/ stretch main" >> /etc/apt/sources.list \
    && apt-get update && apt-get -y --allow-unauthenticated  --no-install-recommends install google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$CHROMIUM_DRIVER_VERSION/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ \
    && rm /tmp/chromedriver.zip \
    && chmod ugo+rx /usr/bin/chromedriver


# Seta nosso path
ENV INSTALL_PATH /genomico

# Cria nosso diretório
RUN mkdir -p $INSTALL_PATH

# Seta o nosso path como o diretório principal
WORKDIR $INSTALL_PATH

# Copia o nosso Gemfile para dentro do container
COPY Gemfile ./

# Seta o path para as Gems
ENV BUNDLE_PATH /gems

# Copia nosso código para dentro do container
COPY . .