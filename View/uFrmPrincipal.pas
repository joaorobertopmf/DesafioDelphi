unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TFrmPrincipal = class(TForm)
    PnlTopo: TPanel;
    PnlConteudo: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses uFrmUsuario;
{$R *.dfm}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  FrmUsuario             := TFrmUsuario.Create(Self);
  FrmUsuario.Parent      := PnlConteudo;
  FrmUsuario.BorderStyle := bsNone;
  FrmUsuario.Show;
end;

end.
