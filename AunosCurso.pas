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

function vaziaa(C: Ptcurso): boolean;
begin
  vaziaa := C = nil;
end;

procedure inicializar(var C: Ptcurso);
begin
  C := nil;
end;

procedure incluir_aluno(A: Ptaluno;nome: string);
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
    Writeln('Memória cheia')
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
  if vaziaa(C) then
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

procedure escrever_aluno(C: Ptcurso);
var aux: Ptcurso;
		aux2: Ptaluno;
begin
  if vaziaa(C) then
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
    Writeln;
  end;
end;

procedure remover(var C: Ptcurso);
var valor: string;
	  aux, ant: Ptcurso;
	  achou: boolean;
begin
  if vaziaa(C) then
    Writeln('Sua lista está vazia')
  else
  begin
    valor := (ler_str('Qual aluno deseja remover? '));
    aux := C;
    ant := nil;
    achou := False;
    while (aux <> nil) and (not achou) do
    begin
      if aux^.sigla = valor then
      begin
        if ant = nil then
          C := aux^.prox
        else
          ant^.prox := aux^.prox;
        Dispose(aux);
        Writeln('Valor ', valor, ' removido da lista');
        achou := True;
      end
      else
      begin
        ant := aux;
        aux := aux^.prox;
      end;
    end;
    if not achou then
      Writeln('Valor ', valor, ' não encontrado na lista');
  end;
end;

begin
  inicializar(curso);
  sair := False;
  while not sair do
    case Opcoes('Incluir I | Remover R | Escrever Curso C | Escrever Aluno A | Sair S ','I','R','C','A','S') of
      'I': incluir(curso, ler_str('De qual curso pertence? '), ler_str('Qual nome quer incluir? '));  
      'R': remover(curso);                                      
      'C': escrever_curso(curso);                                    
      'A': escrever_aluno(curso);                                     
      'S': begin                                                 
             sair := True;
             Writeln;
             Writeln('Você saiu');
           end;
    end;
end.
