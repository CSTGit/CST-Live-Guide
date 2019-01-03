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
    echo "\documentclass[12pt, a4paper]{book}"  >  build/book.tex
    echo                                        >> build/book.tex
    echo "\usepackage{pdfpages}"                >> build/book.tex
    echo "\usepackage{import}"                  >> build/book.tex
    echo "\usepackage{subfiles}"   				>> build/book.tex
    echo                                        >> build/book.tex
    echo "\begin{document}"                     >> build/book.tex
    echo "\pagenumbering{gobble}"               >> build/book.tex
    echo "\setboolean{@twoside}{false}"         >> build/book.tex
}

makefinal() {
    echo "\end{document}"                       >> build/book.tex
    makepdf /build book
    retval=$?
    mkdir output
    cp build/build/book.pdf output/book.pdf
    return $retval
}

includetex() {
	if [ $1 = / ]; then
		echo "\subfile{$2}" >> build/book.tex
	else
		echo "\subfile{${1%/}/$2}" >> build/book.tex
	fi
}

includemd() {
	
}

build_count

# Preamble
rm -r build
rm -r output
makepreamble

# Write book
# for example: 
# includepdf 1-NumberBasics b
includetex / cover
echo "\tableofcontents"                         >> build/book.tex
echo "\newpage"                                 >> build/book.tex
echo "\pagenumbering{arabic}"                   >> build/book.tex
includetex Cpt1 Sample1
includetex Cpt2 Sample1
includetex Cpt3 Sample1

# End
makefinal
