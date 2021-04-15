#FROM ruby:2.5
#RUN apt-get update && apt-get install -y nodejs yarn postgresql-client cmake

FROM ruby:2.5-alpine
RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache \
  build-base curl-dev git postgresql-dev yaml-dev zlib-dev nodejs yarn postgresql-client cmake tzdata

WORKDIR /app

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV SECRET_KEY_BASE=abc

COPY Gemfile* package.json yarn.lock ./

RUN bundle install
RUN yarn install

COPY ./deploy/database.yml ./config/database.yml
COPY ./deploy/secrets.yml ./config/secrets.yml
COPY . .

# RUN bin/rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
