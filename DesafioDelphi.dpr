program DesafioDelphi;

uses
  Vcl.Forms,
  uFrmPrincipal in 'View\uFrmPrincipal.pas' {FrmPrincipal},
  uFrmUsuario in 'View\uFrmUsuario.pas' {FrmUsuario},
  uFrmSimulacao in 'View\uFrmSimulacao.pas' {FrmSimulacao},
  uFrameTituloForm in 'View\uFrameTituloForm.pas' {FrameTituloForm: TFrame},
  uSimulacaoController in 'Controller\uSimulacaoController.pas',
  uSimulacao in 'Model\uSimulacao.pas',
  uDMSimulacao in 'Datamodulo\uDMSimulacao.pas' {DMSimulacao: TDataModule},
  uDMConexao in 'Datamodulo\uDMConexao.pas' {DMConexao: TDataModule},
  uIBaseEntity in 'Interface\uIBaseEntity.pas',
  uDadosUsuario in 'Records\uDadosUsuario.pas',
  uUsuarioController in 'Controller\uUsuarioController.pas',
  uEDataInvalidaException in 'Exceptions\uEDataInvalidaException.pas',
  uESimulacaoException in 'Exceptions\uESimulacaoException.pas',
  uEValidaDadosUsuarioException in 'Exceptions\uEValidaDadosUsuarioException.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
