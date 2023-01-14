FROM ruby:2.7.5

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm

RUN mkdir /shoe_store
WORKDIR /shoe_store
COPY Gemfile /shoe_store/Gemfile
COPY Gemfile.lock /shoe_store/Gemfile.lock
RUN bundle install
COPY package.json /shoe_store/package.json
COPY package-lock.json /shoe_store/package-lock.json
RUN npm install
COPY . /shoe_store

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bin/dev", "-b", "0.0.0.0"]