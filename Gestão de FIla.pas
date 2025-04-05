Program GestaoFila ;
 
type TFila = record
			fila: array[1..10000] of integer;
			count: integer;
			tam: integer;
			ent: integer; 
			ate: integer;
			rec: integer;
			name: string;
	 	 end;
var Mono,Color,Plotter: TFila;
		Sair: boolean; 

function Opcoes(frase: string; a,b,c,d,e: char): char;
var Valido: boolean;
		Cod: char;
begin
  Valido := False;
  while not Valido do 
  begin
    writeln;
		writeln(frase);
    readln(Cod);
    Cod := UpCase(Cod);
    
    if ((Cod = a) or (Cod = b) or (Cod = c) or (Cod = d) or (Cod = e)) AND (Cod <> ' ') then
		begin
    	Opcoes := Cod;
			Valido := True;
		end
    else
       writeln('Escreva um valor válido');	              
  end;
end;

procedure VerificarContinuidade;
var Valido: boolean;
		Cod: char;
begin
  Valido := False;
  Sair := False;
  while not Valido do 
  begin
    writeln;
    writeln('Próximo (P) | Sair (S): ');
    readln(Cod);
    Cod := UpCase(Cod);
    
    case Cod of
      'P': begin
						Valido := True;
						clrscr;
					 end;
      'S': begin
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

function cheia (c,t: integer): boolean;
begin
	cheia := false;
	if c = t then
		cheia := true;
end;

function vazia (c: integer): boolean;
begin
	vazia := false;
	if c = 0 then
		vazia := true;
end;

procedure incluir_fila(var F: TFila);
begin
	inc(F.ent);
	if cheia(F.count,F.tam) then
	begin
		writeln ('A fila está cheia');
		inc(F.rec);
	end  
	else
	 begin
		F.fila[F.count + 1] := F.ent;
		F.count := F.count + 1;
	 end; 					
end;

procedure remover_fila(var F: TFila);
	var i: integer;
begin
	if vazia(F.count) then
		writeln('Sua fila está vazia')
	else
	 begin
	  for i := 1 to F.count - 1 do
			F.fila[i] := F.fila[i + 1];
		F.fila[F.count] := 0;
		F.count := F.count - 1;
		inc(F.ate);
	 end;
end;

procedure consultar_fila(F: TFila);
begin
	writeln('---Informações ',F.name,'---');
	if vazia(F.count) then
		writeln('Sua fila está vazia')
	else
		writeln(F.fila[1]); 

	writeln('Qtd Entrada: ',F.ent); 
	writeln('Qtd Atendido: ',F.ate); 
	writeln('Qtd Recusado: ',F.rec); 
	writeln('---------------------------');
end;

procedure processa(F:TFila);	
Begin                           
	Sair := False;
  while not Sair do
  begin
    case Opcoes(concat(F.name,': Incluir I | Retirar R | Consultar C'),'I','R','C',' ',' ') of
    	'I': incluir_fila(F); 
    	'R': remover_fila(F);
    	'C': consultar_fila(F);
    end;
    	 	
   VerificarContinuidade;
  end;  
end;
	
Begin
  Mono.name := 'Mono';
	Color.name := 'Color';
	Plotter.name := 'Plotter';

	Mono.tam := 10;
	Color.tam := 5;
	Plotter.tam := 3;
	
	Sair := False;
  while not Sair do
  begin
    case Opcoes('Mono M | Color C | Plotter P','M','C','P',' ',' ') of
    	'M': processa(Mono);
    	'C': processa(Color);
    	'P': processa(Plotter);
    end;	 	
   VerificarContinuidade;
  end;  
End.
