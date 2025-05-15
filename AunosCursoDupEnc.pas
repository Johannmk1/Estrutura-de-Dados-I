Program RegEncLista;

uses biblioteca;

type  Ptaluno = ^Taluno;
		  Taluno = record
		    nome: string;
		    ant: Ptaluno;
				prox: Ptaluno;
		  end;

			Ptcurso = ^Tcurso;
		  Tcurso = record
		    sigla: string;
		    aluno: Ptaluno;
		    ant: Ptcurso;
				prox: Ptcurso;
				ultimo: Ptaluno;
		  end;

var curso,ultimo: Ptcurso;
  	sair: boolean;

function vaziac(C: Ptcurso): boolean;
begin
  vaziac := C = nil;
end;

function vaziaa(A: Ptaluno): boolean;
begin
  vaziaa := A = nil;  
end;

procedure inicializar(var C: Ptcurso; var U: Ptcurso);
begin
  C := nil;
  U := nil;
end;

procedure incluir_aluno(var A,U: Ptaluno;nome: string);
var novo, ant, atual: Ptaluno;
begin
  New(novo);
  if novo = nil then
    Writeln('Memória cheia')
  else
  begin
    novo^.nome := nome;
    ant := nil;
    atual := A;
    while (atual <> nil) and (atual^.nome < nome) do //anda na lista
    begin
      ant := atual; 
      atual := atual^.prox;
    end;
    if ant = nil then //aluno primeira posição
    begin
      novo^.prox := A;
      novo^.ant := nil;
		  if A <> nil then
		    A^.ant := novo;
      A := novo;
    end
    else if atual = nil then //adicionar na última posição
    begin
      ant^.prox := novo;
      novo^.ant := ant;
      U := novo;
		end
    else //adicionar na lista em sua posicao
    begin
      ant^.prox := novo;
      novo^.ant := ant;
      novo^.prox := atual;
      if atual <> nil then
      	atual^.ant := novo;
		end;
  end;
end;

procedure incluir(var C,U: Ptcurso; sig,alu: string);
var novo, ant, atual: Ptcurso;
begin
  New(novo);
  if novo = nil then
    Writeln('Memória cheia')
  else
  begin
    novo^.sigla := sig;
    ant := nil;
    atual := C;
    while (atual <> nil) and (atual^.sigla < sig) do //anda na lista cursos
    begin
      ant := atual;
      atual := atual^.prox;
    end;
    if (ant = nil) and (atual^.sigla <> sig) then //curso primeira posição
    begin
    	if C = nil then //primeiro curso da lista
    	begin
    		C := novo;
				U := novo;
			end
			else //curso primeira posição
			begin		
	      novo^.prox := C;
	      novo^.ant := nil;
			  if C <> nil then
			    C^.ant := novo;      
	      C := novo;
	    end;
      new(novo^.aluno); //primeiro aluno a ser inserido na lista
			novo^.aluno^.nome := alu;
			novo^.aluno^.ant := nil;
      novo^.aluno^.prox := nil;
      novo^.ultimo := novo^.aluno; 
    end
    else if atual^.sigla <> sig then //adicionar na lista em sua posicao (antes do atual)
    begin
    	ant^.prox := novo;
	    novo^.ant := ant;
    	if atual = nil then //insere no final
	      U := novo
	    else //insere no meio
	    begin
				novo^.prox := atual;
				atual^.ant := novo;
			end;	
      new(novo^.aluno); //primeiro aluno a ser inserido na lista
			novo^.aluno^.nome := alu;
      novo^.aluno^.prox := novo^.ultimo;
      novo^.ultimo^.ant := novo^.aluno;
      novo^.aluno^.ant := nil; 
    end
		else //ja existe o curso
    incluir_aluno(atual^.aluno,atual^.ultimo,alu);
  end;
end;

procedure escrever_curso(C: Ptcurso);
var aux: Ptcurso;
begin
  if vaziac(C) then
    Writeln('Sua lista de cursos está vazia')
  else
  begin
    Write('Cursos: ');
    aux := C;
    while aux <> nil do
    begin
      Write(aux^.sigla:4);
      aux := aux^.prox;
    end;
    Writeln;
  end;
end;

procedure escrever_curso_invertido(U: Ptcurso);
var cur: Ptcurso;
begin
  if vaziac(U) then
    Writeln('Sua lista de cursos está vazia')
  else
  begin
    Write('Cursos: ');
    cur := U;
    while cur <> nil do
    begin
      Write(cur^.sigla:4);
      cur := cur^.ant;
    end;
    Writeln;
  end;
end;

