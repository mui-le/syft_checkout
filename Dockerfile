FROM ruby:2.6.3-alpine

WORKDIR /app

RUN gem install 'rspec'
