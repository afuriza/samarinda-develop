unit SamaEditor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  SynEdit, Samarinda.Forms, Samarinda.ComUtils;

type

  { TfrSamaEditor }

  TfrSamaEditor = class(TForm)
    btPreview: TButton;
    Panel1: TPanel;
    pnPreview: TPanel;
    Splitter1: TSplitter;
    ActiveSynEdit: TSynEdit;
    procedure ActiveSynEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btPreviewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    SamaForm: TSamaForm;
    PreviewForm: TSamaForm;
    procedure LoadForm;
  public

  end;

var
  frSamaEditor: TfrSamaEditor;

implementation
uses
  IdeOutput;

{$R *.lfm}

procedure TfrSamaEditor.FormShow(Sender: TObject);
begin
  LoadForm;
  ActiveSynEdit.BorderSpacing.Bottom := 2;
end;

procedure TfrSamaEditor.btPreviewClick(Sender: TObject);
begin
  isDesigning := False;
  frIdeOutput.lbMessages.Clear;
  if Assigned(PreviewForm) then
    FreeAndNil(PreviewForm);
  PreviewForm := TSamaForm.Create(Self);
  try
    PreviewForm.LoadFromString(ActiveSynEdit.Text);
    PreviewForm.Show;
  except
    on e: Exception do
    begin
      frIdeOutput.lbMessages.Items.Add(e.Message);
    end;
  end;
  isDesigning := True;
end;

procedure TfrSamaEditor.ActiveSynEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  LoadForm;
end;

procedure TfrSamaEditor.LoadForm;
begin
  isDesigning := True;
  frIdeOutput.lbMessages.Clear;
  if Assigned(SamaForm) then
    FreeAndNil(SamaForm);
  SamaForm := TSamaForm.Create(Self);
  try
    SamaForm.LoadFromString(ActiveSynEdit.Text);
    SamaForm.BorderStyle := bsNone;
    SamaForm.Parent := pnPreview;
    SamaForm.Align := alClient;
    SamaForm.Show;
  except
    on e: Exception do
    begin
      frIdeOutput.lbMessages.Items.Add(e.Message);
    end;
  end;
end;

end.

