FROM mcr.microsoft.com/dotnet/nightly/aspnet:6.0
WORKDIR /publish
COPY ./app /publish
ENTRYPOINT ["dotnet", "RunGroopWebApp.dll"]