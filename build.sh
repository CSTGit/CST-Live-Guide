#!/bin/bash

build_count() {
    bc -q <<< $(cat build.txt)+1 > build.txt
}

makepdf() {
    mkdir build$1
    pdflatex --shell-escape -synctex=1 -interaction=nonstopmode -output-directory=build${1%/} ."$1"/"$2".tex
}

makemd() {
    mkdir build$1
    pandoc -t latex -o build${1%/}/"$2".pdf ."$1"/"$2".md 
}

makepreamble() {
    mkdir build
    echo "\documentclass[12pt, a4paper]{book}" >  build/book.tex
    echo                                       >> build/book.tex
    echo "\usepackage{pdfpages}"               >> build/book.tex
    echo                                       >> build/book.tex
    echo "\begin{document}"                    >> build/book.tex
}

makefinal() {
    echo "\end{document}"                      >> build/book.tex
    makepdf /build book
    cp build/build/book.pdf build/book.pdf
}

includepdf() {
    # TODO: make TableOfContents
    makepdf /"${1%/}" "$2"
    echo "\includepdf{build/$1/$2.pdf}"           >> build/book.tex
}

includemd() {
    # TODO: make TableOfContents
    makemd /"${1%/}" "$2"
    echo "\includepdf{build/$1/$2.pdf}"           >> build/book.tex
}

build_count

# Preamble
rm -r build
makepreamble

# Write book
# for example: 
# includepdf 1-NumberBasics b
includepdf / cover

# End
makefinal
