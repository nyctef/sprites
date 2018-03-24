param($pathToAseprite)

if (!$pathToAseprite) {
  $pathToAseprite = $env:ASEPRITE_PATH
}

if (!$pathToAseprite) {
  throw "`$pathToAseprite or `$env:ASEPRITE_PATH is required"
}

get-childitem -dir $PSScriptRoot | foreach {
  try {
    push-location $_.fullname
    write-host "building in $_"

    get-childitem *.aseprite | foreach {
      $name = $_.basename
      & $pathToAseprite -b $_ --data "$name.json" --format json-array --list-layers --list-tags --list-slices --sheet "$name.png"
      & $pathToAseprite -b $_ --scale 6 --save-as "$name.gif"
    }
  }
  finally {
    pop-location
  }
}