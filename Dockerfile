FROM ruby:2.7.2
ENV LANG C.UTF-8

# Specify JP mirror, other mirrors are less stable than JP's
RUN echo 'deb http://ftp.jp.debian.org/debian/ buster main contrib non-free' > /etc/apt/sources.list
RUN echo 'deb http://ftp.jp.debian.org/debian/ buster-updates main contrib' >> /etc/apt/sources.list
RUN echo 'deb http://ftp.jp.debian.org/debian/ buster-backports main contrib non-free' >> /etc/apt/sources.list
RUN echo '#deb-src http://ftp.jp.debian.org/debian/ buster main contrib non-free' >> /etc/apt/sources.list
RUN echo '#deb-src http://ftp.jp.debian.org/debian/ buster-updates main contrib' >> /etc/apt/sources.list
RUN echo '#deb-src http://ftp.jp.debian.org/debian/ buster-backports main contrib non-free' >> /etc/apt/sources.list

RUN apt-get update -qq && apt-get install -y build-essential default-mysql-client imagemagick apt-transport-https

RUN mkdir /api
ENV APP_ROOT /api
WORKDIR $APP_ROOT
COPY ./Gemfile* $APP_ROOT/

# Install yarn
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn
RUN gem uninstall bundler && gem install -N bundler

RUN bundle install --jobs=4
COPY . $APP_ROOT
