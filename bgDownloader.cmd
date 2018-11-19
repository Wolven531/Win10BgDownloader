:: Anthony Williams 2018

@ECHO OFF

SET img_dir=%userprofile%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets
SET temp_img_dir=%img_dir%\temp_bg_img

CD "%img_dir%"
MKDIR "%temp_img_dir%"
COPY /n /-y "%img_dir%" "%temp_img_dir%\*.jpg"

ECHO Opening explorer to new directory with images ("%temp_img_dir%")...
explorer.exe %temp_img_dir%

@ECHO ON
