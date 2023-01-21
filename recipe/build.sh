set -ex

./autogen.sh
./configure --prefix="$PREFIX" --enable-shared --disable-static

which cython #DEBUG
ls -l $(which cython) #DEBUG
ls -l "$BUILD_PREFIX/bin" #DEBUG

make -j${CPU_COUNT}
make install
