# Install .NET Core
ENV DOTNET_VERSION {{sw.stack.assets.runtime.fullVersion}}

RUN curl -SL --output dotnet.tar.gz "{{sw.stack.assets.runtime.bin.url}}" \
    && dotnet_sha512='{{sw.stack.assets.runtime.bin.checksum}}' \
    && echo "$dotnet_sha512  dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

ENV ASPNETCORE_VERSION {{sw.stack.data.fullVersion}}

RUN curl -SL --output aspnetcore.tar.gz "{{sw.stack.assets.bin.url}}" \
    && aspnetcore_sha512='{{sw.stack.assets.bin.checksum}}' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf aspnetcore.tar.gz -C /usr/share/dotnet ./shared/Microsoft.AspNetCore.App \
    && rm aspnetcore.tar.gz
