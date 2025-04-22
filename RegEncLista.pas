Program RegEncLista;

uses biblioteca;

type  Ptnodo = ^Tlista;
		  Tlista = record
		    dado: integer;
		    prox: Ptnodo;
		  end;

var lista: Ptnodo;
  	sair: boolean;

function vaziaa(L: Ptnodo): boolean;
begin
  vaziaa := L = nil;
end;

procedure inicializar(var L: Ptnodo);
begin
  L := nil;
end;

procedure incluir(var L: Ptnodo; elem: integer);
var novo, ant, atual: Ptnodo;
begin
  New(novo);
  if novo = nil then
    Writeln('Memória cheia')
  else
  begin
    novo^.dado := elem;
    ant := nil;
    atual := L;
    while (atual <> nil) and (atual^.dado < elem) do
    begin
      ant := atual;
      atual := atual^.prox;
    end;
    if ant = nil then
    begin
      novo^.prox := L;
      L := novo;
    end
    else
    begin
      ant^.prox := novo;
      novo^.prox := atual;
    end;
  end;
end;

procedure escrever(L: Ptnodo);
var aux: Ptnodo;
begin
  if vaziaa(L) then
    Writeln('Sua lista está vazia')
  else
  begin
    Write('Lista: ');
    aux := L;
    while aux <> nil do
    begin
      Write(aux^.dado:4);
      aux := aux^.prox;
    end;
    Writeln;
  end;
end;

procedure consultar(L: Ptnodo);
var valor: integer;
	  aux: Ptnodo;
	  pos: integer;
	  achou: boolean;
begin
  if vaziaa(L) then
    Writeln('Sua lista está vazia')
  else
  begin
    valor := Ler_Int('Qual valor deseja consultar? ');
    aux := L;
    pos := 1;
    achou := False;
    while (aux <> nil) and (not achou) do
    begin
      if aux^.dado = valor then
      begin
        Writeln('Valor ', valor, ' encontrado na posição ', pos);
        achou := True;
      end;
      aux := aux^.prox;
      Inc(pos);
    end;
    if not achou then
      Writeln('Valor ', valor, ' não encontrado na lista');
  end;
end;

procedure remover(var L: Ptnodo);
var valor: integer;
	  aux, ant: Ptnodo;
	  achou: boolean;
begin
  if vaziaa(L) then
    Writeln('Sua lista está vazia')
  else
  begin
    valor := Ler_Int('Qual valor deseja remover? ');
    aux := L;
    ant := nil;
    achou := False;
    while (aux <> nil) and (not achou) do
    begin
      if aux^.dado = valor then
      begin
        if ant = nil then
          L := aux^.prox
        else
          ant^.prox := aux^.prox;
        Dispose(aux);
        Writeln('Valor ', valor, ' removido da lista');
        achou := True;
      end
      else
      begin
        ant := aux;
        aux := aux^.prox;
      end;
    end;
    if not achou then
      Writeln('Valor ', valor, ' não encontrado na lista');
  end;
end;

begin
  inicializar(lista);
  sair := False;
  while not sair do
    case Opcoes('Incluir I | Remover R | Consultar C | Escrever E | Sair S ','I','R','C','E','S') of
      'I': incluir(lista, Ler_Int('Qual valor quer incluir? '));  
      'R': remover(lista);                                      
      'C': consultar(lista);                                    
      'E': escrever(lista);                                     
      'S': begin                                                 
             sair := True;
             Writeln;
             Writeln('Você saiu');
           end;
    end;
end.
