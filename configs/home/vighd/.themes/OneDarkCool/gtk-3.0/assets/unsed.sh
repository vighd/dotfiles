#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#242b38/g' \
         -e 's/rgb(100%,100%,100%)/#abb2bf/g' \
    -e 's/rgb(50%,0%,0%)/#242b38/g' \
     -e 's/rgb(0%,50%,0%)/#bf68d9/g' \
 -e 's/rgb(0%,50.196078%,0%)/#bf68d9/g' \
     -e 's/rgb(50%,0%,50%)/#425b80/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#425b80/g' \
     -e 's/rgb(0%,0%,50%)/#abb2bf/g' \
	"$@"
