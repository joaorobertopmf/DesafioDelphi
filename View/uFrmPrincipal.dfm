object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema de Simula'#231#227'o de Tempo de Contribui'#231#227'o'
  ClientHeight = 655
  ClientWidth = 874
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 874
    Height = 65
    Align = alTop
    BevelOuter = bvSpace
    Caption = 'Simulador de tempo de contribui'#231#227'o'
    Color = clGradientInactiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 873
  end
  object PnlConteudo: TPanel
    Left = 0
    Top = 65
    Width = 874
    Height = 590
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 873
  end
end
