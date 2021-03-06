unit uFrmUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, uFrameTituloForm, uDadosUsuario,
  uUsuarioController;

type
  TFrmUsuario = class(TForm)
    PnlDadosUsuario: TPanel;
    LblSalario: TLabel;
    LblDataNascimento: TLabel;
    LblSexo: TLabel;
    Label4: TLabel;
    CbxSexo: TComboBox;
    CbxTipoAposentadoria: TComboBox;
    BtnRealizarSimulacao: TButton;
    EdtDataNascimento: TMaskEdit;
    EdtSalario: TEdit;
    ImgLstImagens: TImageList;
    FrameTituloForm: TFrameTituloForm;
    LblDataInicioContribuicao: TLabel;
    EdtDataPrimeiraContribuicao: TMaskEdit;

    procedure FormCreate(Sender: TObject);
    procedure BtnRealizarSimulacaoClick(Sender: TObject);
    procedure CbxSexoSelect(Sender: TObject);
    procedure CbxTipoAposentadoriaSelect(Sender: TObject);
    procedure EdtSalarioChange(Sender: TObject);
    procedure EdtDataNascimentoChange(Sender: TObject);
    procedure EdtSalarioKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    FUsuarioController: TUsuarioController;
    procedure ControlaEstadoBotao;
    procedure InicializaComponentes;
    function  CarregaUsuario: TDadosUsuario;
    function  PodeHabilitarBotao: Boolean;
    procedure CarregarFormSimulacao;

  public
    { Public declarations }
  end;

var
  FrmUsuario: TFrmUsuario;

implementation

uses  uFrmSimulacao;

resourcestring
  StrErroConversaoData = 'Dados Inválidos!';

{$R *.dfm}

{ TFrmUsuario }

{ TFrmUsuario }

procedure TFrmUsuario.FormCreate(Sender: TObject);
begin
  ControlaEstadoBotao;
  FUsuarioController := TUsuarioController.Create;
end;

procedure TFrmUsuario.FormDestroy(Sender: TObject);
begin
  if Assigned(FUsuarioController) then
    FreeAndNil(FUsuarioController);
end;

procedure TFrmUsuario.InicializaComponentes;
begin
  CbxSexo.Items.Add('Masculino');
  CbxSexo.Items.Add('Feminino');
end;

procedure TFrmUsuario.BtnRealizarSimulacaoClick(Sender: TObject);
begin
  try
    FUsuarioController.ValidarCampos(CarregaUsuario);
    CarregarFormSimulacao;
  except on E: Exception do
    ShowMessage(E.Message);
  end;

end;

procedure TFrmUsuario.CarregarFormSimulacao;
begin
  FrmSimulacao              := TFrmSimulacao.Create(CarregaUsuario, Self);
  FrmSimulacao.Parent       := FrmUsuario.Parent;
  FrmSimulacao.BorderStyle  := bsNone;
  FrmSimulacao.Show;

  FrmUsuario.Close;
end;

function TFrmUsuario.CarregaUsuario: TDadosUsuario;
begin

  with Result do
  begin
    try
        Salario                  := StrToCurr(EdtSalario.Text);
        DataNascimento           := StrToDate(EdtDataNascimento.Text);
        DataPrimeiraContribuicao := StrToDate(EdtDataPrimeiraContribuicao.Text);
        Sexo                     := CbxSexo.Items[CbxSexo.ItemIndex].Chars[0];
        TipoAposentadoria        := CbxTipoAposentadoria.Items[CbxTipoAposentadoria.ItemIndex].Chars[0];
    except on E: EConvertError do
      ShowMessage(StrErroConversaoData);
    end;
  end;
end;

procedure TFrmUsuario.CbxSexoSelect(Sender: TObject);
begin
  ControlaEstadoBotao;
end;

procedure TFrmUsuario.CbxTipoAposentadoriaSelect(Sender: TObject);
begin
  ControlaEstadoBotao;
end;

procedure TFrmUsuario.EdtDataNascimentoChange(Sender: TObject);
begin
  ControlaEstadoBotao;
end;

procedure TFrmUsuario.EdtSalarioChange(Sender: TObject);
begin
  EdtSalario.Text := StringReplace(EdtSalario.Text, '.', ',', [rfReplaceAll]);
  ControlaEstadoBotao;
end;

procedure TFrmUsuario.EdtSalarioKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '.' then
    Key := ',';
end;

procedure TFrmUsuario.ControlaEstadoBotao;
begin
  BtnRealizarSimulacao.Enabled := PodeHabilitarBotao;
end;

function TFrmUsuario.PodeHabilitarBotao: Boolean;
var
  I: Integer;
begin

  if (EdtDataNascimento.Text          = EmptyStr)  or
     (EdtSalario.Text                 = EmptyStr)  or
     (CbxSexo.ItemIndex               <    0    )   or
     (CbxTipoAposentadoria.ItemIndex  <    0    )   or
     (EdtDataNascimento.Text          = EmptyStr)  or
     (EdtDataNascimento.Text          = EmptyStr)  then
    Result := False
  else
    Result := True;

end;

end.
