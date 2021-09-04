$Prefix = 'Url part to .m3u8 file'

$ProgressPreference = 'Continue'
$Url = 'Url part to seed'
Invoke-WebRequest -Uri $Url -OutFile playlist.m3u8

$playlist2 = Get-Content -Path playlist2.m3u8


$playlist2 | % {
    if($PSItem -notmatch '^#'){
        $SegmentUri = $Prefix + $PSItem
        Write-Host -Object ($SegmentUri)
        $SegmenlstFileName = $SegmentUri.Split('/')[-1]

        Invoke-WebRequest -Uri $SegmentUri -OutFile $SegmenlstFileName 
        #Add-Content -Path filelist.txt -Value ('file ''{0}''' -f $SegmenlstFileName)
    }
}

#scoop install ffmpeg
ffmpeg -f concat -safe 0 -i filelist.txt -c copy output.mp4
