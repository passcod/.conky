#!/usr/bin/bash

cd "$1"
echo "$1"
echo -n "├ "; git status -sb | head -n1
echo -n "└ "; git log --pretty=format:"%h (%an) %s" | head -n1 | fold -sw 40
echo
