#!/bin/bash

buildpdf() {
    pdflatex --shell-escape -synctex=1 -interaction=nonstopmode -output-directory=build "$1".tex
}

bc -q <<< $(cat build.txt)+1 > build.txt

buildpdf cover
buildpdf book
