#Script by: John McBride (www.johnmcbride.me)
#GitHub Username: johnmcbride (https://github.com/johnmcbride)
#PS script to automate the compression of PNG files using
#the utility PNGOut.exe by Ken Silverman. You can find
#the Kens PNGOut.exe utility at the following location
#http://advsys.net/ken/utils.htm

param(
[Parameter(Mandatory=$true)]
[string] $InputDirectory,
[Parameter(Mandatory=$true)]
[string] $OutputDirectory,
[string] $PngOutExeLocation = "C:\Users\John\Downloads\pngout.exe",
[bool] $CleanOutputDirectory = $false
)

#check for trailing backslash
if ( $OutputDirectory.substring($OutputDirectory.Length - 1, 1) -ne "\" )
{
	$OutputDirectory = $OutputDirectory + "\"
}
if ( $InputDirectory.substring($InputDirectory.Length - 1, 1) -ne "\" )
{
	$InputDirectory = $InputDirectory + "\"
}
#check the parameter $CleanOutputDirectory to see if we need to delete
#any existing files in the output directory
if ( $CleanOutputDirectory -eq $true )
{
	#deleting all PNGs from the specified output directory. Only PNGs dont touch any other files/directories
	Get-ChildItem -Path $OutputDirectory -Include *.png -Recurse | Remove-Item
}

#check for the existance of the output directory
$OutputPathExists = Test-Path $OutputDirectory

if ( $OutputPathExists -eq $false )
{
	#create the new output path since it doesnt exist
	New-Item -Path $OutputDirectory -ItemType directory
}

#Grab a list of all the png file in the specified output directory
$PngFiles = Get-ChildItem -Path $InputDirectory -Filter *.png

#process each file
foreach ( $file in $PngFiles )
{
	#Testing to see if the exact file (name) exists in the output location
	#if it does then build a new file name with _compressed appended to the filename
	$FileExistsInOutputLocation = Test-Path ($OutputDirectory + ($file).name)
	if ( $FileExistsInOutputLocation -eq $true )
	{
		#build a new filename
		$FilenameTokens = ($file.Name).split(".")
		$NewFileName = $FilenameTokens[0] + "_Compressed." + $FilenameTokens[1]
		$OutputFile =  $OutputDirectory  + $NewFileName
	}
	else
	{
		#No file exists in the output directory so lets just keep
		#the original filename
		$OutputFile = $OutputDirectory + ($file).name
	}
	#Build the PNGOut executable path with parameters to execute
	$ExecutablePNGOutCommand = ($PngOutExeLocation + " " + $file.FullName + " " + $OutputFile)
	#Run the PNGOut compression tool to process the file
	Invoke-Expression $ExecutablePNGOutCommand
}




