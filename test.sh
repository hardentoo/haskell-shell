#!/bin/bash

EXE1='bash --norc --noediting -i'
EXE2='./sh'
DIFF='diff -U3'

set -e

ghc --make sh.hs

for t in tests/[0-9]*
do
    echo Running test case $t
    PS1='$ ' $EXE1 < $t > tests/output.1 2>&1
    $EXE2 < $t | sed -e 's/sh.hs/bash/' > tests/output.2
    $DIFF tests/output.1 tests/output.2
done
