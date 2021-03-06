unit uIBaseEntity;

interface

uses
  System.Generics.Collections;

type

IMinhaInterfaceTeste = interface

end;

IBaseEntity<T: class> = interface
['{D44ABB89-40B1-4950-A87A-11F8CF4ED007}']
  procedure Inserir(Entidade: T; var MensagemErro: string);
  procedure Alterar(Entidade: T; var sMsgErro: string);
  procedure Excluir(Entidade: T; var sMsgErro: string);
  function  ListarTodos: TObjectList<T>;
end;

implementation

end.
