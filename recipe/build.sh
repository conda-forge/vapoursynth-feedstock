set -ex

if [[ "$target_platform" == osx-* ]]
then
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

if [[ "$target_platform" == "osx-arm64" ]]
then
  # Patch Cython such that it can be executed using Python
  old_cy="$BUILD_PREFIX/bin/cython"
  bak_cy="$BUILD_PREFIX/bin/cython_bak"
  mv "$old_cy" "$bak_cy"
  echo "\"$BUILD_PREFIX/bin/python$PY_VER\" \"$bak_cy\" \"\$@\"" > "$old_cy"
  chmod +x "$old_cy"
fi

mkdir -p $PREFIX/lib/vapoursynth
touch $PREFIX/lib/vapoursynth/.keep

"$PYTHON" -m pip install -vv .
