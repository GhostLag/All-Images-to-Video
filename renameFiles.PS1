cd images
ls | %{Rename-Item $_ -NewName ("image_{0}.png" -f $a++)}
cd..
cd videos
ls | %{Rename-Item $_ -NewName ("video_{0}.mp4" -f $b++)}

#D:
#cd D:\Photos\BatchTest\videos
#ls | %{Rename-Item $_ -NewName ("video_{0}.mp4" -f $nr++)}