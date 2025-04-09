Program RegEncadeados;

uses biblioteca;

type  ptnodo = ^Tfila;
      Tfila = record
				dado: integer;
				prox: ^Ptnodo
			end; 
				
var fila: Ptnodo;
		sair: boolean;
		co: char;

function vaziaa(F: Ptnodo): boolean;
begin
	vaziaa := false;
	if F = nil then 
		vaziaa := true;
end;
				
procedure inicializar(var F: Ptnodo);
begin				 
	F := nil;	
end;

procedure incluir(var F: Ptnodo;elem: integer);
var aux,aux2: Ptnodo;
begin				 
	aux2 := F;
	new(aux);
	if aux = nil then
		writeln('Memória cheia')
	else
	begin
		aux^.dado := elem;
		if vaziaa(fila) then
		begin
			F := aux;
			aux^.prox := nil;
		end 
		else
		begin
			while aux2^.prox <> nil do
				aux2 := aux2^.prox;
			aux2^.prox := aux;
			aux^.prox := nil;
		end;
	end;			
end;

procedure escrever(F: Ptnodo);
var aux2: Ptnodo;
begin
	if vaziaa(fila) then
		writeln('Sua fila está vazia')
	else
	begin	
		write('Fila: ');	 
		aux2 := F;
		while aux2 <> nil do
		begin	
			write(aux2^.dado :3);
			aux2 := aux2^.prox;			
		end;
	end;
end;

procedure consultar(F: Ptnodo);
begin
	if vaziaa(fila) then
		writeln('Sua fila está vazia')
	else
		writeln('O próximo da fila é ',F^.dado);
end;

procedure remover(var F: Ptnodo);
var i: integer;
		aux: Ptnodo;
begin
	if vaziaa(fila) then
		writeln('Sua fila está vazia')
	else
	begin
	 	aux := F;
	 	F := aux^.prox;
	 	dispose(aux);
	end;
end;

Begin
	inicializar(fila);
	while not sair do
	begin
	 	Sair := False;
	  case Opcoes('Incluir I | Remover R | Consultar C | Escrever E | Sair S ','I','R','C','E','S') of
		  'I': incluir(fila,ler_int('Qual valor quer incluir? '));
		  'R': remover(fila);
		  'C': consultar(fila);
		  'E': escrever(fila);
		  'S': begin 
						sair := true;
						writeln;writeln('Você saiu');
					 end;
			end;
	end;	  
End.