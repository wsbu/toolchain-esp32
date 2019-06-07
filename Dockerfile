FROM wsbu/toolchain-native:v0.3.4

ENV TOOLCHAIN_ARCHIVE_NAME="xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz"

COPY conan/esp32_profile "${HOME}/.conan/profiles/esp32"

RUN apt-get update && sudo apt-get install --yes --no-install-recommends \
    libncurses-dev \
    flex \
    bison \
    gperf \
    python-pip

RUN pip2 --no-cache-dir install \
    pyserial>=3.0 \
    pyparsing>=2.0.3 \
  && wget --quiet "https://dl.espressif.com/dl/${TOOLCHAIN_ARCHIVE_NAME}" -O - | tar xz --strip 1 -C /usr/local \
  && ln -sf "${HOME}/.conan/profiles/esp32" "${HOME}/.conan/profiles/default" \
  && sed -i 's/armv7k]/armv7k, esp32]/' "${HOME}/.conan/settings.yml" \
  && usermod -a -G dialout captain
