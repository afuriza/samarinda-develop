unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, StdCtrls, Dialogs,
  Samarinda.Forms,
  Samarinda.Buttons;

type
  TForm1 = class(TSamaForm)
    procedure ButtonClick(Sender: TObject);
    procedure PostLoad; override;
  public
    constructor Create(AOwner: TComponent); override;
  published

  end;

var
  Form1: TForm1;
implementation

procedure TForm1.PostLoad;
begin
  {
  access property example:
  TWinControl(WidgetMap['Button1']).Caption;
  or
  TButton(WidgetMap['Button1']).Caption;
  
  we map the event here, name must be in lower case or it won't work }
  if WidgetMap.IndexOf('button1') <> -1 then
    TButton(WidgetMap['button1']).OnClick := @ButtonClick;
end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TForm1.ButtonClick(Sender: TObject);
begin
  ShowMessage('Clicked');
end;

end.

