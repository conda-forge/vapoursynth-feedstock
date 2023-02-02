cl /LD /MD /I%PREFIX%\Library\include\vapoursynth crash-plugin.c
if %ERRORLEVEL% neq 0 exit 1

copy crash-plugin.dll %PREFIX%\vapoursynth64\plugins\crash-plugin.dll
python -c "from vapoursynth import core; dir(core)"
if %ERRORLEVEL% neq 3 exit 1

call;
