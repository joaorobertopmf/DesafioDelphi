unit uSimulacao;

interface

uses uDadosUsuario;

type

TSimulacao = class
private
    FPercentual: Double;
    FValorMensal: Currency;
    FQtdeContribuicoes: Integer;
    FDataUltimaContribuicao: TDateTime;
    FIDSimulacao: Integer;
    procedure SetDataUltimaContribuicao(const Value: TDateTime);
    procedure SetPerceltual(const Value: Double);
    procedure SetQtdeContribuicoes(const Value: Integer);
    procedure SetValorMensal(const Value: Currency);
    procedure SetIDSimulacao(const Value: Integer);
  { private declarations }
protected
  { protected declarations }
public
  property  IDSimulacao: Integer read FIDSimulacao write SetIDSimulacao;
  property  QtdeContribuicoes: Integer read FQtdeContribuicoes write SetQtdeContribuicoes;
  property  DataUltimaContribuicao: TDateTime read FDataUltimaContribuicao write SetDataUltimaContribuicao;
  property  ValorMensal: Currency read FValorMensal write SetValorMensal;
  property  Percentual: Double read FPercentual write SetPerceltual;
  procedure RealizarSimulacao(PDadosUsuario: TDadosUsuario);

published
  { published declarations }
end;

implementation

uses
  System.SysUtils, System.DateUtils, Math, uESimulacaoException;
{ TSimulacao }

procedure TSimulacao.RealizarSimulacao(PDadosUsuario: TDadosUsuario);
var
  myDate : TDateTime;
  LDiaDoMesPrimeiraContribuicao, LDiaDoMesDataAtual: Integer;
  LQtdeAnos, LQtdeMesesContribuidos, LQtdeMesesFaltaContribuir: Integer;
  LValorContribuir: Currency;
  LPercentualContribuir: Double;
  LAnosContribuidos, LQtdeMesesRestanteContribuicaoPorIdade, LQtdeMesesRestanteContribuicaoPorTempo : Integer;
  LMilharSalario: Integer;
  LDataUltimaContribuicaoPorTempo, LDataUltimaContribuicaoPorIdade: TDateTime;
  myYear, myMonth, myDay : Word;
  LAdicional: Integer;
begin

  LAdicional := 0;

  // Calculo Percentual
  if PDadosUsuario.Salario <= 998.00 then
  begin
    Self.FPercentual := 7.5;
  end
  else if (PDadosUsuario.Salario > 998.00) and (PDadosUsuario.Salario <= 2000) then
    begin
      Self.FPercentual := 8.5;
    end
    else if (PDadosUsuario.Salario > 2000) and (PDadosUsuario.Salario <= 3000) then
      begin
        Self.FPercentual := 9.5
      end
      else if (PDadosUsuario.Salario > 3000) and (PDadosUsuario.Salario <= 5000) then
        begin
          Self.FPercentual := 10.5;
        end
        else
          begin
            // Caso Sal?rio for  maior que 5000
            LMilharSalario := Round(PDadosUsuario.Salario / 1000) - 5;
            Self.FPercentual := 13 + 0.5 * LMilharSalario;
          end;

  LDiaDoMesPrimeiraContribuicao := DayOfTheMonth(PDadosUsuario.DataPrimeiraContribuicao);
  LDiaDoMesDataAtual            := DayOfTheMonth(Now);

  LQtdeMesesContribuidos := MonthsBetween(Now, PDadosUsuario.DataPrimeiraContribuicao) + 1;

  if LDiaDoMesPrimeiraContribuicao <= DayOfTheMonth(PDadosUsuario.DataNascimento) then
    LAdicional := 1
  else
    LAdicional := 0;

  if PDadosUsuario.TipoAposentadoria = 'N' then
  begin
    LQtdeMesesRestanteContribuicaoPorTempo := 384 - LQtdeMesesContribuidos; // 32 anos de contribuicao = 384
    LDataUltimaContribuicaoPorTempo := IncMonth(PDadosUsuario.DataPrimeiraContribuicao, 383);
  end
  else
    begin
      LQtdeMesesRestanteContribuicaoPorTempo := 300 - LQtdeMesesContribuidos; // 25 anos de contribuicao = 300
      LDataUltimaContribuicaoPorTempo := IncMonth(PDadosUsuario.DataPrimeiraContribuicao, 299);
      FPercentual := FPercentual + FPercentual/2;
    end;

  Self.FValorMensal := PDadosUsuario.Salario  * (Self.FPercentual / 100);


  // C?lculo da Contribui??o por Idade Considerando o sexo
  if PDadosUsuario.Sexo = 'M' then
  begin
    LQtdeMesesRestanteContribuicaoPorIdade := 804 - MonthsBetween(Now, PDadosUsuario.DataNascimento);   // 67 anos = 804 Meses
    LDataUltimaContribuicaoPorIdade := IncMonth(PDadosUsuario.DataNascimento, 803 + LAdicional);
  end
  else
    begin
      LQtdeMesesRestanteContribuicaoPorIdade := 756 - MonthsBetween(Now, PDadosUsuario.DataNascimento);  // 63 anos = 756 Meses
      LDataUltimaContribuicaoPorIdade := IncMonth(PDadosUsuario.DataNascimento, 755 + LAdicional);
    end;

  LDataUltimaContribuicaoPorIdade := EncodeDate(YearOf(LDataUltimaContribuicaoPorIdade), MonthOf(LDataUltimaContribuicaoPorIdade), DayOf(PDadosUsuario.DataPrimeiraContribuicao));

  // Caso o usu?rio j? esteja aposentado
  if (LQtdeMesesRestanteContribuicaoPorTempo <= 0) and (LQtdeMesesRestanteContribuicaoPorIdade <= 0) then
  begin
    raise ESimulacaoException.Create('Usu?rio j? encontra-se aposentado!');
  end;


  // Calculo Qtde Meses Contribuicao
  if LQtdeMesesRestanteContribuicaoPorIdade > LQtdeMesesRestanteContribuicaoPorTempo then
  begin
    FDataUltimaContribuicao := LDataUltimaContribuicaoPorIdade;
    Self.FQtdeContribuicoes := LQtdeMesesRestanteContribuicaoPorIdade;
  end
  else
    begin
      FDataUltimaContribuicao := LDataUltimaContribuicaoPorTempo;
      Self.FQtdeContribuicoes := LQtdeMesesRestanteContribuicaoPorTempo;
    end;



end;

procedure TSimulacao.SetDataUltimaContribuicao(const Value: TDateTime);
begin
  FDataUltimaContribuicao := Value;
end;

procedure TSimulacao.SetIDSimulacao(const Value: Integer);
begin
  FIDSimulacao := Value;
end;

procedure TSimulacao.SetPerceltual(const Value: Double);
begin
  FPercentual := Value;
end;

procedure TSimulacao.SetQtdeContribuicoes(const Value: Integer);
begin
  FQtdeContribuicoes := Value;
end;

procedure TSimulacao.SetValorMensal(const Value: Currency);
begin
  FValorMensal := Value;
end;

end.
