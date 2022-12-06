.code
entrada_dados:

	LDA teclado_end
    INT input
	
conversao_entrada:
	
	SUB converter; AC - 48
	ADD acumulador; AC + acumu
	STA n; n = AC

	JN operacao; if entrada.hasNext() = false
	JMP mult10; else 

mult10:
	
	MOV n
	SHIFT esquerda
	SHIFT esquerda
	SHIFT esquerda
	ADD n
	ADD n
	STA acumulador
	JMP entrada_dados

operacao:

	SHIFT esquerda
 	STA n
	
saida_dados:

	MOV 0
	LDA video_end
	ADD n
	ADD converter
	INT output
	
end:
	INT exit

.data
	;syscall exit
	exit: DD 25
	dobro: DD 0
	n: DD 0
	contador: DD 0
	acumulador: DD 0

	converter: DD 48

	video_end: DD 0x000
	input: DD 20

	teclado_end: DD 0x100
	output: DD 21

	direita:DD 0
	esquerda: DD 1
	
.stack 100


