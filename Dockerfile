FROM ruby:3.4.1
LABEL maintainer="programming@gpcweb.com"

RUN apt-get update -qq \
  && apt-get install -y \
  build-essential \
  libpq-dev \
  vim \
  graphviz \
  postgresql-client \
  --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000

ENV RAILS_ENV=production
COPY Gemfile Gemfile.lock ./

RUN bundle install -j 8

COPY . ./

ARG CONTAINERID=latest
ENV FINGERPRINT=${CONTAINERID}

COPY bin/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["bin/start_process.sh"]
