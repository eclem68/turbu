unit EditNull;

interface

uses
  Forms, Messages, StdCtrls, ExtCtrls, Classes, Controls,
  EventBuilder, EbEdit, EB_System;

const WM_HIDE = WM_USER + 1;

type
   //Ugly hack to create an "editor window" for types that don't need one.
   TfrmEBEditNull = class(TfrmEbEditBase)
   private
      procedure CMActivate(var message: TMessage); message CM_ACTIVATE;
      procedure WMHide(var message: TMessage); message WM_HIDE;
      procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
   protected
      procedure UploadObject(obj: TEbObject); override;
      procedure DownloadObject(obj: TEbObject); override;
   end;

   TfrmEBEditNull<T: TEBObject> = class(TfrmEBEditNull)
   protected
      function NewClassType: TEbClass; override;
   end;

   [EditorCategory('Basics', 'Game Over', 6)]
   TFrmGameOver = class(TfrmEBEditNull<TEBGameOver>);

   [EditorCategory('Basics', 'Title Screen', 7)]
   TFrmTitleScreen = class(TfrmEBEditNull<TEBTitleScreen>);

implementation
uses
   Windows;

{$R *.dfm}

{ TfrmEBEditNull }

procedure TfrmEBEditNull.CMActivate(var message: TMessage);
begin
   PostMessage(self.Handle, WM_HIDE, 0, 0);
end;

procedure TfrmEBEditNull.CMVisibleChanged(var Message: TMessage);
begin
end;

procedure TfrmEBEditNull.DownloadObject(obj: TEbObject);
begin
end;

procedure TfrmEBEditNull.UploadObject(obj: TEbObject);
begin
end;

procedure TfrmEBEditNull.WMHide(var message: TMessage);
begin
   self.ModalResult := mrOK;
end;

{ TfrmEBEditNull<T> }

function TfrmEBEditNull<T>.NewClassType: TEbClass;
begin
   result := T;
end;

initialization
   RegisterEbEditor(TEBGameOver, TFrmGameOver);
   RegisterEbEditor(TEBTitleScreen, TFrmTitleScreen);
end.
