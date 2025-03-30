Program VendaIngresso;

uses Biblioteca;

const
    Arq = 1500;
    Ger = 850;
    Soc = 200;
    Nor = 2350;
    Vis = 350;

type
		vetor = array[1..2500] of integer;
    
var Sair: boolean;

		TotArqSo, TotArqNo, TotGerNo, TotGerVi, Nvenda,
		CLA,CLG,CLV,CFS,CFN,CFV,CPA,CPG: integer;
		LA,LG,LV,  FS,FN,FV,  PA,PG: vetor; 

procedure PreencherListas(var LA,LG,LV: vetor;var CLA,CLG,CLV:integer;A,G,V: integer);
var i: integer;
begin
	for i := 1 to A do
		incluir_lista(LA,CLA,A,i);
	for i := 1 to G do
		incluir_lista(LG,CLG,G,i + A);
	for i := 1 to V do
		incluir_lista(LV,CLV,V,i + A + G);
	for i := 1 to A do
		incluir_pilha(PA,CPA,A,i);
	for i := 1 to G + V do
		incluir_pilha(PG,CPG,G + V,i);	
end;
	
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
		
procedure Info(TArqSo, TArqNo, TGerNo, TGerVi: integer);
begin
	clrscr;
  writeln('=====IFORMAÇÕES=====');
	writeln('Vandas Arquibancadas:');
	writeln('Sócios: ',TArqSo * 70);   
	writeln('Normais: ',TArqNo * 150);
	writeln;
	writeln('Vandas Geral:');                  
	writeln('Normais: ',TGerNo * 50);   
	writeln('Visitantes: ',TGerVi * 100);
	writeln;
	writeln('Ingressos disponíveis:');
	writeln('Arquibancada: ',consultar_pilha(PA,CPA));
	writeln('Geral: ',consultar_pilha(PG,CPG));
	writeln;
	writeln('Renda total: ',(TArqSo * 70 + TArqNo * 150 + TGerNo * 50 + TGerVi * 100));
end;

procedure VendaSo(var FS,LA: vetor; var TArqSo,n,CFS,CLA: integer);
var Ass: integer;
begin
	if cheia(CFS,Soc) then
		writeln('Não há mais ingressos disponíveis para sua categoria.')
	else
	begin
		writeln('Ingresso arquibancada: R$70,00');
		writeln('Assentos disponíveis:');
		escrever_vetor(LA,CLA);
		writeln;
		
		Sair := False;
		while not Sair do
  	begin
	    ler_inteiro('Qual assento deseja?',Ass);
		 	if pertence_ordenado(LA,CLA,Ass) then
			begin
				remover_lista(LA,CLA,Ass);
				incluir_fila(FS,CFS,Soc,Ass);
				remover_pilha(PA,CPA);
				inc(TArqSo); 
				inc(n);
				Sair := True;
			end;     
 		end;				
	end;
end;

