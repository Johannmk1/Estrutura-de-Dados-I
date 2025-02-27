Program exercicio4;

	uses biblioteca;

	const t = 100;
	type vetor = array[1..t] of integer;
	var vet: vetor;
			con,n,base: integer;
			sair: boolean;
			co: char;
		 	
Begin
	while not sair do
	 begin
	  sair := true;
	 	while sair do
	 	 begin
	 	 	sair := false;
	 	  writeln;
			ler_inteiro('Qual valor decimal deseja transformar? ',n);
			write('Binário(B),Octal(O),Hexadecimal(H): ');
			readln(co);
			co := upcase(co);
			if co = 'B' then
				base := 2 
			else if co = 'O' then
				base := 8
			else if co = 'H' then
				base := 16
			else
			 begin 
				writeln ('Escreva um valor válido');
				sair := true;
			 end;
		 end;
		
		iniciar(con);
		converter_base(vet,con,t,n,base);
		
		if base = 16 then
			escrever_pilha_hexa(vet,con)
		else
			escrever_vetor_invertido(vet,con);
		
		writeln; 
		write('Próximo(P),Sair(S): ');
		readln(co);
		co := upcase(co);
		if co = 'P' then
			writeln		  
		else if co = 'S' then
		 begin
			sair := true;
			writeln;writeln('Você saiu');
		 end
		else 
			writeln ('Escreva um valor válido');	 
	 end;  
End.