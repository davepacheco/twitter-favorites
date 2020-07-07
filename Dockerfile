FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y gcc g++ git make ruby-dev

# Install twurl to work around https://github.com/sferik/twitter/issues/878.
RUN gem install twurl
RUN gem install t

COPY ./favorites.sh /
CMD [ "/favorites.sh" ]
