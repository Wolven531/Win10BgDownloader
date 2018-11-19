:: Anthony Williams 2018

@ECHO OFF

SET output_format=jpg
SET temp_dir_name=temp_bg_img

SET img_dir=%userprofile%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets
SET temp_img_dir=%img_dir%\%temp_dir_name%
SET temp_img_pattern=%temp_img_dir%\*.%output_format%

CD "%img_dir%"
MKDIR "%temp_img_dir%"
COPY /n /-y "%img_dir%" "%temp_img_pattern%"

ECHO Opening explorer to new directory with images ("%temp_img_dir%")...

explorer.exe %temp_img_dir%

@ECHO ON
