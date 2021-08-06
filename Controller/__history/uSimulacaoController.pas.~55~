unit uSimulacaoController;

interface

uses uDMSimulacao, uSimulacao, System.SysUtils, uDadosUsuario,
  System.Generics.Collections;

type

TSimulacaoController = class
private
  FSimulacoes: TObjectList<TSimulacao>;
protected
  { protected declarations }
public
  constructor Create;
  destructor Destroy; override;
  function Inserir(Simulacao: TSimulacao; var MsgErro: string): Boolean;
  function Excluir(Simulacao: TSimulacao; var MsgErro: string): Boolean;
  function Pesquisar: TObjectList<TSimulacao>;
end;

implementation

{ TSimulacaoController }

constructor TSimulacaoController.Create;
begin
  DMSimulacao := TDMSimulacao.Create(nil);
end;

destructor TSimulacaoController.Destroy;
begin
  if Assigned(DMSimulacao) then
    FreeAndNil(DMSimulacao);

  inherited;
end;


function TSimulacaoController.Excluir(Simulacao: TSimulacao; var MsgErro: string): Boolean;
begin
  Result := DMSimulacao.Excluir(Simulacao, MsgErro);
end;

function TSimulacaoController.Inserir(Simulacao: TSimulacao; var MsgErro: string): boolean;
begin
  Result := DMSimulacao.Inserir(Simulacao, MsgErro);
end;


function TSimulacaoController.Pesquisar: TObjectList<TSimulacao>;
begin
  Result := DMSimulacao.Pesquisar;
end;

end.
