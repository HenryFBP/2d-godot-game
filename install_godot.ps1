ECHO "Run me as admin for maximum goodness."

if (-Not(Get-Command scoop -errorAction SilentlyContinue)) #scoop not installed
{
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
}

scoop bucket add extras
scoop install godot

PAUSE