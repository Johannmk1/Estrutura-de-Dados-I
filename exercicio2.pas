program Exercicio2;

uses Biblioteca;

const
    T = 100;

type
    TVetor = array[1..T] of Integer;

var
    Vet: TVetor;
    Con, N, Base: Integer;
    Sair, Valido: Boolean;
    Co: Char;

procedure ProcessarEntrada;
var Equacao: String; 
begin
    writeln;
    write('Equação a ser validada: ');
    readln(Equacao);
    if Valida_Equacao(Equacao) then
      writeln('A parentização está correta')
    else
    	writeln('A parentização está errada');
end;

procedure VerificarContinuidade;
begin
    Valido := False;
    while not Valido do 
    begin
        writeln;
        writeln('Próximo (P) | Sair (S): ');
        readln(Co);
        Co := UpCase(Co);
        
        case Co of
            'P': Valido := True;
            'S': 
            begin
                Sair := True;
                Valido := True;
                writeln;
                writeln('Você saiu');
            end
        else
            writeln('Escreva um valor válido');
        end;             
    end;
end;

begin
    Sair := False;
    while not Sair do
    begin
        ProcessarEntrada;
        VerificarContinuidade;
    end;
end.
