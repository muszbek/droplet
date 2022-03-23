FROM bitwalker/alpine-elixir-phoenix:1.13.1

RUN apk --no-cache --update add \
	postgresql-client && \
    rm -rf /var/cache/apk/*

COPY . /opt/app

RUN mix deps.get && \
    MIX_ENV=prod mix deps.compile

RUN cd assets/ && \
    cd - && \
    MIX_ENV=prod mix phx.digest

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./launcher.sh"]
