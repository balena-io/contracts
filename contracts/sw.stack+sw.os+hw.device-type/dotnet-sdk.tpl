# Install .NET Core SDK
ENV DOTNET_SDK_VERSION {{sw.stack.data.fullVersion}}

RUN curl -SL --output dotnet.tar.gz "{{sw.stack.assets.bin.url}}" \
    && dotnet_sha512='{{sw.stack.assets.bin.checksum}}' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Enable correct mode for dotnet watch (only mode supported in a container)
ENV DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps performance
    NUGET_XMLDOC_MODE=skip \
    DOTNET_NOLOGO=true

# Trigger first run experience by running arbitrary cmd to populate local package cache
RUN dotnet help
