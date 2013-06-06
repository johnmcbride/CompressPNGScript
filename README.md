##Compress PNG Script - A script to automate PNG Compression
=================

### What's it?

This is a powershell script that wraps the usage of the the PNGOut.exe utility by Ken Silverman. It allows you to enter a Input and Output directory and have the script bulk run the utility to compress all PNG image files in the input directory.

### How do I use it?
There are four parameters you can use when executing this script. They are

* InputDirectory
* OutputDirectory
* PngOutExeLocation
* CleanOutputDirectory


#####InputDirectory 
Madatory: Yes  
Description: This parameter should be used to specify where the source PNG files are located that you wish to process

#####OutputDirectory 
Madatory: Yes  
Description: This parameter should be used to specify where newly compressed files should be saved when completed.

#####PngOutExeLocation 
Madatory: No
Default Value: C:\Downloads\pngout.exe
Description: If used, this parameter should be the fully qualified path to the pngout.exe file. By default it will look in the c:\downloads\ directory (as specified by the default value).
Notes: You should change this parameters default value in the script to be consistent with your environment.

#####CleanOutputDirectory 
Madatory: No
Default Value: $false
Description: If used, this parameter will delete any existing PNGs located in the OutputDirectory


###Example (Base)
CompressPNGs.ps1  -InputDirectory C:\png\ -OutputDirectory c:\png\compressed
###Example (Delete existing output directory)
CompressPNGs.ps1  -InputDirectory C:\png\ -OutputDirectory c:\png\compressed -CleanOutputDirectory $true
###Example (Specify the location of PNGOut.exe)
CompressPNGs.ps1  -InputDirectory C:\png\ -OutputDirectory c:\png\compressed -PngOutExeLocation c:\myfiles\pngout.exe



````
