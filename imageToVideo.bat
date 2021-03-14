FOR /r %%i IN (*.PNG) DO magick convert "%%i" "images/%%~ni.png"
FOR /r %%i IN (*.JPG) DO magick convert "%%i" "images/%%~ni.png"
FOR /r %%i IN (*.HEIC) DO magick convert "%%i" "images/%%~ni.png"
powershell -file "renameFiles.ps1"
cd images
ffmpeg -framerate 1/2 -i image_%%d.png -f lavfi -i aevalsrc=0 -shortest -vf scale=w=3840:h=2160:force_original_aspect_ratio=1,pad=3840:2160:(ow-iw)/2:(oh-ih)/2 pngVideoFoo.mp4
ffmpeg -i pngVideoFoo.mp4 -filter:v fps=fps=30 -y pngVideo.mp4
del pngVideoFoo.mp4
cd..
for /r %%i IN (*.mp4) DO ffmpeg -i "%%i" -vcodec h264 -acodec aac -filter:v fps=fps=30 -n "videos/%%~ni.mp4"
for /r %%i IN (*.mov) DO ffmpeg -i "%%i" -vcodec h264 -acodec aac -filter:v fps=fps=30 "videos/%%~ni.mp4"
cd images
attrib +h
cd..
powershell -file "renameFiles.ps1"
cd images
attrib -h
cd..
cd videos
dir /b /o:d > foo.txt
findstr /v "foo.txt" foo.txt > foo2.txt
del foo.txt
setLocal EnableDelayedExpansion
for /f "tokens=* delims= " %%a in (foo2.txt) do (echo file '%%a'>> videoList.txt)
del foo2.txt
cd..
ffmpeg -f concat -i videos/videoList.txt -c copy final/video.mp4
del videos/videoList