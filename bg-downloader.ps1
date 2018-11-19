# Anthony Williams 2018

$output_format = 'jpg'
$temp_dir_name = 'temp_bg_img'

$img_dir = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$temp_img_dir = "$img_dir\$temp_dir_name"

If (-Not (Test-Path -Path "$temp_img_dir"))
{
	New-Item -ItemType Directory -Path "$img_dir" -Name "$temp_dir_name"
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
}

Write-Host "Opening explorer to new directory with images ('$temp_img_dir')..."

Invoke-Item -Path "$temp_img_dir"
