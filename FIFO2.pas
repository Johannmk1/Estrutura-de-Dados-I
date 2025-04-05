Program fifo2;

	uses biblioteca;

	const t = 3;
	type TOb = record
					vet: array[1..t] of integer;
					con: integer;
					tam: integer;	
			 end;		
					
	var F: TOb;
			sair: boolean;
			co: char;
			n: integer;
		 	
Begin
	F.tam := t;
	while not sair do
	 begin
	 	writeln;
		write('Incluir(I),remover(R),consultar(C),escrever(E) ou sair(S): ');
		readln(co);       
		co := upcase(co);
		if co = 'I' then
		begin
			
		 	incluir_fila_d(F,ler_int('Valor para incluir: '));
		end
		else if co = 'R' then
			remover_fila_d(F)
		else if co = 'C' then
		  writeln(consultar_fila_d(F))
		else if co = 'E' then
		 begin
		  write('Sua fila é: ');
			escrever_vetor_d(F);
			writeln;	
		 end	  
		else if co = 'S' then
		 begin
			sair := true;
			writeln;writeln('Você saiu');
		 end
		else 
			writeln ('Escreva um valor válido');	 
	 end;  	  
End.