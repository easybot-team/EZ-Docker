FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 \
    libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
    libgl1-mesa-glx libegl1-mesa libgbm1 libglapi-mesa libdrm2 \
    libxcb-glx0 libxshmfence1 libxxf86vm1 libxv1 libpci3 libxcb-dri2-0 libxcb-dri3-0 \
    \
    libwayland-client0 libwayland-cursor0 libwayland-egl1 \
    libepoxy0 \
    \
    libgtk-3-0 libatk1.0-0 libcairo2 libpango-1.0-0 libpangocairo-1.0-0 \
    \
    libnss3 libnspr4 libfontconfig1 fonts-liberation \
    fonts-noto-color-emoji \
    \
    ca-certificates xdg-utils libdbus-1-3 libappindicator3-1 \
    libasound2 libstdc++6 libc6 libgcc-s1 libgdk-pixbuf2.0-0 \
    libglib2.0-0 libexpat1 \
    \
    && rm -rf /var/lib/apt/lists/* \
    && ldconfig

WORKDIR /app

COPY . /app

RUN chmod +x /app/EasyBot \
    && chmod +x /app/EasyBot.WebUI \
    && chmod +x /app/EasyBot.WebUI.Updater

EXPOSE 5000 26990

CMD ["./EasyBot"]
