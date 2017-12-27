FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /pmi_parser

WORKDIR /pmi_parser

CMD bundle exec rails server -b 0.0.0.0

ADD Gemfile /pmi_parser/Gemfile
ADD Gemfile.lock /pmi_parser/Gemfile.lock
RUN bundle install

ADD . ./

