FROM ruby:2.5.1

ENV APP_ROOT /date-adjuster
ENV LANG C.UTF-8

RUN \
  apt-get update -qq \
  && apt-get install -y --no-install-recommends build-essential libpq-dev mysql-client \
  && curl -sL https://deb.nodesource.com/setup_9.x | bash \
  && apt-get install -y nodejs \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get install -y yarn \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p $APP_ROOT

WORKDIR $APP_ROOT

ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

ADD . $APP_ROOT
