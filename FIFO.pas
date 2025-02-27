Program fifo;

	uses biblioteca;

	const t = 3;
	type vetor = array[1..t] of integer;
	var vet: vetor;
			con: integer;
			sair: boolean;
			co: char;
		 	
Begin
	while not sair do
	 begin
	 	writeln;
		write('Incluir(I),remover(R),consultar(C),escrever(E) ou sair(S): ');
		readln(co);
		co := upcase(co);
		if co = 'I' then
		 	incluir_fila(vet,con,t)
		else if co = 'R' then
			remover_fila(vet,con)
		else if co = 'C' then
		  consultar_fila(vet,con)
		else if co = 'E' then
		 begin
		  write('Sua fila é: ');
			escrever_vetor(vet,con);
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