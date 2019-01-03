SETLOCAL ENABLEEXTENSIONS
GOTO :MAIN

:build_count
	SET /p build= < build.txt
	SET /A build=%build%+1
	ECHO %build% > build.txt
GOTO :EOF

:maketex
	MKDIR build%1
	SET strip=%~1
	IF %strip:~0,1%==/ SET strip=%strip:~1,-1%
	pdflatex --shell-escape -synctex=1 --interaction=nonstopmode -output-directory=build%strip% .%~1/%~2.tex
GOTO :EOF

:makemd
	MKDIR build%1
	SET strip=%~1
	IF %strip:~0,1%==/ SET strip=%strip:~1,-1%
	pandoc -t latex -o build%strip%/%~2.pdf .%~1/%~2.md
GOTO :EOF

:makepreamble
	MKDIR build
	ECHO \documentclass[12pt, a4paper]{book} > build/book.tex
	ECHO. >> build/book.tex
	ECHO \usepackage{subfiles} >> build/book.tex
	ECHO \usepackage[colorlinks=true, urlcolor=blue]{hyperref} >> build/book.tex
	ECHO. >> build/book.tex
	ECHO \begin{document} >> build/book.tex
	ECHO \pagenumbering{gobble} >> build/book.tex
GOTO :EOF

:makefinal
	ECHO \end{document} >> build/book.tex
	CALL :maketex \build book
	CALL :maketex \build book
	
	MKDIR output
	COPY build\build\book.pdf output\book.pdf
GOTO :EOF

:includetex
	SET strip=%~1
	IF %strip:~0,1%==/ SET strip=%strip:~1,-1%
	rem SET strip=%~1
	rem IF %strip:~-1%==/ SET strip=%strip:~0,-1%
	ECHO \subfile{"%strip%%~2"} >> build/book.tex
GOTO :EOF

:includemd
	SET strip=%~1
	IF %strip:~0,1%==/ SET strip=%strip:~1,-1%
	MKDIR build/%~STRIP1
	pandoc %strip%%~2.md -t latex -o build/%strip%%~2.tex
	ECHO \subfile{"build/%strip%%~2"}" >> build/book.tex
GOTO :EOF

:MAIN

CALL :build_count

REM Preamble
DEL /q build
DEL /q output
CALL :makepreamble

REM Write book
CALL :includetex / cover
ECHO \tableofcontents >> build/book.tex
ECHO \newpage >> build/book.tex
ECHO \pagenumbering{arabic} >> build/book.tex
CALL :includetex "Basic Math/" ChapterIntro
CALL :includetex "Basic Math/" NumericSystem

REM End
CALL :makefinal