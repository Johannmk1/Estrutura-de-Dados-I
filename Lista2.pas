Program Lista2;

	uses biblioteca;

	const t = 5;
	type TOb = record
					vet: array[1..t] of integer;
					con: integer;
					tam: integer;	
			 end;	
			 
	var L: TOb;
			sair: boolean;
			co: char;
		 	
Begin
	L.tam := t;  
	while not sair do
	 begin
	 	writeln;
		write('Incluir(I),remover(R),consultar(C),escrever(E) ou sair(S): ');
		readln(co);       
		co := upcase(co);
		if co = 'I' then
		 	incluir_lista_d(L,ler_int('Valor para incluir: '))
		else if co = 'R' then
			remover_lista_d(L,ler_int('Valor para remover: '))
		else if co = 'C' then
		  writeln(consultar_lista_d(L,ler_int('Valor para consultar: ')))
		else if co = 'E' then
		 begin
		  write('Sua lista é: ');
			escrever_vetor(L.vetor,L.count);
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
	//(?°?°)?? ???  	  
End.