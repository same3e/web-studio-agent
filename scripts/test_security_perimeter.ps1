$ErrorActionPreference='Stop';. (Join-Path $PSScriptRoot 'security/Test-AuthorizedPath.ps1')
$root=Join-Path ([IO.Path]::GetTempPath()) ('perimeter-'+[guid]::NewGuid());New-Item -ItemType Directory -Path $root|Out-Null
try{
 if(-not(Test-AuthorizedPath $root 'safe/output.json').valid){throw 'safe relative path rejected'}
 foreach($bad in @('C:\evil','C:evil','../evil','NUL','file.txt:stream','**/*.ps1')){if((Test-AuthorizedPath $root $bad -AllowGlob).valid){throw "unsafe path accepted: $bad"}}
 if(-not(Test-AuthorizedPath $root 'src/*.ps1' -AllowGlob).valid){throw 'bounded glob rejected'}
 $link=Join-Path $root 'linked';$outside=Join-Path ([IO.Path]::GetTempPath()) ('outside-'+[guid]::NewGuid());New-Item -ItemType Directory -Path $outside|Out-Null
 try{New-Item -ItemType SymbolicLink -Path $link -Target $outside -ErrorAction Stop|Out-Null;if((Test-AuthorizedPath $root 'linked/future.txt').valid){throw 'physical link escape accepted'}}catch [System.UnauthorizedAccessException]{Write-Host 'physical-link case skipped: symlink privilege unavailable'}finally{Remove-Item $outside -Recurse -Force -ErrorAction SilentlyContinue}
}finally{Remove-Item $root -Recurse -Force -ErrorAction SilentlyContinue}
Write-Host 'Security perimeter tests passed.'
