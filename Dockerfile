FROM ruby:2.6.0

RUN apt-get update && \
    apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY ./lib/ $APP_HOME

# Start server
EXPOSE 4567

CMD ["ruby", "/app/server.rb"]