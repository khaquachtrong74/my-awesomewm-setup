#!/bin/bash 
for d in */; do
    echo "Copying $d to ~/.config/"
    cp -r "$d" ~/.config/
done

