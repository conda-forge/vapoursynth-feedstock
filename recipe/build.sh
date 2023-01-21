set -ex

# Patch Cython such that it can be executed using Python
mv "
$BUILD_PREFIX/bin/python

./autogen.sh
./configure --prefix="$PREFIX" --enable-shared --disable-static

which cython #DEBUG
ls -l $(which cython) #DEBUG
ls -l "$BUILD_PREFIX/bin" #DEBUG

make -j${CPU_COUNT}
make install
