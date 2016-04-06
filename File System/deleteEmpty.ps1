#[reflection.assembly]::loadwithpartialname("System") | Out-Null
[reflection.assembly]::loadwithpartialname("Microsoft.VisualBasic") | Out-Null
$temp=""
$defaultLocation = (Get-Location -).Path
$delete = $null
$parent = $null
$fls = @()
function Delete-EmptyFolders{
    Param(        
        [string]$Directory="",        
        [string]$Exclude=""
        )
        #$i = 0
        $message = "All empty folders have been deleted."
                
        
        if(($Exclude -eq "") -and ($Directory -eq ""))
        {          
            $delete = (gci -recurse | Where {$_.psiscontainer} | ? {$_.GetDirectories().Count -eq 0} | ? {$_.GetFiles().Count -eq 0}).FullName
            #$parent = gci | Where {$_.psiscontainer} | ? {$_.GetDirectories().Count -eq 0} | ? {$_.GetFiles().Count -eq 0}
            $c = $delete.Count
            $delete | Foreach-Object -Begin {$i=0; $act="Deleting...."} { 
                                $File = $_
                                #Write-Output $stream
                                getname($File)
                                $act += $temp
                                $i = $i+1
                                Write-Progress -Activity "Searching files..." -CurrentOperation $act -Status "Progress:" -PercentComplete (($i/$c) * 100)
                            } -End {$message}
             
                       
            #$delete | ForEach-Object -Begin {$i=0; $n=$_.ToString(); $act="Empty Folders: "; $temp=""} -Process {getname($n); $act+=$temp;$i=$i+1; Write-Progress -Activity $act -Status "Progress:" -PercentComplete ($i/$c)} -End {$message}
        }
        if($Exclude -eq $null)
        {
#            $delete = gci -Path $Directory | Where-Object {$_.psiscontainer, $_.Length.Equals(0) -eq $true}
            
#            Foreach ($name in $delete){
#                $info = gci -Path $name.FullName | Measure-Object
#                if($info.Count.Equals(0) -eq $true)
#                {
#                    Remove-Item -Path $name.FullName
#                    $temp = $name.FullName + "has been removed"
#                    $temp | Out-Host
#                }          
#            }
        }
        else
        {
#            $delete = gci -Path $Directory -Exclude $Exclude | Where-Object {$_.psiscontainer, $_.Length.Equals(0) -eq $true}
        
#            Foreach ($name in $delete){
#                $info = gci -Path $name.FullName | Measure-Object
#                if($info.Count.Equals(0) -eq $true)
#                {
#                    Remove-Item -Path $name.FullName
#                    $temp = $name.FullName + " has been removed"
#                    $temp | Out-Host
#                }          
#            }
            
        }        
    
}

function getname{

    Param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [ValidateLength(1, 60)]
        [string]$Name
        )
        Remove-Item -Path $Name 
        $temp = $Name + " has been removed" 
}
function buildarray{
    Param( 
        [string]$location
        )
        $delete = (gci -recurse | Where {$_.psiscontainer} | ? {$_.GetDirectories().Count -eq 0} | ? {$_.GetFiles().Count -eq 0}).FullName
        [Microsoft.VisualBasic]
}