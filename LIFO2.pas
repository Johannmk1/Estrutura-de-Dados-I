Program lifo2;

	uses biblioteca;

	const t = 3;
	type TOb = record
					vet: array[1..t] of integer;
					con: integer;
					tam: integer;	
			 end;
			 
	var P: TOb;
			sair: boolean;
			co: char;
	
Begin  
	P.tam := t;  
	while not sair do
	 begin
	 	writeln;
		write('Incluir(I),remover(R),consultar(C),escrever(E) ou sair(S): ');
		readln(co);
		co := upcase(co);
		if co = 'I' then
		 	incluir_pilha_d(P,ler_int('Valor para incluir: '))
		else if co = 'R' then
			remover_pilha_d(P)
		else if co = 'C' then
		  writeln(consultar_pilha_d(P))
		else if co = 'E' then
		 begin
		  write('Sua pilha é: ');
			escrever_vetor(P.vetor,P.count);
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