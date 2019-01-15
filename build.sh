#!/bin/bash

build_count() {
	if [ ! -z $build_count_server ]; then
	    wget -qO build.txt http://$build_count_server/CST-Live-Guide
	else echo LOCAL > build.txt
	fi
	cat build.txt
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
        echo "\documentclass[12pt, a4paper, utf8]{book}"
        echo ""
        echo "\usepackage{subfiles}"
        echo "\usepackage{CJKutf8}"
        echo "\usepackage{longtable}"
        echo "\usepackage{booktabs}"
        echo "\usepackage[colorlinks=true, urlcolor=blue]{hyperref}"
        echo ""
        echo "\providecommand{\tightlist}{\setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}"
        echo ""
        echo "\begin{document}"
        echo "\begin{CJK}{UTF8}{gkai}"
        echo "\pagenumbering{gobble}"
    )
}

makefinal() {
    (
        exec 1>> build/book.tex
        echo "\newpage"
        echo "\end{CJK}"
        echo "\end{document}"
    )
    maketex /build book
    maketex /build book
    retval=$?
    mkdir output
    cp build/build/book.pdf output/book.pdf
    git --work-tree=output checkout web -- .
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

includetex "Basic Math/" ChapterIntro
includetex "Basic Math/" NumeralSystem
includetex "Basic Math/" Arithmetic
includetex "Basic Math/" BooleanAlgebra
includetex "Basic Math/" AxiomAndTheorem

includetex "Data Structure/" ChapterIntro
includetex "Data Structure/" IntegerRepresentation
includetex "Data Structure/" DecimalRepresentation
includetex "Data Structure/" CharacterEncoding
includetex "Data Structure/" DataOrganization

includetex "Data Communication/" ChapterIntro
includetex "Data Communication/" InterProcessCommunication

includetex "Hardware Execution/" ChapterIntro
includetex "Hardware Execution/" LogicGate
includetex "Hardware Execution/" GateCircuits
includetex "Hardware Execution/" CPUExecution
includetex "Hardware Execution/" ExecutionFlowModification

includetex "Compiler Principle/" ChapterIntro
includetex "Compiler Principle/" ChomskyHierarchy
includetex "Compiler Principle/" AutomataTheory
includetex "Compiler Principle/" CodeGeneration
includetex "Compiler Principle/" ProgramOptimization

includetex "Deep Learning/" ChapterIntro
includemd "Deep Learning/" Classification
includemd "Deep Learning/" SemanticSegmentation
includemd "Deep Learning/" InstanceSegmentation
includemd "Deep Learning/" ObjectDetection
includemd "Deep Learning/" Compression

includetex "Real World Develop/" ChapterIntro
includetex "Real World Develop/" HealthAdvice

includetex "Sentimental Life/" ChapterIntro
includetex "Sentimental Life/" blank

# End
makefinal
