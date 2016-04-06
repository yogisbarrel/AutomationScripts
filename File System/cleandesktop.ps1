$name = Read-Host "Please enter the name you desire for your desktop junk folder(enter for default name)"
function Clean-Directory
{    
    [CmdletBinding()]
    Param(   
    [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true)]  
    [ValidateNotNull()]      
        [string]$Path='DesktopJunk'#,
        #[Parameter(Mandatory=$false, Position=0, ValueFromRemainingArguments=$true)]        
        #[string]$Filter='*.*'
    )
        $hPath = "$env:HOMEDRIVE\$env:HOMEPATH\Desktop"
        $pubPath = "$env:HOMEDRIVE\Users\Public\Desktop"
        $userPath = "$hPath\$Path"
        [string]$rmvShort = Read-Host "Would you like to remove shortcuts?[y/n]"
        if($rmvShort.ToUpper() -eq "Y")
        {
            $message = "Shortcuts have been removed"
            $rmvLnk = Get-ChildItem -Path $hPath -Filter "*.lnk"
            $rmvLnk += Get-ChildItem -Path $pubPath -Filter "*.lnk"
            $count = $rmvLnk | Measure-Object
            $rmvLnk | ForEach-Object -Begin {$i=0; $act="Executing...."} { 
                                $act += $_.FullName
                                $i = $i+1
                                #Remove-Item -Path $_.FullName -Confirm
                                Write-Progress -Activity "Searching files..." -CurrentOperation $act -Status "Progress:" -PercentComplete (($i/$count) * 100)
                            } -End {$message} | Remove-Item -Path $_.FullName -Confirm
        }
        else
        {

        }

        if( -Not (Test-Path $userPath))
        {
            New-Item -path $userPath -ItemType Directory | Out-Null
        }
        $message = "Operation complete."
        $f = 0
        $deskItems = Get-ChildItem -Path $hPath | where {!$_.psiscontainer}
        
        $deskItems += Get-ChildItem -Path  $pubPath | where {!$_.psiscontainer}
        $count = $deskItems.Count
        $deskItems | ForEach-Object -Begin {$i=0; $act="Executing...."} {                                 
                                $act += $_.FullName
                                $i = $i+1
                                Move-Item -Path $_.FullName -Destination $userPath
                                Write-Progress -Activity "Searching files..." -CurrentOperation $act -Status "Progress:" -PercentComplete (($i/$count) * 100)
                            } -End {$message}       
                  
}

Clean-Directory -Path $name