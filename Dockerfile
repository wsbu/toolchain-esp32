FROM wsbu/toolchain-native:v0.3.0

ENV TOOLCHAIN_ARCHIVE_NAME="xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz" \
    IDF_PATH="/opt/esp-idf"

RUN apt-get update && apt-get install --yes --no-install-recommends \
    libncurses-dev \
    flex \
    bison \
    gperf \
  && wget --quiet "https://dl.espressif.com/dl/${TOOLCHAIN_ARCHIVE_NAME}" -O - | tar xz --strip 1 -C /usr/local \
  && git clone --recursive -b v3.1.1 "https://github.com/espressif/esp-idf.git" "${IDF_PATH}" \
  && pip --no-cache-dir install -r "${IDF_PATH}/requirements.txt" \
