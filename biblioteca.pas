Unit biblioteca;
Interface 

uses crt;

	type vetor = array[1..10000] of integer; 
			matriz = array[1..10000,1..10000] of integer;
			
			TOb = record
				vetor: array[1..10000] of integer;
				count: integer;
				tam: integer;
			end;

  function cheia (c,t: integer): boolean;
  function vazia (c: integer): boolean;
  function primos(n:integer):boolean;
  function par(n: integer):boolean;
  function fatorial(n: integer):Integer;
  function maior_valor(B: vetor): real;
  function distancia_dois_pontos(x1,x2,y1,y2: real):real;
  function pertence(v: vetor;t,n: integer): boolean;
	function pertence_ordenado(v: vetor;t,n: integer): boolean;
	function tem_raiz(a,b,c: real): boolean;  
	function posicao_ordenado(v: vetor;t,n: integer): integer;
	function Inverter_Palavras(F: string): String;
	function Valida_Equacao(E: string): boolean;
	
	function consultar_fila (v: vetor;c: integer): integer;
	function consultar_pilha (v: vetor;c: integer): integer;
	function consultar_lista (v: vetor;c,valor: integer): integer;
	
	function consultar_fila_d (F: TOb): integer;
	function consultar_pilha_d (P: TOb): integer;
	function consultar_lista_d (L: TOb;valor: integer): integer;
	
	function ler_int(msg: string): integer;
	function ler_str(msg: string): string;
	
	function Opcoes(frase: string; a,b,c,d,e: char): char;
		
	procedure ler_inteiro(msg: string;n: integer);
	procedure ler_real(msg: string;n: real);
	procedure ler_vetor(var v: vetor;t: integer);
	procedure ler_matriz(var m: matriz;ql,qc: integer);
	
	procedure escrever_vetor(v: vetor;t: integer);
	procedure escrever_vetor_d(F: TOb);
	
	procedure escrever_vetor_invertido(v: vetor;t: integer);
	procedure escrever_pilha_hexa(v: vetor;t: integer);
  procedure escrever_matriz(var m: matriz;ql,qc: integer);
	  
  procedure gerar_vetor(var v: vetor;t,max: integer);       //max = valor máximo que quer no vetor
	procedure gerar_matriz(var m: matriz;ql,qc,max: integer); //max = valor máximo que quer na matriz
	 	
	procedure iniciar(var c: integer);                                                              
	procedure incluir_fila (var v: vetor;var c: integer;t,valor: integer);
	procedure remover_fila (var v: vetor;var c: integer);
	
	procedure incluir_pilha (var v: vetor;var c: integer;t,valor: integer);
	procedure remover_pilha (var v: vetor;var c: integer);
	
	procedure incluir_lista (var v: vetor;var c: integer;t,valor: integer);
	procedure remover_lista (var v: vetor;var c: integer;valor: integer);
	
	procedure incluir_fila_d (var F: TOb; valor: integer);
	procedure remover_fila_d (var F: TOb);
	 
	procedure incluir_pilha_d (var P: TOb;valor: integer);
	procedure remover_pilha_d (var P: TOb);
	
	procedure incluir_lista_d (var L:TOb;valor: integer);
	procedure remover_lista_d (var L: TOb;valor: integer);
		
	procedure converter_base (var v: vetor;var c: integer;t,num,base: integer);
	 
	procedure ordenar_vetor(var v:vetor;t:integer);
  procedure uniao_vetor(v1,v2: vetor;t1,t2: integer;var u: vetor;var t: integer);
	procedure interseccao_vetor(v1,v2: vetor;t1,t2: integer;var it: vetor;var t: integer);
	procedure diferenca_vetor(v1,v2: vetor;t1,t2: integer;var d: vetor;var t: integer);
	
	procedure baskara(a,b,c: real; var x1,x2: real);
// Tipo dos vetores e matrizes é 'vetor' e 'matriz'	

	
	    
