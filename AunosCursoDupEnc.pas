Program AunosCursoDupEnc;

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

procedure define_var_curso(C: Ptcurso; var ant,atual,prox: Ptcurso);
begin
  ant := nil; 
  atual := C;
  if atual <> nil then
  	prox := atual^.prox
  else 
  	prox := nil;
end;

procedure define_var_aluno(A: Ptaluno; var ant,atual,prox: Ptaluno);
begin
  ant := nil; 
  atual := A;
  if atual <> nil then
  	prox := atual^.prox
  else 
  	prox := nil;
end;

procedure andar_curso(var ant,atual,prox: Ptcurso);
begin
  ant := atual; 
  atual := atual^.prox;
  if atual <> nil then
  	prox := atual^.prox
  else 
  	prox := nil;
end;

procedure andar_aluno(var ant,atual,prox: Ptaluno);
begin
  ant := atual; 
  atual := atual^.prox;
  if atual <> nil then
  	prox := atual^.prox
  else 
  	prox := nil;
end;

procedure incluir_primeiro_aluno(var A,U: Ptaluno;nome: string);
var novo: Ptaluno;
begin
	new(novo);				
	novo^.nome := nome;
	novo^.ant := nil;
  novo^.prox := nil;
  A := novo;
  U := novo;
end;

procedure incluir_aluno(var A,U: Ptaluno;nome: string);
var novo, ant, atual, prox: Ptaluno;
begin
  New(novo);
  if novo = nil then
    Writeln('Memória cheia')
  else
  begin
    novo^.nome := nome;
    define_var_aluno(A,ant,atual,prox);
    while (atual <> nil) and (atual^.nome < nome) do //anda na lista
	    andar_aluno(ant,atual,prox);
    if ant = nil then //aluno primeira posição
    begin
      novo^.prox := A;
      novo^.ant := nil;
		  A^.ant := novo;
      A := novo;
    end
    else if atual = nil then //adicionar na última posição
    begin
      ant^.prox := novo;
      novo^.ant := ant;
      U := novo;
		end
    else //adicionar no meio da lista
    begin
      ant^.prox := novo;
      novo^.ant := ant;
      novo^.prox := atual;
      atual^.ant := novo;
		end;
  end;
end;

procedure incluir(var C,U: Ptcurso; sig,alu: string);
var novo, ant, atual, prox: Ptcurso;
begin
  New(novo);
  if novo = nil then
    Writeln('Memória cheia')
  else
  begin
    novo^.sigla := sig;
    if C = nil then //primeiro curso da lista
  	begin
  		C := novo;
			U := novo;
			novo^.ant := nil;
			novo^.prox := nil;
			new(novo^.aluno);
			incluir_primeiro_aluno(novo^.aluno,novo^.ultimo,alu);	
		end
		else
		begin
	    define_var_curso(C,ant,atual,prox);
	    while (atual <> nil) and (atual^.sigla < sig) do //anda na lista cursos
		    andar_curso(ant,atual,prox);
	    if atual^.sigla = sig then //ja existe o curso
	    	incluir_aluno(atual^.aluno,atual^.ultimo,alu)
			else if ant = nil then //curso primeira posição
	    begin
        novo^.prox := C;
	      novo^.ant := nil;
			  C^.ant := novo;      
	      C := novo;
	      new(novo^.aluno);
	      incluir_primeiro_aluno(novo^.aluno,novo^.ultimo,alu);
	    end 
	    else if atual = nil then //insere no final
	    begin
		    novo^.prox := nil;
		    novo^.ant := U;
		    U^.prox := novo;
				U := novo;
				new(novo^.aluno);
				incluir_primeiro_aluno(novo^.aluno,novo^.ultimo,alu);
			end
			else //adicionar no meio da lista (ant - novo - atual)
	    begin
	    	ant^.prox := novo;
		    novo^.ant := ant;
				novo^.prox := atual;
				atual^.ant := novo;
				new(novo^.aluno);
				incluir_primeiro_aluno(novo^.aluno,novo^.ultimo,alu);
			end;
		end;	
  end;
end;

procedure escrever_curso(C: Ptcurso);
var atual: Ptcurso;
begin
  if vaziac(C) then
    Writeln('Sua lista de cursos está vazia')
  else
  begin
    Write('Cursos: ');
    atual := C;
    while atual <> nil do
    begin
      Write(atual^.sigla:4);
      atual := atual^.prox;
    end;
    Writeln;
  end;
