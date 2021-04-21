# Download dependencies

OPENSSL_VERSION="master"
ZLIB_VERSION="master"
PREFIX=`pwd`

OPENSSL_DIRECTORY="OpenSSL-${OPENSSL_VERSION}"
ZLIB_DIRECTORY="zlib-${ZLIB_VERSION}"


if [ ! -d "$OPENSSL_DIRECTORY" ]; then
  echo "Download curl source code"
  wget -O OpenSSL-master.tar.gz https://github.com/wapm-packages/OpenSSL/archive/refs/heads/${OPENSSL_VERSION}.tar.gz
  tar xf OpenSSL-master.tar.gz
fi

if [ ! -d "$ZLIB_DIRECTORY" ]; then
  echo "Download curl source code"
  wget -O zlib-master.tar.gz https://github.com/wapm-packages/zlib/archive/refs/heads/${ZLIB_VERSION}.tar.gz
  tar xf zlib-master.tar.gz
fi


# Configure
BUILD_DIR=`pwd`/wasix
mkdir -p $BUILD_DIR

# CONFIG_SITE=./config.site READELF=true wasix-configure ./configure --build=wasm32-unknown-wasi --without-pymalloc --disable-shared --disable-ipv6 --without-gcc --prefix=$BUILD_DIR
CONFIG_SITE=./config.site READELF=true wasix-configure ./configure --build=wasm32-wasi --host=wasm32-wasi --without-pymalloc --disable-shared --disable-ipv6 --without-gcc --prefix=$BUILD_DIR

# Have to go to pyconfig.h and remove HAVE_FORK

wasix-make make -j CROSS_COMPILE=yes
