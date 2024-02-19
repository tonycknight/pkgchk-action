param(
    [Parameter(Mandatory=$true)]
    [string]$tag
)

$ErrorActionPreference = "stop"

& git tag $tag
& git push origin $tag

