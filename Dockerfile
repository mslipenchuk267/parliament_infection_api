FROM ruby:2.7.1

# Create a local folder for the app assets
RUN mkdir /infection-backend
WORKDIR /infection-backend

# Install required tooling
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client --fix-missing --no-install-recommends nano
RUN apt-get update && \
  apt-get install -qq -y --no-install-recommends cron && \
  rm -rf /var/lib/apt/lists/*

# Set our environment variables
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true 
ENV RAILS_LOG_TO_STDOUT true 

# Copy and install Gems from our Gemfile
COPY Gemfile /infection-backend/Gemfile 
COPY Gemfile.lock /infection-backend/Gemfile.lock

RUN gem install bundler -v 2.0.2

RUN bundle config set deployment 'true'
RUN bundle install

COPY . ./

RUN touch ./log/cron_development.log
RUN touch ./log/cron_production.log

EXPOSE 3000

# Start the puma server
CMD bundle exec puma -p 3000 -d && bundle exec whenever --update-crontab && cron -f