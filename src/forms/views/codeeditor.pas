unit CodeEditor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, SynEdit,
  SynHighlighterPas, SynHighlighterJScript, FileUtil, SamaEditor,
  fgl;

type

  { TfrCodeEditor }

  TFileDisplay = class(TObject)
    ActiveSynEdit: TWinControl;
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

function HasFileExt(const FileName, AFileExt: RawByteString): boolean;
var
  SL: TStringList;
  i: integer;
  FileExt: string;
begin
  Result := False;
  SL := TStringList.Create;
  SL.Delimiter := '.';
  SL.DelimitedText := ExtractFileName(FileName);
  if SL.Count > 1 then
    for i := SL.Count -1 downto 1 do
    begin
      FileExt := '.' + SL[i] + FileExt;
      if AFileExt = FileExt then
        Result := True
      else
        Result := False;
    end;
end;

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
  if HasFileExt(APath, '.pas') or HasFileExt(APath, '.lson') or
    HasFileExt(APath, '.lpr') or HasFileExt(APath, '.form.lson') then
  begin
    if FileMap.IndexOf(APath) = -1 then
    begin
      FileMap[APath] := TFileDisplay.Create;
      FileMap[APath].ActivePage := PageControl1.AddTabSheet;




      if ExtractFileExt(APath) = '.pas' then
      begin
        FileMap[APath].ActiveSynEdit := TSynEdit.Create(Self);
        FileMap[APath].ActiveSynEdit.Font.Name := 'Courier New';
        FileMap[APath].ActiveSynEdit.Font.Size := 10;
        FileMap[APath].ActiveSynEdit.Color := clBlack;
        FileMap[APath].ActiveSynEdit.Font.Quality := fqCleartypeNatural;
        TSynEdit(FileMap[APath].ActiveSynEdit).Lines.LoadFromFile(APath);
        FileMap[APath].ActiveSynEdit.BorderSpacing.Right := 2;
        FileMap[APath].ActiveSynEdit.BorderSpacing.Bottom := 2;
        TSynEdit(FileMap[APath].ActiveSynEdit).Highlighter := SynFreePascalSyn1;
      end
      else if HasFileExt(APath, '.lson') then
      begin
        FileMap[APath].ActiveSynEdit := TSynEdit.Create(Self);
        FileMap[APath].ActiveSynEdit.Font.Name := 'Courier New';
        FileMap[APath].ActiveSynEdit.Font.Size := 10;
        FileMap[APath].ActiveSynEdit.Color := clBlack;
        FileMap[APath].ActiveSynEdit.Font.Quality := fqCleartypeNatural;
        TSynEdit(FileMap[APath].ActiveSynEdit).Lines.LoadFromFile(APath);
        FileMap[APath].ActiveSynEdit.BorderSpacing.Right := 2;
        FileMap[APath].ActiveSynEdit.BorderSpacing.Bottom := 2;
        TSynEdit(FileMap[APath].ActiveSynEdit).Highlighter := SynJScriptSyn1;
      end
      else if HasFileExt(APath, '.form.lson') then
      begin
        FileMap[APath].ActiveSynEdit := TfrSamaEditor.Create(Self);
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).ActiveSynEdit.Font.Name
          := 'Courier New';
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).ActiveSynEdit.Font.Size := 10;
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).ActiveSynEdit.Color := clBlack;
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).ActiveSynEdit.Font.Quality
          := fqCleartypeNatural;
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).ActiveSynEdit.Lines
          .LoadFromFile(APath);
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).ActiveSynEdit.BorderSpacing
          .Right := 2;
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).ActiveSynEdit.BorderSpacing
          .Bottom := 2;
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).ActiveSynEdit.Highlighter
          := SynJScriptSyn1;
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).BorderStyle := bsNone;
        TfrSamaEditor(FileMap[APath].ActiveSynEdit).Show;
      end;

      FileMap[APath].ActiveSynEdit.Parent := FileMap[APath].ActivePage;
      FileMap[APath].ActiveSynEdit.Align := alClient;
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

