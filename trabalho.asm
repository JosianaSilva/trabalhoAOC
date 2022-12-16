.code
print: 
	LDI ptr           
	SUB ultimo_caractere
	JZ  print_linha1
do:
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
	JN operacao   					; se não houver entrada, pula pra operação	
	STA n					; n = AC

	MOV 0
	SUB n
	JZ condicao

continue:
	MOV 1 
	ADD contador
	STA contador 					; cont += 1
	
	
	MOV 2
	SUB contador
	JZ mult10 					; se cont = 2 vai pra mult10
	

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
	JZ dobrar ; if contador = 1 

	LDA n
	ADD acumulador
	STA acumulador

dobrar:

	LDA acumulador
	SHIFT esquerda
 	STA dobro

dividindo_1:

	LDA dobro
	STA quociente

dividindo_2:

	LDA quociente
	SUB dez
	JN print2; quociente < 10

	LDA quociente
	SUB dez	
	STA quociente
	
	MOV 1
	ADD auxiliar
	STA auxiliar
	JMP dividindo_2	

print2: 
	LDI ptr2     
	SUB ultimo_caractere
	JZ  saida_dados
do:
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
	ADD auxiliar
	ADD converter
	INT output

	LDA video_end
	ADD quociente
	ADD converter
	INT output

print_linha:
	LDA video_end
	ADD quebra_linha
	INT output
	
	MOV 0
	STA n
	STA auxiliar
	STA acumulador
	STA contador
	STA dobro
	STI ptr2 

	JMP print
end:
	INT exit

.data
	;syscall exit
	exit: DD 25

	dobro: DD 0
	n: DD 0
	contador: DD 0
	acumulador: DD 0

	auxiliar: DD 0
	quociente: DD 0

	converter: DD 48
	quebra_linha: DD 13
	dez: DD 10

	mensagem: INITB "Escreva um numero ",0
	ptr: DD mensagem
	mensagem2: INITB "O dobro e ",0
	ptr2: DD mensagem2
	ultimo_caractere: DD 0

	video_end: DD 0x000
	input: DD 20

	teclado_end: DD 0x100
	output: DD 21

	direita:DD 0
	esquerda: DD 1
	
.stack 100
