FROM debian:stable-slim

WORKDIR /app

COPY . /app

RUN chmod +x /app/EasyBot \
    && chmod +x /app/EasyBot.WebUI \
    && chmod +x /app/EasyBot.WebUI.Updater

CMD ["./EasyBot"]
