FROM debian:bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
       bzip2 \
       curl \
       git \
       git-lfs \
       jq \
       yq \
       libgl1 \
       make \
       lsb-release \
       patch \
       python3 \
       python3-ruamel.yaml \
       unzip \
       xz-utils \
       ca-certificates \
       libglib2.0-0

# https://jdk.java.net/archive/
RUN \
    curl -O https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz \
    && tar -C /opt -xf openjdk-21.0.2_linux-x64_bin.tar.gz \
    && rm openjdk-21.0.2_linux-x64_bin.tar.gz

ENV JAVA_HOME="/opt/jdk-21.0.2"
ENV PATH="$PATH:$JAVA_HOME/bin"

# Install Simplicity Commander (unfortunately no stable URL available, this
# is known to be working with Commander_linux_x86_64_1v15p0b1306.tar.bz).
RUN \
    curl -O https://www.silabs.com/documents/login/software/SimplicityCommander-Linux.zip \
    && unzip -q SimplicityCommander-Linux.zip \
    && tar -C /opt -xjf SimplicityCommander-Linux/Commander_linux_x86_64_*.tar.bz \
    && rm -r SimplicityCommander-Linux \
    && rm SimplicityCommander-Linux.zip

ENV PATH="$PATH:/opt/commander"

# Install Silicon Labs Configurator (slc)
RUN \
    curl -O https://www.silabs.com/documents/login/software/slc_cli_linux.zip \
    && unzip -q -d /opt slc_cli_linux.zip \
    && rm slc_cli_linux.zip

ENV PATH="$PATH:/opt/slc_cli"

# GCC Embedded Toolchain 12.2.rel1 (for Simplicity SDK)
RUN \
    curl -O https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/12.2.rel1/binrel/arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi.tar.xz \
    && tar -C /opt -xf arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi.tar.xz \
    && rm arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi.tar.xz

# Simplicity SDK 2025.6.1
RUN \
    curl -o simplicity_sdk_2025.6.1.zip -L https://github.com/SiliconLabs/simplicity_sdk/releases/download/v2025.6.2/simplicity-sdk.zip \
    && unzip -UU -q -d simplicity_sdk_2025.6.1 simplicity_sdk_2025.6.2.zip \
    && rm simplicity_sdk_2025.6.2.zip

# ZCL Advanced Platform (ZAP) v2025.07.24
RUN \
    curl -o zap_2025.07.24.zip -L https://github.com/project-chip/zap/releases/download/v2025.07.24/zap-linux-x64.zip \
    && unzip -q -d /opt/zap zap_2025.07.24.zip \
    && rm zap_2025.07.24.zip
ENV STUDIO_ADAPTER_PACK_PATH="/opt/zap"

ARG USERNAME=builder
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

USER $USERNAME
WORKDIR /build
