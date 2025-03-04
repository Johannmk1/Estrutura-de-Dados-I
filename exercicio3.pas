program Exercicio3;

uses Biblioteca;         

const
    T = 1000;

type
    Vetor = array[1..T] of Integer;

var
    FilaPar,FilaImpar,Pilha: Vetor;
    ContPar,ContImpar,ContPilha,N: Integer;
    Sair, Valido: Boolean;

procedure ProcessarEntrada;
var 
begin
		while ContPar + ContImpar > 0 do
			begin
				if ContImpar > 0 then
					begin
						if FilaImpar[1] > 0 then
								incruir_pilha2(Pilha,ContPilha,T,FilaImpar[1])
						else
								remover_pilha(Pilha,ContPilha,T);
						remover_fila(FilaImpar,ContImpar,T)
					end;
				if ContPar > 0 then
					begin
						if FilaPar[1] > 0 then
								incruir_pilha2(Pilha,ContPilha,T,FilaPar[1])
						else
								remover_pilha(Pilha,ContPilha,T);
						remover_fila(FilaImpar,ContImpar,T)
					end;
			end;		  	
end;

procedure EntradaDados;
var N: integer;
begin
		N := 1;
    while N <> 0 do 
    begin
        writeln;
        ler_inteiro('Insira um valor inteiro (zero serve para sair)',N);
        if N = 0 then
        		writeln ('Entrada de dados finalizada')
        else if N mod 2 = 0 then
        		incuir_fila_valor(FilaPar,cont,T,N)
        else 
						incluir_fila_valor(FilaImpar,cont,T,N);
    end;
end;

begin
		EntradaDados;
    ProcessarEntrada;
    VerificarContinuidade;
end.
