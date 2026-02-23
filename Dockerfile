FROM ruby:3.3.10-alpine

RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    bash

WORKDIR /app

COPY Gemfile Gemfile.lock* ./
RUN bundle install

COPY . .

EXPOSE 9292

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
