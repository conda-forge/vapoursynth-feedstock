set -ex

if [[ "$target_platform" == "osx-arm64" ]]
then
  # Patch Cython such that it can be executed using Python
  old_cy="$BUILD_PREFIX/bin/cython"
  bak_cy="$BUILD_PREFIX/bin/cython_bak"
  echo "\"$BUILD_PREFIX/bin/python-$PY_VER\" \"$bak_cy\" \"\$@\"" > "$old_cy"
  chmod +x "$old_cy"
fi

./autogen.sh
./configure --prefix="$PREFIX" --enable-shared --disable-static

make -j${CPU_COUNT}
make install