Implementation    
//funções

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

	function primos(n:integer):boolean;
	Var i:integer;
	begin
		primos := True;
		if n < 2 then
			primos := false
		else
			for i := 2 to n - 1 do
			begin
				if n mod i = 0 then
					primos := false;
			end;
	end;
	
	function par(n: integer):boolean;
	begin
		if n mod 2 = 0 then
			par := True;
	end;
	
  function fatorial(n: integer):Integer;
	begin
		if n = 1 then
			fatorial := 1
		else
			fatorial := n * fatorial(n - 1);
	end;
	
	function maior_valor(B: vetor): real;
	var i: integer;
			m: real;
	begin
		m := -999999;
		for i := 1 to 50 do
			if B[i] > m then 
				m := B[i];
		maior_valor := m
	end;
	
  function distancia_dois_pontos(x1,x2,y1,y2: real):real;
	begin
		distancia_dois_pontos := SQRT(SQR(x2 - x1) + SQR(y2 - y1));	
	end;
	
  function pertence(v: vetor;t,n: integer): boolean;
	var i: integer;
	begin
		i := 1;
		while i <= t do
		begin
			if v[i] = n then
				pertence := True;
			i := i + 1;
		end;
	end;
	
	function pertence_ordenado(v: vetor;t,n: integer): boolean;
	var inicio,fim,meio: integer;
			pertence: boolean;
	begin
		inicio := 1;
		fim := t;
		while (inicio <= fim) and not pertence do
		 begin
			meio := (inicio + fim) div 2;
			if n = v[meio]  then
				pertence := true
			else if n > v[meio] then
				inicio := meio + 1
			else
				fim := meio - 1;
		 end;
		pertence_ordenado := pertence;
	end;	
	
	function tem_raiz(a,b,c: real): boolean;
	var d: real;                                                           
	begin                                                                
		d := sqr(b) -4 * a * c; 		
		if d >= 0 then
			tem_raiz := true;			                                                   
	end;
	
	function posicao_ordenado(v: vetor;t,n: integer): integer;
	var inicio,fim,meio,posicao: integer;
	begin
		inicio := 1;
		fim := t;
		posicao := 0;
		while (inicio <= fim) and (posicao = 0) do
		 begin
			meio := (inicio + fim) div 2;
			if n = v[meio]  then
				posicao := meio
			else if n > v[meio] then
				inicio := meio + 1
			else
				fim := meio - 1;
		 end;
		posicao_ordenado := posicao;
	end;
	
	function Inverter_Palavras(F: string): String;
	var	i, c: Integer;
	    PalavraInvertida, FraseInvertida: String;
	begin
	  c := 0;
	  FraseInvertida := '';
	  F := F + ' ';
	  
	  for i := 1 to Length(F) do
	  begin
	  	if F[i] <> ' ' then
	    begin
	      c := c+1;
	      PalavraInvertida := PalavraInvertida + F[i];
	    end
	    else
	    begin
	    	while c > 0 do
	      begin
	      	FraseInvertida := FraseInvertida + PalavraInvertida[c];
	        c := c-1;
	      end;
	      FraseInvertida := FraseInvertida + ' ';
	      PalavraInvertida := '';
	  	end;
	  end;
	  
	  if Length(FraseInvertida) > 0 then
	  	Delete(FraseInvertida, Length(FraseInvertida), 1);
	  
	  Inverter_Palavras := FraseInvertida;
	end;
	
	function Valida_Equacao(E: string): boolean;
	var	i, c: Integer;
			v: boolean;
	begin
	  c := 0;
	  i := 1;
	  v := true;
	  
	  while (i <= Length(E)) and (v) do
	  begin
	  	if E[i] = '(' then
	      c := c + 1
	    else
	    	if E[i] = ')' then
	    	 begin
	        c := c - 1;
	        if c < 0 then
	        	v := false;
	       end;
	    i := i + 1;
	  end;
	  if c <> 0 then
	  	v := false;
	  Valida_Equacao := v;
	end;
		
	function consultar_fila (v: vetor;c: integer): integer;
	begin
		if vazia(c) then
			writeln('Sua fila está vazia')
		else
			consultar_fila := v[1];
	end;	
		
	function consultar_pilha (v: vetor;c: integer): integer;
	begin
		if vazia(c) then
			writeln('Sua pilha está vazia')
		else
			consultar_pilha := v[c];
	end;
		
	function consultar_lista (v: vetor;c,valor: integer): integer;
	begin
		if vazia(c) then
			consultar_lista := 0
		else
		  consultar_lista := posicao_ordenado(v,c,valor);
	end;
			
	function consultar_fila_d (F: TOb): integer;
	begin
		if vazia(F.count) then
			writeln('Sua fila está vazia')
		else
			consultar_fila_d := F.vetor[1];
	end;
	
	function consultar_pilha_d (P: TOb): integer;
	begin
		if vazia(P.count) then
			writeln('Sua pilha está vazia')
		else
			consultar_pilha_d := P.vetor[P.count];
	end;
		
	function consultar_lista_d (L: TOb;valor: integer): integer;
	begin
		if vazia(L.count) then
			consultar_lista_d := 0
		else
		  consultar_lista_d := posicao_ordenado(L.vetor,L.count,valor);
	end;
	
	function ler_int(msg: string): integer;
	var n: integer;
  begin
  	write(msg,' ');
  	readln(n);
  	ler_int := n;
  end; 
	
	function ler_str(msg: string): string;
	var s: string;
  begin
  	write(msg,' ');
  	readln(s);
  	ler_str := s;
  end;   

	function Opcoes(frase: string; a,b,c,d,e: char): char;
	var Valido: boolean;
			Cod: char;
	begin
	  Valido := False;
	  while not Valido do 
	  begin
	    writeln;
			write(frase,'  ');
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
	
