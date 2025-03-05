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
begin
		while ContPar + ContImpar > 0 do
			begin
				if ContImpar > 0 then
					begin
						if FilaImpar[1] > 0 then
								incluir_pilha2(Pilha,ContPilha,T,FilaImpar[1])
						else
								remover_pilha(Pilha,ContPilha);
						remover_fila(FilaImpar,ContImpar)
					end;
				if ContPar > 0 then
					begin
						if FilaPar[1] > 0 then
								incluir_pilha2(Pilha,ContPilha,T,FilaPar[1])
						else
								remover_pilha(Pilha,ContPilha);
						remover_fila(FilaPar,ContPar)
					end;
			end;		  	
end;

procedure EntradaDados;
var N: integer;
begin
		N := 1;
    while N <> 0 do 
    begin
        ler_inteiro('Insira um valor inteiro (zero serve para sair)',N);
        writeln;
        if N = 0 then
        		writeln ('Entrada de dados finalizada')
        else if par(N) then
        		incluir_fila_valor(FilaPar,ContPar,T,N)
        else 
						incluir_fila_valor(FilaImpar,ContImpar,T,N);
    end;
end;

begin
		EntradaDados;
    ProcessarEntrada;
    writeln;write('Sua pilha é: ');
    escrever_vetor(Pilha,ContPilha);
end.
