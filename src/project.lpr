program project;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, splash, MainIde, CodeEditor, IdeBottomBar, IdeOutput, SamaEditor, 
ProjectWizard
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TfrSplash, frSplash);
  Application.CreateForm(TfrIDE, frIDE);
  Application.CreateForm(TfrCodeEditor, frCodeEditor);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrIdeOutput, frIdeOutput);
  Application.CreateForm(TfrSamaEditor, frSamaEditor);
  Application.CreateForm(TfrProjectWizard, frProjectWizard);
  Application.Run;
end.