//procedimentos		

  procedure ler_inteiro(msg: string;var n: integer);
  begin
  	write(msg,' ');
  	readln(n);
  end;          

  procedure ler_real(msg: string;var n: real);
  begin
  	write(msg,' ');
  	readln(n);
  end;
  
	procedure ler_vetor(var v: vetor;t: integer);
	var i: integer; 
	begin
	 	for i := 1 to t do
	   begin
	  	write('Digite o ',i,'é elemento: ');
			readln(v[i]);
		 end;
	end;
	 
	procedure ler_matriz(var m: matriz;ql,qc: integer);
	var i,j: integer; 
	begin
	 	for i := 1 to ql do
		 	for i := 1 to qc do
		   begin
		  	write('Digite o elemento da L',i,' e C',j,': ');
				readln(m[i,j]);
			 end;
	end;
	
	procedure escrever_vetor(v: vetor;t: integer);
	var i: integer; 
	begin
	 	for i := 1 to t do
	  	write(v[i]:5);
	end;	
	
	procedure escrever_vetor_d(F: Tob);
	var i: integer; 
	begin
	 	for i := 1 to F.count do
	  	write(F.vetor[i]:5);
	end;
	
	procedure escrever_vetor_invertido(v: vetor;t: integer);
	var i: integer; 
	begin
	 	for i := t downto 1 do
	  	write(v[i]:3);
	end;
	
	procedure escrever_pilha_hexa(v: vetor;t: integer);
	var i: integer; 
	begin
	 	for i := t downto 1 do
	 	  if v[i] < 10 then
	 	   	write(v[i]:3)
	 	  else 
			  write(chr(v[i]+56));
			 //if v[i] = 10 then
{	 	  	write('A':3)
	 	  else if v[i] = 11 then
	 	  	write('B':3)
	 	  else if v[i] = 12 then
	 	  	write('C':3)
	 	  else if v[i] = 13 then
	 	  	write('D':3)
	 	  else if v[i] = 14 then
	 	  	write('E':3)
	 	  else if v[i] = 15 then
	 	  	write('F':3)
}	end;	
	 
	procedure escrever_matriz(var m: matriz;ql,qc: integer);
	var i,j: integer; 
	begin
	 	for i := 1 to ql do
	 	 begin
		 	for i := 1 to qc do
				write(m[i,j]);
			writeln;
		 end;
	end;

	procedure gerar_vetor(var v: vetor;t,max: integer);
	var i: integer; 
	begin
	 	for i := 1 to t do
	  	v[i] := random(max) + 1;
	end;
	 
	procedure gerar_matriz(var m: matriz;ql,qc,max: integer);
	var i,j: integer; 
	begin
	 	for i := 1 to ql do
		 	for i := 1 to qc do
		  	m[i,j] := random(max) + 1;
	end;

	procedure iniciar(var c: integer);
	begin
		c := 0;	
	end; 
				
	procedure incluir_fila (var v: vetor;var c: integer;t,valor: integer);
	begin
		if cheia(c,t) then
			writeln ('Sua fila está cheia')
		else
		 begin
			v[c + 1] := valor;
			c := c + 1;
		 end; 					
	end;
	
	procedure remover_fila (var v: vetor;var c: integer);
		var i: integer;
	begin
		if vazia(c) then
			writeln('Sua fila está vazia')
		else
		 begin
		  for i := 1 to c - 1 do
				v[i] := v[i + 1];
			v[c] := 0;
			c := c - 1;
		 end;
	end;
	
	procedure incluir_pilha (var v: vetor;var c: integer;t,valor: integer);
	begin
		if cheia(c,t) then
			writeln ('Sua pilha está cheia')
		else
		 begin
			v[c + 1] := valor;
			c := c + 1;
		 end; 					
	end;

	procedure remover_pilha (var v: vetor;var c: integer);
		var i: integer;
	begin
		if not vazia(c) then
			c := c - 1;
	end;
	
	procedure incluir_lista (var v: vetor;var c: integer;t,valor: integer);
		var i,j: integer;
				acho: boolean;
	begin
		if cheia(c,t) then
			writeln ('Sua fila está cheia')
		else if vazia(c) then
		 begin
		  v[1] := valor;
		  c := c + 1;
		 end	
		else
		 begin
		  if pertence_ordenado(v,c,valor) then
		  	writeln(valor,' já pertence a lista'); 
		  i := 1;
		  acho := false;
		  while (i <= c) and (not acho) do
		   begin
		   	if valor < v[i] then
		   	 begin
		   		for j := c downto i do
						v[j + 1] := v[j];
					v[i] := valor;
					c := c + 1;
					acho := true; 
				 end 
		   	else		   	
		   	 i := i + 1;
		   end;
		  if not acho then
		   begin
		    c := c + 1;
		    v[c] := valor;
		   end;
		 end; 					
	end;
	
	procedure remover_lista (var v: vetor;var c: integer;valor: integer);
		var i,posi: integer;
	begin
		if not vazia(c) then
		 begin
		  posi := posicao_ordenado(v,c,valor);
		  if posi = 0 then          
		  	writeln('O seu valor não pertence a lista');
		  for i := posi to c - 1 do
				v[i] := v[i + 1];
			v[c] := 0;
			c := c - 1;
		 end;
	end;

	procedure incluir_fila_d (var F: TOb; valor: integer);
	begin
		if cheia(F.count,F.tam) then
			writeln ('Sua fila está cheia')
		else
		 begin
			F.Vetor[F.count + 1] := valor;
			F.count := F.count + 1;
		 end; 					
	end;
	
	procedure remover_fila_d (var F: TOb);
		var i: integer;
	begin
		if vazia(F.count) then
			writeln('Sua fila está vazia')
		else
		 begin
		  for i := 1 to F.count - 1 do
				F.Vetor[i] := F.Vetor[i + 1];
			F.Vetor[F.count] := 0;
			F.count := F.count - 1;
		 end;
	end;
	
	procedure incluir_pilha_d (var P: TOb;valor: integer);
	begin
		if cheia(P.count,P.tam) then
			writeln ('Sua pilha está cheia')
		else
		 begin
			P.vetor[P.count + 1] := valor;
			P.count := P.count + 1;
		 end; 					
	end;

	procedure remover_pilha_d (var P: TOb);
		var i: integer;
	begin
		if not vazia(P.count) then
			P.count := P.count - 1;
	end;                     
	
	procedure incluir_lista_d (var L:TOb;valor: integer);
		var i,j: integer;
				acho: boolean;
	begin
		if cheia(L.count,L.tam) then
			writeln ('Sua fila está cheia')
		else if vazia(L.count) then
		 begin
		  L.vetor[1] := valor;
		  L.count := L.count + 1;
		 end	
		else
		 begin
		  if pertence_ordenado(L.vetor,L.count,valor) then
		  	writeln(valor,' já pertence a lista'); 
		  i := 1;
		  acho := false;
		  while (i <= L.count) and (not acho) do
		   begin
		   	if valor < L.vetor[i] then
		   	 begin
		   		for j := L.count downto i do
						L.vetor[j + 1] := L.vetor[j];
					L.vetor[i] := valor;
					L.count := L.count + 1;
					acho := true; 
				 end 
		   	else		   	
		   	 i := i + 1;
		   end;
		  if not acho then
		   begin
		    L.count := L.count + 1;
		    L.vetor[L.count] := valor;
		   end;
		 end; 					
	end;
	
	procedure remover_lista_d (var L: TOb;valor: integer);
		var i,posi: integer;
	begin
		if not vazia(L.count) then
		 begin
		  posi := posicao_ordenado(L.vetor,L.count,valor);
		  if posi = 0 then          
		  	writeln('O seu valor não pertence a lista');
		  for i := posi to L.count - 1 do
				L.vetor[i] := L.vetor[i + 1];
			L.vetor[L.count] := 0;
			L.count := L.count - 1;
		 end;
	end;
	
	procedure converter_base (var v: vetor;var c: integer;t,num,base: integer);
	begin
		while num >= base do
		 begin
		  incluir_pilha(v,c,t,num mod base);
		  num := num div base;
		 end;
	  incluir_pilha(v,c,t,num);		
	end;
		
	procedure ordenar_vetor(var v:vetor;t:integer);
	var i,limite,troca,temp: integer; 
			trocou: boolean;    
	begin
	  limite := t - 1;
	  trocou := true;
	  while trocou do
	   begin
	    troca := limite;
	    trocou:=false;
	    for i := 1 to troca do
	      if v[i] > v[i+1] then
	       begin
	         temp := v[i];
	         v[i]:= v[i+1];
	         v[i+1]:= temp;   
	         limite := i;
	         trocou:=true;
	       end;
	   end;
	end;		 
	 
	procedure uniao_vetor(v1,v2: vetor;t1,t2: integer;var u: vetor;var t: integer);
	var i,p: integer;
	begin
	 	u[1] := v1[1];
	 	p := 2;
	 	for i := 2 to t1 do
	 		if not pertence(u,p-1,v1[i]) then
	 		 begin
	 		  u[p] := v1[i];
	 		  p := p + 1;
	 		 end;
		for i := 1 to t2 do
	 		if not pertence(u,p-1,v2[i]) then
	 		 begin
	 		  u[p] := v2[i];
	 		  p := p + 1;
	 		 end;
		t := p - 1;
	end;	
	 
	procedure interseccao_vetor(v1,v2: vetor;t1,t2: integer;var it: vetor;var t: integer);
	var i,p: integer; 
	begin
	 	p := 1;
	 	for i := 1 to t1 do
	 		if not pertence(it,p-1,v1[i]) and pertence(v2,t2,v1[i]) then
	 		 begin
	 		  it[p] := v1[i];
	 		  p := p + 1;
	 		 end; 
		t := p - 1;
	end;
	 
	procedure diferenca_vetor(v1,v2: vetor;t1,t2: integer;var d: vetor;var t: integer);
	var i,p: integer;
	begin
	 	p := 1;
	 	for i := 1 to t1 do	
	 		if not pertence(d,p-1,v1[i]) and not pertence(v2,t2,v1[i]) then
	 		 begin
	 		  d[p] := v1[i];
	 		  p := p + 1;
	 		 end;  
		t := p - 1;
	end;	
	 		 			 						 						 
	procedure baskara(a,b,c: real; var x1,x2: real);                
	var d: real;                                                           
	begin
		if tem_raiz(a,b,c) then
		begin
			x1 := (-b + sqrt(sqr(b) -4 * a * c)) / (2 * a);
		  x2 := (-b - sqrt(sqr(b) -4 * a * c)) / (2 * a);   
		end 
		else	
			write('Não tem raíz');			                                                   
	end;
	    
Begin    
end.