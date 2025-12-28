# build stage: 使用 SDK 编译并发布
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 复制项目（根据你的仓库结构调整路径）
COPY . .

# 恢复并发布（调整项目路径到你的 EasyBot.WebUI csproj）
RUN dotnet restore "EasyBot.WebUI/EasyBot.WebUI.csproj"
RUN dotnet publish "EasyBot.WebUI/EasyBot.WebUI.csproj" -c Release -o /app/publish

# runtime stage: 使用包含 ASP.NET 运行时的镜像 (bookworm = Debian 12)
FROM mcr.microsoft.com/dotnet/aspnet:8.0-bookworm-slim AS runtime
WORKDIR /app

# 拷贝已发布的输出
COPY --from=build /app/publish .

EXPOSE 80
ENTRYPOINT ["dotnet", "EasyBot.WebUI.dll"]
