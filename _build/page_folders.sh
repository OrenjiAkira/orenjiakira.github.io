#!/usr/local/bin/bash

prefix="_source/pages/"
sufix=".src"

function recur {
  for file in $@; do
    if [[ -d "$file" ]]; then
      if [[ "$file" == *"assets"* ]]; then
        for img in $file"/*"; do
          cp $img site/assets/
        done
      fi
      recur $file"/*"
    fi
    if [[ $file != *$sufix ]]; then continue; fi

    rel_path=${file#$prefix}
    rel_path=${rel_path%$sufix}
    dirname="site/"$rel_path
    dirname=${dirname%index}

    echo "SOURCE: $file"
    echo "RELATIVE PATH: $rel_path"
    echo "TARGET DIR: $dirname"$'\n'

    mkdir -pv $dirname;
  done
}

echo $'\n'"Making target directories recursively..."$'\n'
recur $prefix"*"