end;

procedure escrever_curso_invertido(U: Ptcurso);
var atual: Ptcurso;
begin
  if vaziac(U) then
    Writeln('Sua lista de cursos está vazia')
  else
  begin
    Write('Cursos: ');
    atual := U;
    while atual <> nil do
    begin
      Write(atual^.sigla:4);
      atual := atual^.ant;
    end;
    Writeln;
  end;
end;

procedure escrever_aluno(C: Ptcurso);
var cur: Ptcurso;
		alu: Ptaluno;
begin
  if vaziac(C) then
    Writeln('Sua lista de cursos está vazia')
  else
  begin
    Writeln('Cursos/Alunos: ');
    cur := C;
    while cur <> nil do
    begin
      write(cur^.sigla:4,': '); //escreve curso
      alu := cur^.aluno;
	    while alu <> nil do
	    begin
	      Write(alu^.nome:4,' '); //escreve aluno
	      alu := alu^.prox;
	    end;
      cur := cur^.prox;
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

procedure escrever(C,U: Ptcurso);
begin
	write('Escrever: ');
	case Opcoes('Cursos 1 | Cursos Invertido 2 | Alunos 3 | Alunos Invertido 4 ','1','2','3','4',' ') of
    '1': escrever_curso(C); 
		'2': escrever_curso_invertido(U);                                  
    '3': escrever_aluno(C);                                  
    '4': escrever_aluno_invertido(U);                                         
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
    define_var_aluno(A,ant,atual,prox);
    achou := False;
    while (atual <> nil) and (not achou) do
    begin
      if atual^.nome = alu then
      begin
				if ant = nil then //remove o primeiro
				begin
					if prox = nil then //remove unico aluno existente
					begin
						A := nil;
						U := nil;
					end
					else //remove o primeiro
					begin
          	A := prox;
          	A^.ant := nil;
        	end;
        end
        else if prox = nil then //remove da ultima posição
        begin
        	U := ant;
					U^.prox := nil;	
        end
        else
        begin //Remove do meio
					ant^.prox := prox;
	        prox^.ant := ant;
        end;
			  Dispose(atual);
      	Writeln('Aluno ', alu, ' removido do curso ', sig);
				achou := True;
      end
      else //anda na lista alunos
	      andar_aluno(ant,atual,prox);
		end;		
    if not achou then
      Writeln('Aluno ', alu, ' não encontrado no curso ', sig);
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
    define_var_curso(C,ant,atual,prox);
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
						if prox = nil then //remove único curso existente
						begin
							C := nil;
							U := nil;	
						end
						else //remove curso primeira posição
						begin
	          	C := prox;
	          	C^.ant := nil;
	          end;
	        end
	        else if prox = nil then //remove o último curso
	        begin
	        	U := ant;
	        	U^.prox := nil;
	        end
					else //remove do meio
	        begin
	          ant^.prox := prox;  
	          prox^.ant := ant;
	        end;  
				  Dispose(atual);
        	Writeln('Curso ', sig, ' removido');
				end;
				achou := True;
      end
      else //anda na lista cursos
        andar_curso(ant,atual,prox);
		end;		
    if not achou then
      Writeln('Curso ', sig, ' não encontrado na lista');
  end;
end;



begin
  inicializar(curso,ultimo);
  sair := False;
  while not sair do
    case Opcoes('Incluir I | Remover R | Escrever E | Sair S ','I','R','E','S',' ') of
      'I': incluir(curso, ultimo, ler_str('De qual curso pertence? '), ler_str('Qual nome quer incluir? '));  
      'R': remover(curso, ultimo, ler_str('De qual curso pertence? '), ler_str('Qual nome quer remover? '));                                      
			'E': escrever(curso,ultimo);
//      'C': escrever_curso(curso);              Escrever Curso C | Escrever Aluno A |                      
//      'A': escrever_aluno(curso); 
//			'C': escrever_curso_invertido(ultimo);                                    
//      'A': escrever_aluno_invertido(ultimo);                                     
      'S': begin                                                 
             sair := True;
             Writeln;
             Writeln('Você saiu');
           end;
    end;
end.
