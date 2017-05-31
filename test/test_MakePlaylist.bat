@echo off
@chcp 65001

:: config
set ROOT=/accounts/1000/removable/sdcard/music
set PLAYLIST_NAME=default
set PLAYLIST_EXT=m3u
set MUSIC_EXT=mp3
set CUR=%cd%

:: delete old playlist
if exist %CUR%\*.%PLAYLIST_EXT% (
  del %CUR%\*.%PLAYLIST_EXT%
)

:: make new playlist
call :makePlaylist
exit

::::::::::::::::::::::::::::
:: function makePlaylist()
::::::::::::::::::::::::::::
:makePlaylist
for %%f in (*.%MUSIC_EXT%) do (
  echo %ROOT%/%%f>>%CUR%\%PLAYLIST_NAME%.%PLAYLIST_EXT%
)
for /D %%d in (*) do (
  cd %%d
  set PLAYLIST_NAME=%%d
  set ROOT=%ROOT%/%%d
  call :makePlaylist
  cd ..
)
exit /b
