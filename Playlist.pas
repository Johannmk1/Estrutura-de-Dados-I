Program Playlist; //lista de musicas duplamente encadeada

uses biblioteca;

type  Ptlist = ^Tlist;
			Tlist = record
				musica: string;
				artista: string;
				duracao: integer;
				ant: Ptlist;
				prox: Ptlist;
			end;
			
var playlist, final: Ptlist;
		sair: boolean;

function vaziaa(P: Ptlist): boolean;
begin
	if P = nil then
		vaziaa := true
	else
		vaziaa := false;
end;

procedure inicializar(var P,F: Ptlist);
begin
	P := nil;
	F := nil;
end;

function newMusic(var mus,art: string; dur: integer; var anterior,proximo: Ptlist): Ptlist;
var novo: Ptlist;
begin
	new(novo);
	if novo = nil then 
		writeln('Memória cheia')
	else
		with novo^ do
		begin
			musica := mus;
			artista := art;
			dur := dur;
			ant := anterior;
			prox := proximo;
		end;
	newMusic := novo;
end;

procedure incluirPri(var P,F: Ptlist; mus,art: string; dur: integer);
var novo,nill: Ptlist;
begin
	nill := nil;
	novo := newMusic(mus, art, dur, nill, nill);
	P := novo;
	F := novo;
end;

procedure incluirIni(var P: Ptlist; mus,art: string; dur: integer);
var novo,nill: Ptlist;
begin
	nill := nil;
	novo := newMusic(mus, art, dur, nill, P);
	P^.ant := novo;
	P := novo;
end;

procedure incluirFim(var F: Ptlist; mus,art: string; dur: integer);
var novo,nill: Ptlist;
begin
	nill := nil;
	novo := newMusic(mus, art, dur, F, nill);
	F^.prox := novo;
	F := novo;
end;

procedure incluir(var P,F: Ptlist);
var mus, art: string;
		dur: integer;
begin
	mus := ler_str('Qual o nome da musica? ');
	art := ler_str('Qual o nome do artista? ');
	dur := ler_int('Quantos segundos tem a musica? ');
	if vaziaa(P) then
		incluirPri(P,F,mus,art,dur)
	else 
		if Opcoes('Incluir no início I | Incluir no final F','I','F',' ',' ',' ') = 'I' then
			incluirIni(P,mus,art,dur)
		else
			incluirFim(F,mus,art,dur);
end;

procedure listarP(var P: Ptlist);
var atual: Ptlist;
begin
	if vaziaa(P) then
		writeln('Não há musicas em sua Playlist')
	else
	begin
		atual := P;
		writeln('Playlist');
		writeln('	Musica		|	Artista		|	Duração		');
		while atual <> nil do
		begin
			writeln(atual^.musica:3,'		', atual^.artista:3,'		', atual^.duracao);
			atual := atual^.prox;
		end;
	end;  
end;


Begin
	inicializar(playlist, final);
	while not sair do
		case Opcoes('Incluir I | Listar L | Sair S','I','L','S',' ',' ') of
			'I': incluir(playlist, final);
			'L': listarP(playlist);
			'S': sair := true;
		end;  
End.