procedure VendaNo(var FN,LA,LG: vetor; var TArqNo,TGerNo,n,CFN,CLA,CLG: integer);
var Ass: integer;
begin
	if cheia(CFN,Nor) then
		writeln('Não há mais ingressos disponíveis para sua categoria.')
	else
	begin
		if (not vazia(CLA)) and (not vazia(CLG)) then 
		begin
			writeln('Ingresso arquibancada: R$150,00');
			writeln('Ingresso geral: R$50,00');
			if Opcoes('Geral G | Arquibancada A','G','A',' ',' ',' ') = 'A' then
	    			
			begin			
				writeln('Assentos disponíveis arquibancada:');
				escrever_vetor(LA,CLA);
				writeln;
				
				Sair := False;
				while not Sair do
		  	begin
			    ler_inteiro('Qual assento deseja?',Ass);
				 	if pertence_ordenado(LA,CLA,Ass) then
					begin
						remover_lista(LA,CLA,Ass);
						incluir_fila(FN,CFN,Nor,Ass);
						remover_pilha(PA,CPA);
						inc(TArqNo);
						inc(n); 
						Sair := True;
					end;     
		 		end;		 		
			end
						
	    else
	    begin	    
				writeln('Assentos disponíveis geral:');
				escrever_vetor(LG,CLG);
				writeln;
								
				Sair := False;
				while not Sair do
		  	begin
			    ler_inteiro('Qual assento deseja?',Ass);
				 	if pertence_ordenado(LG,CLG,Ass) then
					begin
						remover_lista(LG,CLG,Ass);
						incluir_fila(FN,CFN,Nor,Ass);
						Remover_pilha(PG,CPG);
						inc(TGerNo); 
						inc(n);
						Sair := True;
					end;     
		 		end;
			end;
			
		end		
		else if (not vazia(CLA)) and (vazia(CLG)) then 
		begin
			writeln('Ingresso arquibancada: R$150,00');
			writeln('Assentos disponíveis:');
			escrever_vetor(LA,CLA);	
			writeln;
					
			Sair := False;
			while not Sair do
	  	begin
		    ler_inteiro('Qual assento deseja?',Ass);
			 	if pertence_ordenado(LA,CLA,Ass) then
				begin
					remover_lista(LA,CLA,Ass);
					incluir_fila(FN,CFN,Nor,Ass);
					remover_pilha(PA,CPA);
					inc(TArqNo); 
					inc(n);
					Sair := True;
				end;     
	 		end;
		end
		else if (vazia(CLA)) and (not vazia(CLG)) then 
		begin
			writeln('Ingresso geral: R$50,00');
			writeln('Assentos disponíveis:');
			escrever_vetor(LG,CLG);
			writeln; 
			
			Sair := False;
			while not Sair do
	  	begin
		    ler_inteiro('Qual assento deseja?',Ass);
			 	if pertence_ordenado(LG,CLG,Ass) then
				begin
					remover_lista(LG,CLG,Ass);
					incluir_fila(FN,CFN,Nor,Ass);
					remover_pilha(PG,CPG);
					inc(TGerNo); 
					inc(n);
					Sair := True;
				end;     
	 		end;
		end
		else
			write('Não há ingressos disponíveis.');		 				
	end;
end;

procedure VendaVi(var FV,LV: vetor; var TGerVi,n,CFV,CLV: integer);
var Ass: integer;
begin
	if cheia(CFV,Vis) then
		writeln('Não há mais ingressos disponíveis para sua categoria.')
	else
	begin
		writeln('Ingresso geral: R$100,00');
		writeln('Assentos disponíveis:');
		escrever_vetor(LV,CLV);
		writeln;
		
		Sair := False;
		while not Sair do
  	begin
	    ler_inteiro('Qual assento deseja?',Ass);
		 	if pertence_ordenado(LV,CLV,Ass) then
			begin
				remover_lista(LV,CLV,Ass);
				incluir_fila(FV,CFV,Vis,Ass);
				remover_pilha(PG,CPG);
				inc(TGerVi);
				inc(n); 
				Sair := True;
			end;     
 		end;				
	end;
end;

procedure Venda(var FS,FN,FV,LV,LA,LG: vetor; 
								var TGerVi,TArqSo,TArqNo,TGerNo,n,CFS,CFN,CFV,CLA,CLG,CLV: integer);
begin
	clrscr;
  writeln('=====VENDA - ',n,'=====');
  
  Sair := False;
  while not Sair do
  begin
  	Sair := True;
	  case Opcoes('Sócio S | Normal N | Visitante V','S','N','V',' ',' ') of
		  'S': VendaSo(FS,LA,TArqSo,n,CFS,CLA);
		  'N': VendaNo(FN,LA,LG,TArqNo,TGerNo,n,CFN,CLA,CLG);
		  'V': VendaVi(FV,LV,TGerVi,n,CFV,CLV);
	  else
	  	Sair := False;
  	end;
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

begin
	PreencherListas(LA,LG,LV,CLA,CLG,CLV,Arq,Ger,Vis);
	Nvenda := 1;
  Sair := False;
  while not Sair do
  begin
    if Opcoes('venda V | info I','V','I',' ',' ',' ') = 'I' then
    	Info(TotArqSo, TotArqNo, TotGerNo, TotGerVi)
    else
    	Venda(FS,FN,FV,LV,LA,LG,TotGerVi,TotArqSo,TotArqNo,TotGerNo,Nvenda,CFS,CFN,CFV,CLA,CLG,CLV);   	
   VerificarContinuidade;
  end;
end.
