unit IdeOutput;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls;

type

  { TfrIdeOutput }

  TfrIdeOutput = class(TForm)
    lbMessages: TListBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frIdeOutput: TfrIdeOutput;

implementation

{$R *.lfm}

{ TfrIdeOutput }

procedure TfrIdeOutput.FormShow(Sender: TObject);
begin

end;

end.

