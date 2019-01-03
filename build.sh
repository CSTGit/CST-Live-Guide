#!/bin/bash

build_count() {
    bc -q <<< $(cat build.txt)+1 > build.txt
}

maketex() {
    mkdir build$1
    pdflatex --shell-escape -synctex=1 --interaction=nonstopmode -output-directory=build${1%/} ."$1"/"$2".tex
}

makemd() {
    mkdir build$1
    pandoc -t latex -o build${1%/}/"$2".pdf ."$1"/"$2".md
}

makepreamble() {
    mkdir build
    (
        exec 1> build/book.tex
        echo "\documentclass[12pt, a4paper]{book}"
        echo ""
        echo "\usepackage{subfiles}"
        echo "\usepackage{hyperref}"
        echo ""
        echo "\begin{document}"
        echo "\pagenumbering{gobble}"   
    )
}

makefinal() {
    echo "\end{document}" >> build/book.tex
    maketex /build book
    maketex /build book
    retval=$?
    mkdir output
    cp build/build/book.pdf output/book.pdf
    return $retval
}

includetex() {
    echo "\subfile{\"${1#/}$2\"}" >> build/book.tex
}

includemd() {
    mkdir build/"${1#/}"
    pandoc "${1#/}$2".md -t latex -o build/"${1#/}""$2".tex
    echo "\subfile{\"build/${1#/}$2\"}" >> build/book.tex
}

build_count

# Preamble
rm -r build
rm -r output
makepreamble

# Write book
includetex / cover
echo "\tableofcontents" >> build/book.tex
echo "\newpage" >> build/book.tex
echo "\pagenumbering{arabic}" >> build/book.tex

# End
makefinal
