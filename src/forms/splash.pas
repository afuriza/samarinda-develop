unit splash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  MainIde;

type

  { TfrSplash }

  TfrSplash = class(TForm)
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frSplash: TfrSplash;

implementation

{$R *.lfm}

{ TfrSplash }

procedure TfrSplash.FormShow(Sender: TObject);
begin
  Hide;
  frIDE.Show;
end;

end.

