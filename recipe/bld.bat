cd msvc_project
mkdir build
cd build

set VSPYTHON_PATH=%PREFIX%
MSBuild.exe ../../libp2p/_msvc/libp2p_simd/libp2p_simd.vcxproj /p:configuration=release /p:platform=x64 /p:PlatformToolset=v142 /maxCpuCount:%CPU_COUNT% /p:SolutionDir=%cd%\
if %ERRORLEVEL% neq 0 exit 1
MSBuild.exe ../Core/Core.vcxproj /p:configuration=release /p:platform=x64 /p:PlatformToolset=v142 /maxCpuCount:%CPU_COUNT% /p:SolutionDir=%cd%\
if %ERRORLEVEL% neq 0 exit 1
MSBuild.exe ../VSScript/VSScript.vcxproj /p:configuration=release /p:platform=x64 /p:PlatformToolset=v142 /maxCpuCount:%CPU_COUNT% /p:SolutionDir=%cd%\
if %ERRORLEVEL% neq 0 exit 1
MSBuild.exe ../VSPipe/VSPipe.vcxproj /p:configuration=release /p:platform=x64 /p:PlatformToolset=v142 /maxCpuCount:%CPU_COUNT% /p:SolutionDir=%cd%\
if %ERRORLEVEL% neq 0 exit 1
MSBuild.exe ../AvsCompat/AvsCompat.vcxproj /p:configuration=release /p:platform=x64 /p:PlatformToolset=v142 /maxCpuCount:%CPU_COUNT% /p:SolutionDir=%cd%\
if %ERRORLEVEL% neq 0 exit 1
MSBuild.exe ../AVFS/AVFS.vcxproj /p:configuration=release /p:platform=x64 /p:PlatformToolset=v142 /maxCpuCount:%CPU_COUNT% /p:SolutionDir=%cd%\
if %ERRORLEVEL% neq 0 exit 1
MSBuild.exe ../VSVFW/VSVFW.vcxproj /p:configuration=release /p:platform=x64 /p:PlatformToolset=v142 /maxCpuCount:%CPU_COUNT% /p:SolutionDir=%cd%\
if %ERRORLEVEL% neq 0 exit 1

cd x64/release

copy VapourSynth.dll %PREFIX%\VapourSynth.dll
copy VSScript.dll %PREFIX%\VSScript.dll
copy VSPipe.exe %PREFIX%\VSPipe.exe
copy AVFS.exe %PREFIX%\AVFS.exe
mkdir %PREFIX%\vapoursynth64\coreplugins
copy AvsCompat.dll %PREFIX%\vapoursynth64\coreplugins\AvsCompat.dll
copy VSVFW.dll %PREFIX%\VSVFW.dll
mkdir %PREFIX%\vapoursynth64\plugins
cd. > %PREFIX%\portable.vs
cd. > %PREFIX%\vapoursynth64\plugins\.keep

mkdir %LIBRARY_LIB%
copy VapourSynth.lib %LIBRARY_LIB%\VapourSynth.lib
copy VSScript.lib %LIBRARY_LIB%\VSScript.lib

cd ..\..\..\..

mkdir %LIBRARY_INC%
xcopy /E /F /I /Y include %LIBRARY_INC%\vapoursynth

mkdir %LIBRARY_LIB%\pkgconfig

(
echo prefix=%PREFIX%/Library
echo exec_prefix=${prefix}
echo libdir=${exec_prefix}/lib
echo includedir=${prefix}/include/vapoursynth
echo,
echo Name: vapoursynth
echo Description: A frameserver for the 21st century
echo Version: %PKG_VERSION%
echo,
echo Libs: -L${libdir} -lVapourSynth
echo Cflags: -I${includedir}
)>%LIBRARY_LIB%\pkgconfig\vapoursynth.pc

(
echo prefix=%PREFIX%/Library
echo exec_prefix=${prefix}
echo libdir=${exec_prefix}/lib
echo includedir=${prefix}/include/vapoursynth
echo,
echo Name: vapoursynth-script
echo Description: Library for interfacing VapourSynth with Python
echo Version: %PKG_VERSION%
echo,
echo Requires: vapoursynth
echo Libs: -L${libdir} -lVSScript
echo Cflags: -I${includedir}
)>%LIBRARY_LIB%\pkgconfig\vapoursynth-script.pc

"%PYTHON%" -m pip install -vv .
if %ERRORLEVEL% neq 0 exit 1
