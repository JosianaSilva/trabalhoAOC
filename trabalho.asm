.code
print: 
	LDI ptr           
	SUB ultimo_caractere
	JZ  print_linha1

	LDI ptr           
	ADD video_end
	INT output 

	MOV 1             
	ADD ptr
	STA ptr

	JMP print

print_linha1:
	LDA video_end
	ADD quebra_linha
	INT output

entrada_dados:
	LDA teclado_end
    INT input
	
conversao_entrada:
	SUB converter       ; AC - 48
	JN operacao   		; se n�o houver entrada, pula pra opera��o	
	STA n				; n = AC

	MOV 0
	SUB n
	JZ condicao

continue:
	MOV 1 
	ADD contador
	STA contador 		; cont += 1	
	
	MOV 2
	SUB contador
	JZ mult10 			; se cont = 2 vai pra mult10
	
	LDA n
	STA acumulador
	
	JMP entrada_dados

condicao:
	MOV 0 
	SUB contador
	JZ end
	JMP continue
	
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
	MOV 1
	SUB contador
	JZ dobrar 			; if contador = 1 

	LDA n
	ADD acumulador
	STA acumulador

dobrar:
	LDA acumulador
	SHIFT esquerda
 	STA dobro

operacao2:
	LDA dobro
	STA parte_inteira

op_modulo_10:
	LDA parte_inteira
	SUB dez
	JN print2			; parte_inteira < 10

	LDA parte_inteira
	SUB dez	
	STA parte_inteira
	
	MOV 1
	ADD modulo
	STA modulo
	JMP op_modulo_10	

print2: 
	LDI ptr2     
	SUB ultimo_caractere
	JZ  saida_dados

	LDI ptr2          
	ADD video_end
	INT output 

	MOV 1             
	ADD ptr2
	STA ptr2

	JMP print2

saida_dados:
	MOV 0
	LDA video_end
	ADD modulo
	ADD converter
	INT output

	LDA video_end
	ADD parte_inteira
	ADD converter
	INT output

print_linha:
	LDA video_end
	ADD quebra_linha
	INT output

reinicializacao_dos_valores:	
	MOV 0
	STA n
	STA modulo
	STA acumulador
	STA contador
	STA dobro

	JMP entrada_dados

end:
	INT exit

.data
	
	exit: DD 25

	dobro: 				DD 0
	n: 					DD 0
	contador: 			DD 0
	acumulador: 		DD 0

	modulo: 			DD 0
	parte_inteira: 		DD 0

	converter: 			DD 48
	quebra_linha: 		DD 13
	dez: 				DD 10

	mensagem: 			INITB "Escreva um numero ",0
	ptr: 				DD mensagem
	mensagem2: 			INITB "O dobro e ",0
	ptr2: 				DD mensagem2
	ultimo_caractere: 	DD 0

	video_end: 			DD 0x000
	input: 				DD 20

	teclado_end: 		DD 0x100
	output: 			DD 21

	direita: 			DD 0
	esquerda: 			DD 1
	
.stack 100
