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
    write('Equa��o a ser validada: ');
    readln(Equacao);
    if Valida_Equacao(Equacao) then
      writeln('A parentiza��o est� correta')
    else
    	writeln('A parentiza��o est� errada');
end;

procedure VerificarContinuidade;
begin
    Valido := False;
    while not Valido do 
    begin
        writeln;
        writeln('Pr�ximo (P) | Sair (S): ');
        readln(Co);
        Co := UpCase(Co);
        
        case Co of
            'P': Valido := True;
            'S': 
            begin
                Sair := True;
                Valido := True;
                writeln;
                writeln('Voc� saiu');
            end
        else
            writeln('Escreva um valor v�lido');
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
