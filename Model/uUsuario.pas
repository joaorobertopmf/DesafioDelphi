unit uUsuario;

interface

type

TUsuario = class
private
    FDataNascimento: TDateTime;
    FTipoAposentadoria: Char;
    FSalario: Currency;
    FSexo: Char;
    procedure SetDataNascimento(const Value: TDateTime);
    procedure SetSalario(const Value: Currency);
    procedure SetSexo(const Value: Char);
    procedure SetTipoAposentadoria(const Value: Char);
  { private declarations }
protected
  { protected declarations }
public
  property Salario: Currency read FSalario write SetSalario;
  property DataNascimento: TDateTime read FDataNascimento write SetDataNascimento;
  property Sexo: Char read FSexo write SetSexo;
  property TipoAposentadoria: Char read FTipoAposentadoria write SetTipoAposentadoria;

  constructor Create(ASalario: Currency; ADataNascimento: TDateTime; ASexo: Char; ATipoAposentadoria: Char); overload;
published
  { published declarations }
end;

implementation

{ TUsuario }

constructor TUsuario.Create(ASalario: Currency; ADataNascimento: TDateTime;
  ASexo, ATipoAposentadoria: Char);
begin
  Salario           := ASalario;
  DataNascimento    := ADataNascimento;
  Sexo              := ASexo;
  TipoAposentadoria := ATipoAposentadoria;
end;

procedure TUsuario.SetDataNascimento(const Value: TDateTime);
begin
  FDataNascimento := Value;
end;

procedure TUsuario.SetSalario(const Value: Currency);
begin
  FSalario := Value;
end;

procedure TUsuario.SetSexo(const Value: Char);
begin
  FSexo := Value;
end;

procedure TUsuario.SetTipoAposentadoria(const Value: Char);
begin
  FTipoAposentadoria := Value;
end;

end.
