FROM micalgenus/docker-images:ruby-rails-2.5.3-5.2.2

RUN apt-get -y update && apt-get -y install apt-transport-https apt-utils
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get -y update && apt-get -y install  yarn

COPY ./entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]

WORKDIR /usr/local/share/rails-tmdb
COPY . ./

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["production"]