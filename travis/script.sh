#!/bin/sh

export PATH="`pwd`/bin:$PATH"
echo "PATH: $PATH"

rake ci
