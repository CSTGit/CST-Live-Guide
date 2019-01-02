#!/bin/bash

build_count() {
    bc -q <<< $(cat build.txt)+1 > build.txt
}

makepdf() {
    pdflatex --shell-escape -synctex=1 -interaction=nonstopmode -output-directory=build "$1".tex
}

makemd() {
    echo
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
    makepdf build/book
}

includepdf() {
    makepdf "$1"
    echo "\includepdf{build/$1.pdf}"           >> build/book.tex
}

includemd() {
    echo
}

build_count

# Preamble
makepreamble

# Write book
includepdf cover

# End
makefinal
