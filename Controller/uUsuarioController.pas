unit uUsuarioController;

interface

uses uDadosUsuario;

type

TUsuarioController = class
private
  { private declarations }
protected
  { protected declarations }
public
  procedure ValidarCampos(DadosUsuario: TDadosUsuario);
published
  { published declarations }
end;

implementation

uses
  System.SysUtils, uEDataInvalidaException, System.DateUtils,
  uEValidaDadosUsuarioException;

{ TUsuarioController }

procedure TUsuarioController.ValidarCampos(DadosUsuario: TDadosUsuario);
begin
  if DadosUsuario.DataNascimento >= Now then
    raise EDataInvalidaException.Create('Data de nascimento n?o pode ser maior que a data atual');

  if DadosUsuario.DataPrimeiraContribuicao < DadosUsuario.DataNascimento then
    raise EDataInvalidaException.Create('A data de contribui??o deve ser maior que a data de nascimento');

  if DadosUsuario.Sexo = 'M' then
  begin
    if (DadosUsuario.TipoAposentadoria = 'N') then
    begin
      if ((YearsBetween(Now, DadosUsuario.DataNascimento) >= 67) and (MonthsBetween(Now, DadosUsuario.DataPrimeiraContribuicao) >= 384)) then // 384 = 32 anos de contribuicao
        raise EValidaDadosUsuarioException.Create('O Contribuinte j? encontra-se aposentado');
    end;

    if (DadosUsuario.TipoAposentadoria = 'R') then
    begin
      if ((YearsBetween(Now, DadosUsuario.DataNascimento) >= 67) and (MonthsBetween(Now, DadosUsuario.DataPrimeiraContribuicao) >= 300)) then  // 300 = 25 anos de contribuicao
        raise EValidaDadosUsuarioException.Create('O Contribuinte j? encontra-se aposentado');
    end;
  end;

  if DadosUsuario.Sexo = 'F' then
  begin
    if (DadosUsuario.TipoAposentadoria = 'N') then
    begin
      if ((YearsBetween(Now, DadosUsuario.DataNascimento) >= 63) and (MonthsBetween(Now, DadosUsuario.DataPrimeiraContribuicao) >= 384)) then  // 384 = 32 anos de contribuicao
        raise EValidaDadosUsuarioException.Create('A Contribuinte j? encontra-se aposentada');
    end;

    if (DadosUsuario.TipoAposentadoria = 'R') then
    begin
      if ((YearsBetween(Now, DadosUsuario.DataNascimento) >= 63) and (MonthsBetween(Now, DadosUsuario.DataPrimeiraContribuicao) >= 300)) then  // 300 = 25 anos de contribuicao
        raise EValidaDadosUsuarioException.Create('A Contribuinte j? encontra-se aposentada');
    end;
  end
end;

end.
