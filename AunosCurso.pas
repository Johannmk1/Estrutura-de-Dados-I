Program RegEncLista;

uses biblioteca;

type  Ptaluno = ^Taluno;
		  Taluno = record
		    nome: string;
		    prox: Ptaluno;
		  end;

			Ptcurso = ^Tcurso;
		  Tcurso = record
		    sigla: string;
		    aluno: Ptaluno;
		    prox: Ptcurso;
		  end;

var curso: Ptcurso;
  	sair: boolean;

function vaziac(C: Ptcurso): boolean;
begin
  vaziac := C = nil;
end;

function vaziaa(A: Ptaluno): boolean;
begin
  vaziaa := A = nil;  
end;

procedure inicializar(var C: Ptcurso);
begin
  C := nil;
end;

procedure incluir_aluno(var A: Ptaluno;nome: string);
var novo, ant, atual: Ptaluno;
begin
  New(novo);
  if novo = nil then
    Writeln('Mem�ria cheia')
  else
  begin
    novo^.nome := nome;
    ant := nil;
    atual := A;
    while (atual <> nil) and (atual^.nome < nome) do
    begin
      ant := atual;
      atual := atual^.prox;
    end;
    if ant = nil then //primeiro elemento
    begin
      novo^.prox := A;
      A := novo;
    end
    else //adicionar na lista em sua posicao
    begin
      ant^.prox := novo;
      novo^.prox := atual;
		end;
  end;
end;

procedure incluir(var C: Ptcurso; sig,alu: string);
var novo, ant, atual: Ptcurso;
begin
  New(novo);
  if novo = nil then
    Writeln('Mem�ria cheia')
  else
  begin
    novo^.sigla := sig;
    ant := nil;
    atual := C;
    while (atual <> nil) and (atual^.sigla < sig) do
    begin
      ant := atual;
      atual := atual^.prox;
    end;
    if (ant = nil) and (atual^.sigla <> sig) then //primeiro elemento
    begin
      novo^.prox := C;
      C := novo;
      new(novo^.aluno);
			novo^.aluno^.nome := alu;
      novo^.aluno^.prox := nil;
    end
    else if atual^.sigla <> sig then //adicionar na lista em sua posicao
    begin
      ant^.prox := novo;
      novo^.prox := atual;
      new(novo^.aluno);
			novo^.aluno^.nome := alu;
      novo^.aluno^.prox := nil;
    end
		else //ja existe
    incluir_aluno(atual^.aluno,alu);
  end;
end;

procedure escrever_curso(C: Ptcurso);
var aux: Ptcurso;
begin
  if vaziac(C) then
    Writeln('Sua lista de cursos est� vazia')
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

procedure escrever_aluno(C: Ptcurso);
var aux: Ptcurso;
		aux2: Ptaluno;
begin
  if vaziac(C) then
    Writeln('Sua lista de cursos est� vazia')
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

procedure remover_aluno(var A: Ptaluno; sig,alu: string);
var aux, ant: Ptaluno;
	  achou: boolean;
begin
  if vaziaa(A) then
    Writeln('Sua lista est� vazia')
  else
  begin
    aux := A;
    ant := nil;
    achou := False;
    while (aux <> nil) and (not achou) do
    begin
      if aux^.nome = alu then
      begin
				if ant = nil then
          A := aux^.prox
        else
          ant^.prox := aux^.prox;
			  Dispose(aux);
      	Writeln('Aluno ', alu, ' removido do curso ', sig);
				achou := True;
      end
      else
      begin
        ant := aux;
        aux := aux^.prox;
      end;
		end;		
    if not achou then
      Writeln('Aluno ', alu, ' n�o encontrado na lista');
  end;
end;

procedure remover(var C: Ptcurso; sig,alu: string);
var aux, ant: Ptcurso;
	  achou: boolean;
begin
  if vaziac(C) then
    Writeln('Sua lista est� vazia')
  else
  begin
    aux := C;
    ant := nil;
    achou := False;
    while (aux <> nil) and (not achou) do
    begin
      if aux^.sigla = sig then
      begin
        remover_aluno(aux^.aluno,sig,alu);
				if aux^.aluno = nil then
				begin
					if ant = nil then
	          C := aux^.prox
	        else
	          ant^.prox := aux^.prox;
				  Dispose(aux);
        	Writeln('Curso ', sig, ' removido');
				end;
				achou := True;
      end
      else
      begin
        ant := aux;
        aux := aux^.prox;
      end;
		end;		
    if not achou then
      Writeln('Curso ', sig, ' n�o encontrado na lista');
  end;
end;



begin
  inicializar(curso);
  sair := False;
  while not sair do
    case Opcoes('Incluir I | Remover R | Escrever Curso C | Escrever Aluno A | Sair S ','I','R','C','A','S') of
      'I': incluir(curso, ler_str('De qual curso pertence? '), ler_str('Qual nome quer incluir? '));  
      'R': remover(curso, ler_str('De qual curso pertence? '), ler_str('Qual nome quer remover? '));                                      
      'C': escrever_curso(curso);                                    
      'A': escrever_aluno(curso);                                     
      'S': begin                                                 
             sair := True;
             Writeln;
             Writeln('Voc� saiu');
           end;
    end;
end.
