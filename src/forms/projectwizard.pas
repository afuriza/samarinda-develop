unit ProjectWizard;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  FileUtil;

type

  { TfrProjectWizard }

  TfrProjectWizard = class(TForm)
    BitBtn1: TBitBtn;
    btCreate: TButton;
    btCancel: TButton;
    edName: TEdit;
    edPath: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lbTarget: TLabel;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure btCreateClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure edPathChange(Sender: TObject);
  private

  public

  end;

var
  frProjectWizard: TfrProjectWizard;

implementation
uses
  MainIde;

{$R *.lfm}

{ TfrProjectWizard }

procedure TfrProjectWizard.BitBtn1Click(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute then
  begin
    edPath.Text := SelectDirectoryDialog1.FileName;
  end;
end;

procedure TfrProjectWizard.btCreateClick(Sender: TObject);
begin
  if not DirectoryExists(edPath.Text + PathDelim
    + StringReplace(edName.Text, ' ', '_', [rfReplaceAll]).ToLower) then
  begin
    ForceDirectories(edPath.Text + PathDelim
      + StringReplace(edName.Text, ' ', '_', [rfReplaceAll]).ToLower);
  end;
  FileUtil.CopyDirTree(
    IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + '..' +PathDelim +
    'src'+PathDelim+'project_templates'+PathDelim+'form_project_template',
    edPath.Text + PathDelim + StringReplace(edName.Text, ' ', '_', [rfReplaceAll]).ToLower);
  ShowMessage(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + '..' +PathDelim);
  Close;
  frIDE.tvProjectStructure.Root := edPath.Text + PathDelim
      + StringReplace(edName.Text, ' ', '_', [rfReplaceAll]).ToLower;
end;

procedure TfrProjectWizard.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrProjectWizard.edNameChange(Sender: TObject);
begin
  lbTarget.Caption := edPath.Text + PathDelim
    + StringReplace(edName.Text, ' ', '_', [rfReplaceAll]).ToLower
    + PathDelim;
end;

procedure TfrProjectWizard.edPathChange(Sender: TObject);
begin
  lbTarget.Caption := edPath.Text + PathDelim
    + StringReplace(edName.Text, ' ', '_', [rfReplaceAll]).ToLower
    + PathDelim;
end;

end.

