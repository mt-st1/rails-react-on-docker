FROM ruby:2.5.1

ENV APP_ROOT /date-adjuster
ENV LANG C.UTF-8

RUN \
  apt-get update -qq \
  && apt-get install -y --no-install-recommends build-essential nodejs libpq-dev libmysqlclient-dev mysql-client \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p $APP_ROOT

WORKDIR $APP_ROOT

ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

ADD . $APP_ROOT
