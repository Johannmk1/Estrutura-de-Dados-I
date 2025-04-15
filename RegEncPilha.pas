Program RegEncPilha;

uses biblioteca;

type  ptnodo = ^Tpilha;
      Tpilha = record
				dado: integer;
				prox: ^Ptnodo
			end; 
				
var pilha: Ptnodo;
		sair: boolean;
		co: char;

function vaziaa(P: Ptnodo): boolean;
begin
	vaziaa := false;
	if P = nil then 
		vaziaa := true;
end;
				
procedure inicializar(var P: Ptnodo);
begin				 
	P := nil;	
end;

procedure incluir(var P: Ptnodo;elem: integer);
var aux,aux2: Ptnodo;
begin				 
	aux2 := P;
	new(aux);
	if aux = nil then
		writeln('Memória cheia')
	else
	begin
		aux^.dado := elem;
		if vaziaa(pilha) then
		begin
			P := aux;
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

procedure escrever(P: Ptnodo);
var aux2: Ptnodo;
begin
	if vaziaa(pilha) then
		writeln('Sua fila está vazia')
	else
	begin	
		write('Pilha: ');	 
		aux2 := P;
		while aux2 <> nil do
		begin	
			write(aux2^.dado :3);
			aux2 := aux2^.prox;			
		end;
		writeln;
	end;
end;

procedure consultar(P: Ptnodo);
var aux2: Ptnodo;
begin
	if vaziaa(pilha) then
		writeln('Sua pilha está vazia')
	else
	begin
		aux2 := P;
		while aux2^.prox <> nil do
			aux2 := aux2^.prox;			
		writeln('O próximo da pilha é ',aux2^.dado);
	end;
end;

procedure remover(var P: Ptnodo);
var i: integer;
		aux,ant: Ptnodo;
begin
	if vaziaa(pilha) then
		writeln('Sua pilha está vazia')
	else
	begin
		ant := P;
		aux := P;
		if P^.prox = nil then
		begin
			dispose(P);
			inicializar(P);
		end 
		else
		begin
			while aux^.prox <> nil do
			begin
			  ant := aux;
				aux := aux^.prox;			
		 	end;
			dispose(aux);
		 	ant^.prox := nil;
	 	end;
	end;
end;

Begin
	inicializar(pilha);
	while not sair do
	begin
	 	Sair := False;
	  case Opcoes('Incluir I | Remover R | Consultar C | Escrever E | Sair S ','I','R','C','E','S') of
		  'I': incluir(pilha,ler_int('Qual valor quer incluir? '));
		  'R': remover(pilha);
		  'C': consultar(pilha);
		  'E': escrever(pilha);
		  'S': begin 
						sair := true;
						writeln;writeln('Você saiu');
					 end;
			end;
	end;	  
End.