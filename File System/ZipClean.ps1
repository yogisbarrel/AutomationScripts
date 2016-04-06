$temp = $args[0]
$zip = Get-ChildItem -Path $temp -Filter *.zip | Select-Object FullName
#[string]$confirm = Read-Host "Would you like to view the archives that are to be removed?[y/n] " 
#$confirm = $confirm.ToUpper()
$tf = $false
Do
{
    [string]$confirm = Read-Host "Would you like to view the archives that are to be removed?[y/n]: "
    #$confirm = $confirm.ToUpper()
    if($confirm.ToUpper() -eq 'Y')
    {
        $zip | ForEach-Object -Process {Remove-Item -Path $_.FullName -Confirm}
        $tf = $true
    }
    elseif ($confirm.ToUpper() -eq 'N')
    {
        $zip | ForEach-Object -Process {Remove-Item -Path $_.FullName}
        $tf = $true
    }
    else
    {
        [System.Windows.Forms.MessageBox]::Show("Please enter 'y' for yes or 'n' for no(not case sensitive)")
    }
} While($tf -eq $false)

#Get-ChildItem -Path $temp -Filter *.zip | Select-Object FullName | ForEach-Object -Process {Remove-Item -Path $_.FullName -Confirm}

