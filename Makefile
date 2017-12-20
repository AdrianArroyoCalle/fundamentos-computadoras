all:
	lualatex arquitectura-computadoras.tex
	pdflatex fundamentos-computadoras.tex
clean:
	rm arquitectura-computadoras.log
	rm arquitectura-computadoras.aux
	rm arquitectura-computadoras.out
	rm fundamentos-computadoras.log
	rm fundamentos-computadoras.aux
