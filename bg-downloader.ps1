# Anthony Williams 2018
# With tips from https://code.adonline.id.au/script-to-list-image-files-by-size-and-resolution-export-to-excel/

Add-Type -AssemblyName System.Drawing

$output_format = 'jpg'
$temp_dir_name = 'temp_bg_img'

$img_data_dir = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$temp_dir = "$img_data_dir\$temp_dir_name"
$landscape_dir = "$temp_dir\landscape"
$portrait_dir = "$temp_dir\portrait"

If ((Test-Path -Path "$temp_dir") -Eq $False)
{
	New-Item -ItemType Directory -Path "$img_data_dir" -Name "$temp_dir_name"
}
If ((Test-Path -Path "$landscape_dir") -Eq $False)
{
	Write-Host "Could not find LANDSCAPE directory at '$landscape_dir', creating..."
	New-Item -ItemType Directory -Path "$temp_dir" -Name 'landscape'
}
If ((Test-Path -Path "$portrait_dir") -Eq $False)
{
	Write-Host "Could not find PORTRAIT directory at '$portrait_dir', creating..."
	New-Item -ItemType Directory -Path "$temp_dir" -Name 'portrait'
}

$images = Get-ChildItem -Path "$img_data_dir" -File

ForEach($image in $images)
{
	$imageDataFile = $image.FullName
	$filenameWithExt = $image.Name

	If ($image.Extension -Ne ".$output_format")
	{
		$filenameWithExt = $filenameWithExt + ".$output_format"
	}

	$tempLocation = "$temp_dir\$filenameWithExt"

	Copy-Item -LiteralPath "$imageDataFile" -Destination "$tempLocation"
	$jpg = [System.Drawing.Image]::FromFile($tempLocation)

	# NOTE: this is landscape
	If ($jpg.Height -eq 1080 -and $jpg.Width -eq 1920)
	{
		Write-Host "[MOVE-TO-LAND] tempLocation='$tempLocation' landscape_dir='$landscape_dir'"
		Move-Item -LiteralPath "$imageDataFile" -Destination "$landscape_dir\$filenameWithExt"
	}
	# NOTE: this is portrait
	ElseIf ($jpg.Height -eq 1920 -and $jpg.Width -eq 1080)
	{
		Write-Host "[MOVE-TO-PORT] tempLocation='$tempLocation' portrait_dir='$portrait_dir'"
		Move-Item -LiteralPath "$imageDataFile" -Destination "$portrait_dir\$filenameWithExt"
	}
}

# TODO: ajw - Dec 26, 2018; make sure the following command works
Remove-Item * -Include "*.$output_format" -Force

Write-Host "Opening explorer to new directory with images ('$temp_dir')..."

Invoke-Item -Path "$temp_dir"
