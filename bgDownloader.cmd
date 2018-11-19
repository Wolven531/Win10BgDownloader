:: Anthony Williams 2018

@ECHO OFF

SET img_dir=%userprofile%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets

ECHO Opening explorer to directory with images ("%img_dir%")...
explorer.exe %img_dir%

@ECHO ON
