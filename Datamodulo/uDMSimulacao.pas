unit uDMSimulacao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uIBaseEntity, uSimulacao,
  System.Generics.Collections;

type

  TAluno = class(TDataModule)

  end;

  TDMSimulacao = class(TDataModule)
    FQryConsultar: TFDQuery;
    FQryInserir: TFDQuery;
    FQryConsultarID_SIMULACAO: TIntegerField;
    FQryConsultarQUANTIDADE: TIntegerField;
    FQryConsultarDATA_ULTIMA_CONTRIBUICAO: TDateField;
    FQryConsultarVALOR: TFloatField;
    FQryConsultarPERCENTUAL: TFloatField;
    FQryExcluir: TFDQuery;
  private
    FSimulacaoList: TObjectList<TSimulacao>;
    procedure PopularColecao(DataSet: TDataSet);
  public
    { Public declarations }
    function Inserir(Simulacao: TSimulacao; out MsgErro: string): Boolean;
    function Alterar(Simulacao: TSimulacao; out MsgErro: string): Boolean;
    function Excluir(Simulacao: TSimulacao; out MsgErro: string): Boolean;
    function Pesquisar: TObjectList<TSimulacao>;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

var
  DMSimulacao: TDMSimulacao;

implementation

uses
  uDMConexao;

resourcestring
  MsgErroInserirSimulacao = 'Ocorreu um erro ao inserir a simula??o!';
  MsgErroExcluirSimulacao = 'Ocorreu um erro ao remover uma simula??o!';


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMSimulacao }

function TDMSimulacao.Alterar(Simulacao: TSimulacao;
  out MsgErro: string): Boolean;
begin
  // TODO
end;


constructor TDMSimulacao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSimulacaoList := TObjectList<TSimulacao>.Create;

end;

destructor TDMSimulacao.Destroy;
begin
  if Assigned(FSimulacaoList) then
    FreeAndNil(FSimulacaoList);
  inherited;
end;

function TDMSimulacao.Excluir(Simulacao: TSimulacao; out MsgErro: string): Boolean;
begin
  Result := True;

  try
    FQryExcluir.ParamByName('ID_SIMULACAO').AsInteger := Simulacao.IDSimulacao;
    FQryExcluir.Prepare;
    FQryExcluir.ExecSQL;

  except on E: Exception do
    begin
      MsgErro := MsgErroExcluirSimulacao + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TDMSimulacao.Inserir(Simulacao: TSimulacao;
  out MsgErro: string): Boolean;
begin
  Result := True;

  try
    FQryInserir.ParamByName('QUANTIDADE').AsInteger                 := Simulacao.QtdeContribuicoes;
    FQryInserir.ParamByName('DATA_ULTIMA_CONTRIBUICAO').AsDateTime  := Simulacao.DataUltimaContribuicao;
    FQryInserir.ParamByName('VALOR').AsCurrency                     := Simulacao.ValorMensal;
    FQryInserir.ParamByName('PERCENTUAL').AsFloat                   := Simulacao.Percentual;
    FQryInserir.Prepare;
    FQryInserir.ExecSQL;
    Result := True;

  except on E: Exception do
    begin
      MsgErro := MsgErroInserirSimulacao + sLineBreak + E.Message;
      Result := False;
    end;
  end;

end;

function TDMSimulacao.Pesquisar: TObjectList<TSimulacao>;
begin
  if FQryConsultar.Active then
    FQryConsultar.Close;

  FQryConsultar.Open;
  FQryConsultar.First;
  PopularColecao(FQryConsultar);
  Result := FSimulacaoList;
end;

procedure TDMSimulacao.PopularColecao(DataSet: TDataSet);
var
  LSimulacao: TSimulacao;
begin
  FSimulacaoList.Clear;
  while not DataSet.Eof do
  begin
    LSimulacao                        := TSimulacao.Create;
    LSimulacao.IDSimulacao            := DataSet.FieldByName('ID_SIMULACAO').AsInteger;
    LSimulacao.QtdeContribuicoes      := DataSet.FieldByName('QUANTIDADE').AsInteger;
    LSimulacao.DataUltimaContribuicao := DataSet.FieldByName('DATA_ULTIMA_CONTRIBUICAO').AsDateTime;
    LSimulacao.ValorMensal            := DataSet.FieldByName('VALOR').AsCurrency;
    LSimulacao.Percentual             := DataSet.FieldByName('PERCENTUAL').AsFloat;
    FSimulacaoList.Add(LSimulacao);

    DataSet.Next;
  end;
end;

end.
