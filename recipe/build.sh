set -ex

./autogen.sh
./configure --prefix="$PREFIX" --enable-shared --disable-static

which cython #DEBUG
cat $(which cython) #DEBUG

make -j${CPU_COUNT}
make install
