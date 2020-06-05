FROM ruby:2.6.3

RUN set -ex \
  && apt-get update \
  && apt-get install -y unzip xvfb libxi6 libgconf-2-4 \
  && curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
  && echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get -y update \
  && apt-get -y install google-chrome-stable \
  && wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip \
  && unzip chromedriver_linux64.zip \
  && mv chromedriver /usr/bin/chromedriver \
  && chown root:root /usr/bin/chromedriver \
  && chmod +x /usr/bin/chromedriver 

RUN apt-get install -y mc

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./

RUN set -ex \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt update \
  && apt-get install -y yarn \
  && yarn install

COPY . ./
RUN cp config/database.yml.example config/database.yml
CMD ["echo", "go"]