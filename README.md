# Win10BgDownloader

## Purpose

This project aims to create a script that can be used to simply collect the Windows 10 Login screen backgrounds in a directory of the user's choosing

## Running the CMD script

### What it does

This script will perform the following steps

1. Navigate to target directory (Windows 10 stores login background image data at `%userprofile%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets`)
1. Create a temporary directory (`temp_bg_img`)
1. Copy the image data into the temporary directory as JPG images
1. Open a Windows file explorer window to the newly populated directory

### Instructions

From the project directory, run `bgDownloader.cmd`

```cmd
bgDownloader.cmd
```

#### NOTES

* The script will prompt to overwrite a file if necessary (user has a choice to replace file or not)
