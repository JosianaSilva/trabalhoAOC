.code
entrada_dados:

	LDA teclado_end
    INT input
	
conversao_entrada:
	
	SUB converter; AC - 48
	JN operacao; if entrada.hasNext() = false	
	;ADD acumulador; AC + acumulador
	STA n; n = AC
	
	MOV 1
	SUB contador
	JZ mult10 ; se cont = 1 vai pra mult10
	
	MOV 1 
	ADD contador
	STA contador ; cont += 1
	
	LDA n
	STA acumulador
	
	JMP entrada_dados
	
	
	;JMP mult10; else 

mult10:
	
	LDA acumulador
	SHIFT esquerda
	SHIFT esquerda
	SHIFT esquerda
	ADD acumulador
	ADD acumulador
	STA acumulador
	JMP operacao

operacao:

	LDA n
	ADD acumulador

	SHIFT esquerda
 	STA dobro
	
saida_dados:

	MOV 0
	LDA video_end
	ADD dobro
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


