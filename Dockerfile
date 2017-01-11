FROM msaraiva/elixir-dev:1.3.4

MAINTAINER Josh Williams <vmizzle@gmail.com>

RUN apk --update add \
		bash \
		mysql-client && \
	rm -rf /var/cache/apk/* && \
	mix local.hex --force

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY mix.exs /usr/src/app
COPY mix.lock /usr/src/app

RUN yes | mix deps.get

RUN mix deps.compile

COPY . /usr/src/app

ENV RELX_REPLACE_OS_VARS true
ENV PORT 4000
EXPOSE 4000

CMD ["mix", "honcho_api.server"]
