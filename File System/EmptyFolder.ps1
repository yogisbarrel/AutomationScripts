function Empty-Folder
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [ValidateLength(1, 60)]
        [string]$Source    
    )
    $empty = gci $Source | where {$psiscontainer} | select
}