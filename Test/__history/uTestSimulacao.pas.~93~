unit uTestSimulacao;

interface

uses
  DUnitX.TestFramework, System.SysUtils, uSimulacao, uDadosUsuario;

type
  [TestFixture]
  TestTSimulacao = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [TestCase('Test1', '5000,14/02/1973,15/03/1993,M,N,223,15/01/2040,525,10.5')]
    [TestCase('Test2', '2500,14/02/1973,13/03/1993,M,N,223,13/02/2040,237.5,9.5')]
    procedure TestRealizarSimulacao(pSalario: Currency; pDataNascimento: TDateTime; pDataPrimeiraContribuicao: TDateTime; pSexo: Char; pTipoAposentadoria: Char;
                                    pQtdeContribuicoes: Integer; pDataUltimaContribuicao: TDateTime; pValorMensal: Currency; pPercentual: Double);

  private
    FDadosUsuario: TDadosUsuario;
    FSimulacao: TSimulacao;
    procedure PreencherRecord(pSalario: Currency; pDataNascimento: TDateTime; pDataPrimeiraContribuicao: TDateTime; pSexo: Char; pTipoAposentadoria: Char);
  end;

implementation

procedure TestTSimulacao.Setup;
begin
  FSimulacao := TSimulacao.Create;
  FDadosUsuario.InicializarValores;
end;

procedure TestTSimulacao.TearDown;
begin

  if Assigned(FSimulacao) then
    FreeAndNil(FSimulacao);

end;

procedure TestTSimulacao.TestRealizarSimulacao(pSalario: Currency; pDataNascimento: TDateTime; pDataPrimeiraContribuicao: TDateTime; pSexo, pTipoAposentadoria: Char;
                                               pQtdeContribuicoes: Integer; pDataUltimaContribuicao: TDateTime; pValorMensal: Currency; pPercentual: Double);
begin
  PreencherRecord(pSalario, pDataNascimento, pDataPrimeiraContribuicao, pSexo, pTipoAposentadoria);
  FSimulacao.RealizarSimulacao(FDadosUsuario);

  Assert.AreEqual(FSimulacao.QtdeContribuicoes, pQtdeContribuicoes);
  Assert.AreEqual(FSimulacao.DataUltimaContribuicao, pDataUltimaContribuicao);
  Assert.AreEqual(FSimulacao.ValorMensal, pValorMensal);
  Assert.AreEqual(FSimulacao.Percentual, pPercentual);
end;

procedure TestTSimulacao.PreencherRecord(pSalario: Currency; pDataNascimento: TDateTime; pDataPrimeiraContribuicao: TDateTime; pSexo, pTipoAposentadoria: Char);
begin
  FDadosUsuario.Salario                   := pSalario;
  FDadosUsuario.DataNascimento            := pDataNascimento;
  FDadosUsuario.DataPrimeiraContribuicao  := pDataPrimeiraContribuicao;
  FDadosUsuario.Sexo                      := pSexo;
  FDadosUsuario.TipoAposentadoria         := pTipoAposentadoria;
end;

initialization
  TDUnitX.RegisterTestFixture(TestTSimulacao);

end.
