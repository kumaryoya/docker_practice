FROM ruby:3.2.2
ENV TZ Asia/Tokyo
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && apt-get install -y vim
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn
WORKDIR /cw_app
COPY Gemfile Gemfile.lock /cw_app/
RUN bundle install
COPY . /cw_app/
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["./bin/dev"]
# CMD ["rails", "server", "-b", "0.0.0.0"]
