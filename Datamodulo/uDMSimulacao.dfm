object DMSimulacao: TDMSimulacao
  OldCreateOrder = False
  Height = 170
  Width = 311
  object FQryConsultar: TFDQuery
    Connection = DMConexao.DesafiodelphiConnection
    SQL.Strings = (
      'SELECT * FROM TB_SIMULACAO;')
    Left = 88
    Top = 8
    object FQryConsultarID_SIMULACAO: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID_SIMULACAO'
      Origin = 'ID_SIMULACAO'
      Required = True
    end
    object FQryConsultarQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Required = True
    end
    object FQryConsultarDATA_ULTIMA_CONTRIBUICAO: TDateField
      FieldName = 'DATA_ULTIMA_CONTRIBUICAO'
      Origin = 'DATA_ULTIMA_CONTRIBUICAO'
      Required = True
    end
    object FQryConsultarVALOR: TFloatField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
    end
    object FQryConsultarPERCENTUAL: TFloatField
      FieldName = 'PERCENTUAL'
      Origin = 'PERCENTUAL'
      Required = True
    end
  end
  object FQryInserir: TFDQuery
    Connection = DMConexao.DesafiodelphiConnection
    SQL.Strings = (
      'INSERT INTO TB_SIMULACAO'
      '(QUANTIDADE, DATA_ULTIMA_CONTRIBUICAO, VALOR, '
      '  PERCENTUAL)'
      
        'VALUES (:QUANTIDADE, :DATA_ULTIMA_CONTRIBUICAO, :VALOR, :PERCENT' +
        'UAL)')
    Left = 88
    Top = 72
    ParamData = <
      item
        Name = 'QUANTIDADE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA_ULTIMA_CONTRIBUICAO'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALOR'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PERCENTUAL'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
  end
  object FQryExcluir: TFDQuery
    Connection = DMConexao.DesafiodelphiConnection
    SQL.Strings = (
      'DELETE FROM TB_SIMULACAO WHERE ID_SIMULACAO = :ID_SIMULACAO')
    Left = 160
    Top = 72
    ParamData = <
      item
        Name = 'ID_SIMULACAO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
