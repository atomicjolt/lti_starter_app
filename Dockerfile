FROM ruby:2.7.4-alpine3.14 as build-env

# Build options:
# --build-arg VERSION=4.0.4

# VERSION is the semantic version or GIT SHA

# With no build args the build uses VERSION=latest

ARG RAILS_ROOT=/app

WORKDIR $RAILS_ROOT

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV SECRET_KEY_BASE=abc
ENV DATABASE_URL=postgresql:does_not_exist
ENV APARTMENT_DISABLE_INIT=true

ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
ENV RAILS_GROUPS="build"

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache \
     build-base curl-dev git postgresql-dev \
     yaml-dev zlib-dev nodejs yarn cmake tzdata \
     shared-mime-info sassc curl

COPY Gemfile* package.json yarn.lock ./
COPY ./config/secrets.yml.example ./config/k8s/secrets.yml

RUN gem install bundler \
  && bundle config frozen 1 \
  && bundle install --without test linter development ci --with build

RUN yarn install
COPY . .

ARG VERSION=latest

RUN printf 'APP_VERSION="%s".freeze\n' "$VERSION" > config/version.rb \
  && bin/rails assets:precompile

RUN rm -rf node_modules client tmp/cache spec \
  && bundle install --without test linter development ci build \
  && bundle clean --force \
  && rm -rf /usr/local/bundle/cache/*.gem \
  && find /usr/local/bundle/gems/ -name "*.c" -delete \
  && find /usr/local/bundle/gems/ -name "*.o" -delete

##############
FROM ruby:2.7.4-alpine3.14

ARG RAILS_ROOT=/app

WORKDIR $RAILS_ROOT

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=1
ENV RAILS_SERVE_STATIC_FILES=1

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache \
     tzdata postgresql-client bash \
     shared-mime-info git \
  && addgroup -S app-user && adduser -S app-user -G app-user

COPY --from=build-env /usr/local/bundle /usr/local/bundle
COPY --from=build-env $RAILS_ROOT $RAILS_ROOT

RUN bundle install --without test linter development ci build \
  && mkdir -p tmp/pids \
  && chown -R app-user tmp public

USER app-user

EXPOSE 3000
CMD ["puma", "--preload"]