procedure escrever_aluno(C: Ptcurso);
var aux: Ptcurso;
		aux2: Ptaluno;
begin
  if vaziac(C) then
    Writeln('Sua lista de cursos está vazia')
  else
  begin
    Writeln('Cursos/Alunos: ');
    aux := C;
    while aux <> nil do
    begin
      write(aux^.sigla:4,': '); //escreve curso
      aux2 := aux^.aluno;
	    while aux2 <> nil do
	    begin
	      Write(aux2^.nome:4,' '); //escreve aluno
	      aux2 := aux2^.prox;
	    end;
      aux := aux^.prox;
      writeln;
    end;
  end;
end;

procedure escrever_aluno_invertido(U: Ptcurso);
var cur: Ptcurso;
		alu: Ptaluno;
begin
  if vaziac(U) then
    Writeln('Sua lista de cursos está vazia')
  else
  begin
    Writeln('Cursos/Alunos: ');
    cur := U;
    while cur <> nil do
    begin
      write(cur^.sigla:4,': '); //escreve curso
      alu := cur^.ultimo;
	    while alu <> nil do
	    begin
	      Write(alu^.nome:4,' '); //escreve aluno
	      alu := alu^.ant;
	    end;
      cur := cur^.ant;
      writeln;
    end;
  end;
end;

procedure remover_aluno(var A,U: Ptaluno; sig,alu: string);
var ant,atual,prox: Ptaluno;
	  achou: boolean;
begin
  if vaziaa(A) then
    Writeln('Sua lista está vazia')
  else
  begin
    atual := A;
    ant := nil;
    achou := False;
    while (atual <> nil) and (not achou) do
    begin
      if atual^.nome = alu then
      begin
				if ant = nil then //remove o primeiro
				begin
					if atual^.prox = nil then
					begin
						A := nil;
						U := nil;
					end
					else
					begin
          	A := atual^.prox;
          	A^.ant := nil;
        	end;
        end
        else if atual^.prox = nil then //remove o ultimo
        	U := ant	
        else
        begin //Remove do meio
          prox := atual^.prox;
					ant^.prox := prox;
	        prox^.ant := ant;
        end;
			  Dispose(atual);
      	Writeln('Aluno ', alu, ' removido do curso ', sig);
				achou := True;
      end
      else //anda na lista alunos
      begin
        ant := atual;
        atual := atual^.prox;
      end;
		end;		
    if not achou then
      Writeln('Aluno ', alu, ' não encontrado na lista');
  end;
end;

procedure remover(var C,U: Ptcurso; sig,alu: string);
var ant,atual,prox: Ptcurso;
	  achou: boolean;
begin
  if vaziac(C) then
    Writeln('Sua lista está vazia')
  else
  begin
    atual := C;
    ant := nil;
    achou := False;
    while (atual <> nil) and (not achou) do
    begin
      if atual^.sigla = sig then
      begin
        remover_aluno(atual^.aluno,atual^.ultimo,sig,alu);
				if atual^.aluno = nil then //lista de alunos está vazia
				begin
					if ant = nil then //remove o primeiro curso
					begin
						if atual^.prox = nil then
						begin
							C := nil;
							U := nil;	
						end
						else
						begin
	          	C := atual^.prox;
	          	C^.ant := nil;
	          end;
	        end
	        else if atual^.prox = nil then //remove o último
	        	U := ant
	        else //remove do meio
	        begin
	        	prox := atual^.prox;
	          ant^.prox := prox;  
	          prox^.ant := ant;
	        end;  
				  Dispose(atual);
        	Writeln('Curso ', sig, ' removido');
				end;
				achou := True;
      end
      else //anda na lista cursos
      begin
        ant := atual;
        atual := atual^.prox;
      end;
		end;		
    if not achou then
      Writeln('Curso ', sig, ' não encontrado na lista');
  end;
end;



begin
  inicializar(curso,ultimo);
  sair := False;
  while not sair do
    case Opcoes('Incluir I | Remover R | Escrever Curso C | Escrever Aluno A | Sair S ','I','R','C','A','S') of
      'I': incluir(curso, ultimo, ler_str('De qual curso pertence? '), ler_str('Qual nome quer incluir? '));  
      'R': remover(curso, ultimo, ler_str('De qual curso pertence? '), ler_str('Qual nome quer remover? '));                                      
//      'C': escrever_curso(curso);                                    
//      'A': escrever_aluno(curso); 
			'C': escrever_curso_invertido(ultimo);                                    
      'A': escrever_aluno_invertido(ultimo);                                     
      'S': begin                                                 
             sair := True;
             Writeln;
             Writeln('Você saiu');
           end;
    end;
end.
