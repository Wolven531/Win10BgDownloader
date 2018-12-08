# Anthony Williams 2018
# With tips from https://code.adonline.id.au/script-to-list-image-files-by-size-and-resolution-export-to-excel/

Add-Type -AssemblyName System.Drawing

$output_format = 'jpg'
$temp_dir_name = 'temp_bg_img'

$img_dir = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$temp_img_dir = "$img_dir\$temp_dir_name"
$landscape_dir = "$temp_img_dir\landscape"
$portrait_dir = "$temp_img_dir\portrait"

If ((Test-Path -Path "$temp_img_dir") -Eq $False)
{
	New-Item -ItemType Directory -Path "$img_dir" -Name "$temp_dir_name"
}
If ((Test-Path -Path "$landscape_dir") -Eq $False)
{
	Write-Host "Could not find LANDSCAPE directory at '$landscape_dir', creating..."
	New-Item -ItemType Directory -Path "$temp_img_dir" -Name 'landscape'
}
If ((Test-Path -Path "$portrait_dir") -Eq $False)
{
	Write-Host "Could not find PORTRAIT directory at '$portrait_dir', creating..."
	New-Item -ItemType Directory -Path "$temp_img_dir" -Name 'portrait'
}

$images = Get-ChildItem -Path "$img_dir" -File

ForEach($image in $images)
{
	$currentLocation = $image.FullName
	$newImageName = $image.Name

	If (-Not ($image.Extension -Eq ".$output_format"))
	{
		$newImageName = $newImageName + ".$output_format"
	}

	Write-Host "Copying file '$newImageName'..."
	Copy-Item -LiteralPath "$currentLocation" -Destination "$temp_img_dir\$newImageName"
	$newLocation = "$temp_img_dir\$newImageName"
	$jpgImage = [System.Drawing.Image]::FromFile($newLocation)

	# NOTE: this is landscape
	If ($jpgImage.Height -eq 1080 -and $jpgImage.Width -eq 1920)
	{
		Write-Host "Moving file '$newImageName' to landscape..."
		Move-Item -LiteralPath $newLocation -Destination $landscape_dir
	}
	# NOTE: this is portrait
	ElseIf ($jpgImage.Height -eq 1920 -and $jpgImage.Width -eq 1080)
	{
		Write-Host "Moving file '$newImageName' to portrait..."
		Move-Item -LiteralPath $newLocation -Destination $portrait_dir
	}
}

Write-Host "Opening explorer to new directory with images ('$temp_img_dir')..."

Invoke-Item -Path "$temp_img_dir"
