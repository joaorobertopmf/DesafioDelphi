unit uDadosUsuario;

interface

type

TDadosUsuario = record
  DataNascimento: TDateTime;
  TipoAposentadoria: Char;
  DataPrimeiraContribuicao: TDateTime;
  Salario: Currency;
  Sexo: Char;
  procedure InicializarValores;
end;

implementation

{ TDadosUsuarioRec }

procedure TDadosUsuario.InicializarValores;
begin
  Self:= Default(TDadosUsuario);
end;

end.
