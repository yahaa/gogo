#!/usr/bin/env bash

# adjust GOPATH
case ":$GOPATH:" in
    *":$(pwd):"*) :;;
    *) GOPATH=$(pwd):$GOPATH;;
esac
export GOPATH


# adjust PATH
readopts="-ra"
if [ -n "$ZSH_VERSION" ]; then
    readopts="-rA";
fi
while IFS=':' read $readopts ARR; do
    for i in "${ARR[@]}"; do
        case ":$PATH:" in
            *":$i/bin:"*) :;;
            *) PATH=$i/bin:$PATH
        esac
    done
done <<< "$GOPATH"
export PATH


# mock development && test envs
if [ ! -d "$(pwd)/src/github.com/skeleton" ];
then
    mkdir -p "$(pwd)/src/github.com"
    ln -s "$(pwd)/gogo/" "$(pwd)/src/github.com/skeleton"
fi
