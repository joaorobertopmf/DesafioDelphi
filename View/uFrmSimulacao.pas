unit uFrmSimulacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uDadosUsuario, Vcl.ComCtrls,
  Vcl.ExtCtrls, uFrameTituloForm, System.ImageList, Vcl.ImgList, Vcl.Mask, uSimulacaoController,
  uSimulacao, System.Generics.Collections, System.Actions, Vcl.ActnList;

type
  TFrmSimulacao = class(TForm)
    FrameTituloForm1: TFrameTituloForm;
    ImgListBotoes: TImageList;
    PgCtrlSimulacao: TPageControl;
    TabPesquisa: TTabSheet;
    TabDados: TTabSheet;
    PnlConsultar: TPanel;
    PnlResultados: TPanel;
    Panel2: TPanel;
    ListView1: TListView;
    Panel1: TPanel;
    BtnRealizarNovaSimulacao: TButton;
    BtnExcluir: TButton;
    BtnConsultarSimulacoes: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LblQtdeContribuicoes: TLabel;
    LblDataUltimaContribuicao: TLabel;
    LblValorMensal: TLabel;
    LblPercentual: TLabel;
    Acoes: TActionList;
    actConsultarSimulacoes: TAction;
    procedure BtnRealizarNovaSimulacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure actConsultarSimulacoesExecute(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    DadosUsuario: TDadosUsuario;
    FSimulacao: TSimulacao;
    FSimulacaoController: TSimulacaoController;
    procedure InicializaComponentes;
    procedure RealizarSimulacao;
    procedure PreencherCampos;
    procedure GravarSimulacao;
    procedure PreencherListView(ASimulacaoList: TObjectList<TSimulacao>);
    procedure Pesquisar;
    procedure CarregarFormUsuario;
  public
    constructor Create(ADadosUsuario: TDadosUsuario; AOwner: TComponent); overload;
    destructor Destroy; override;
  end;

var
  FrmSimulacao: TFrmSimulacao;

implementation

{$R *.dfm}

uses uFrmUsuario, uFrmPrincipal;

{ TFrmSimulacao }

procedure TFrmSimulacao.actConsultarSimulacoesExecute(Sender: TObject);
begin
  PgCtrlSimulacao.ActivePage := TabPesquisa;
  Pesquisar;
end;

procedure TFrmSimulacao.BtnExcluirClick(Sender: TObject);
var
  MsgErro: String;
begin
    if ListView1.ItemIndex > -1 then
    begin
      if MessageDlg('Deseja excluir esse registro ?', mtConfirmation, mbYesNo, 0) = mrYes then
        begin
          if  FSimulacaoController.Excluir(TSimulacao (ListView1.ItemFocused.Data), MsgErro) = False then
            raise Exception.Create(MsgErro);

          Pesquisar;
          BtnExcluir.Enabled := False;
        end;
    end;
end;



procedure TFrmSimulacao.BtnRealizarNovaSimulacaoClick(Sender: TObject);
begin
  CarregarFormUsuario;
end;

constructor TFrmSimulacao.Create(ADadosUsuario: TDadosUsuario; AOwner: TComponent);
begin
  inherited Create(AOwner);
  DadosUsuario := ADadosUsuario;
  FSimulacaoController := TSimulacaoController.Create;
  FSimulacao := TSimulacao.Create;
end;

destructor TFrmSimulacao.Destroy;
begin
  if Assigned(FSimulacaoController) then
    FreeAndNil(FSimulacaoController);

  if Assigned(FSimulacao) then
    FreeAndNil(FSimulacao);

  inherited;
end;

procedure TFrmSimulacao.FormCreate(Sender: TObject);
begin
  PgCtrlSimulacao.ActivePage := TabDados;
  InicializaComponentes;
  RealizarSimulacao;
end;

procedure TFrmSimulacao.GravarSimulacao;
var
  MsgErro: string;
begin
  if FSimulacaoController.Inserir(FSimulacao, MsgErro) = False then
    raise Exception.Create(MsgErro);

end;

procedure TFrmSimulacao.InicializaComponentes;
begin
  TabPesquisa.TabVisible     := False;
  TabDados.TabVisible        := False;
  BtnExcluir.Enabled         := ListView1.ItemIndex > -1;
end;


procedure TFrmSimulacao.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  BtnExcluir.Enabled := True;
end;

procedure TFrmSimulacao.Pesquisar;
begin
  PreencherListView(FSimulacaoController.Pesquisar);
end;

procedure TFrmSimulacao.PreencherCampos;
begin
  LblQtdeContribuicoes.Caption := IntToStr(FSimulacao.QtdeContribuicoes);
  LblDataUltimaContribuicao.Caption := FormatDateTime('dd/mm/yyyy', FSimulacao.DataUltimaContribuicao);
  LblValorMensal.Caption := 'R$ ' + CurrToStr(FSimulacao.ValorMensal);
  LblPercentual.Caption := FloatToStr(FSimulacao.Percentual) + '%';
end;



procedure TFrmSimulacao.PreencherListView(ASimulacaoList: TObjectList<TSimulacao>);
var
  Simulacao: TSimulacao;
  Item: TListItem;
begin
  ListView1.Clear;

  if Assigned(ASimulacaoList) then
  begin
    for Simulacao in ASimulacaoList do
    begin
      Item := ListView1.Items.Add;
      Item.Caption := IntToStr(Simulacao.QtdeContribuicoes);
      Item.SubItems.Add(FormatDateTime('dd/mm/yyyy', Simulacao.DataUltimaContribuicao));
      Item.SubItems.Add('R$ ' + CurrToStr(Simulacao.ValorMensal));
      Item.SubItems.Add(FloatToStr(Simulacao.Percentual) + '%');
      Item.Data := Simulacao;
    end;
  end;
end;

procedure TFrmSimulacao.RealizarSimulacao;
begin
  try
    FSimulacao.RealizarSimulacao(DadosUsuario);
    GravarSimulacao;
    PreencherCampos;
    PgCtrlSimulacao.ActivePage := TabDados;
  except on E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;

end;

procedure TFrmSimulacao.CarregarFormUsuario;
begin
  FrmUsuario.Close;
  FrmUsuario              := TFrmUsuario.Create(Self);
  FrmUsuario.Parent       := Self.parent;
  FrmUsuario.BorderStyle  := bsNone;
  FrmUsuario.Show;

Close;
end;

end.
