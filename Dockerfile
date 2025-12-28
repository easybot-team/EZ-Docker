FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim

WORKDIR /app

COPY . /app

RUN chmod +x /app/EasyBot \
    && chmod +x /app/EasyBot.WebUI \
    && chmod +x /app/EasyBot.WebUI.Updater

EXPOSE 5000 26990

CMD ["./EasyBot"]
