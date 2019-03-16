FROM micalgenus/docker-images:ruby-rails-2.5.3-5.2.2

COPY ./entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]

WORKDIR /usr/local/share/rails-tmdb
COPY . ./

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["development"]
# CMD ["./bin/rails", "server"]
