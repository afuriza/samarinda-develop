unit CodeEditor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, SynEdit,
  SynHighlighterPas, SynHighlighterJScript, FileUtil,
  fgl;

type

  { TfrCodeEditor }

  TFileDisplay = class(TObject)
    ActiveSynEdit: TSynEdit;
    ActivePage: TTabSheet;
  end;

  TFileMap = specialize TFPGMap<string, TFileDisplay>;

  TfrCodeEditor = class(TForm)
    PageControl1: TPageControl;
    SynFreePascalSyn1: TSynFreePascalSyn;
    SynJScriptSyn1: TSynJScriptSyn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FileMap: TFileMap;
  public
    procedure OpenSamaFile(APath: string);
  end;

var
  frCodeEditor: TfrCodeEditor;

implementation

{$R *.lfm}

procedure TfrCodeEditor.FormCreate(Sender: TObject);
begin
  FileMap := TFileMap.Create;
end;

procedure TfrCodeEditor.FormDestroy(Sender: TObject);
begin
  FileMap.Free;
end;

procedure TfrCodeEditor.OpenSamaFile(APath: string);
begin
  if (ExtractFileExt(APath) = '.pas') or (ExtractFileExt(APath) = '.lson') then
  begin
    if FileMap.IndexOf(APath) = -1 then
    begin
      FileMap[APath] := TFileDisplay.Create;
      FileMap[APath].ActivePage := PageControl1.AddTabSheet;
      FileMap[APath].ActiveSynEdit := TSynEdit.Create(Self);
      FileMap[APath].ActiveSynEdit.Parent := FileMap[APath].ActivePage;
      FileMap[APath].ActiveSynEdit.Align := alClient;
      FileMap[APath].ActiveSynEdit.Font.Name := 'Courier New';
      FileMap[APath].ActiveSynEdit.Font.Size := 10;
      FileMap[APath].ActiveSynEdit.Color := clBlack;
      FileMap[APath].ActiveSynEdit.Font.Quality := fqCleartypeNatural;
      FileMap[APath].ActiveSynEdit.Lines.LoadFromFile(APath);
      if ExtractFileExt(APath) = '.pas' then
        FileMap[APath].ActiveSynEdit.Highlighter := SynFreePascalSyn1
      else
        FileMap[APath].ActiveSynEdit.Highlighter := SynJScriptSyn1;
      PageControl1.ActivePage := FileMap[APath].ActivePage;
    end
    else
    begin
      PageControl1.ActivePage := FileMap[APath].ActivePage;
    end;
    FileMap[APath].ActivePage.Caption := ExtractFileName(APath);
  end;
end;

end.

