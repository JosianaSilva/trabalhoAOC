.code
entrada_dados:
	LDA teclado_end
    INT input
	SUB converter
	SHIFT esquerda
 	STA n

	
	LDA video_end
	ADD n
	ADD converter
	INT output

end:
	INT exit

.data
	;syscall exit
	exit: DD 25
	n: DD 0

	converter: DD 48

	video_end: DD 0x000
	input: DD 20

	teclado_end: DD 0x100
	output: DD 21

	direita:DD 0
	esquerda: DD 1
	
.stack 10

