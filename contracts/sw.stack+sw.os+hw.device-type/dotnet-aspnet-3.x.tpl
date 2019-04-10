# Install .NET Core
ENV ASPNETCORE_VERSION {{sw.stack.data.fullVersion}}

RUN curl -SL --output aspnetcore.tar.gz "{{sw.stack.assets.bin.url}}" \
    && aspnetcore_sha512='{{sw.stack.assets.bin.checksum}}' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf aspnetcore.tar.gz -C /usr/share/dotnet ./shared/Microsoft.AspNetCore.App \
    && rm aspnetcore.tar.gz
