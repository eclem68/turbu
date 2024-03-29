{*****************************************************************************
* The contents of this file are used with permission, subject to
* the Mozilla Public License Version 1.1 (the "License"); you may
* not use this file except in compliance with the License. You may
* obtain a copy of the License at
* http://www.mozilla.org/MPL/MPL-1.1.html
*
* Software distributed under the License is distributed on an
* "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
* implied. See the License for the specific language governing
* rights and limitations under the License.
*
*****************************************************************************
*
* This file was created by Mason Wheeler.  He can be reached for support at
* www.turbu-rpg.com.
*****************************************************************************}

unit ChoiceEdit;

interface

uses
  ExtCtrls, StdCtrls, Classes, Controls,
  EbEdit, EventBuilder, EB_Messages;

type
   [EditorCategory('Messages', 'Show Choice')]
   [EditorContext('RM2K')]
   TfrmShowChoice = class(TfrmEbEditBase)
      txtChoice1: TEdit;
      txtChoice2: TEdit;
      txtChoice3: TEdit;
      txtChoice4: TEdit;
      GroupBox1: TGroupBox;
      grpCancel: TRadioGroup;
      txtLines: TMemo;
      procedure FormCreate(Sender: TObject);
   private
      FEdits: array[1..4] of TEdit;
      FIsExpr: boolean;
      function GetMaxAnswers: integer;
      procedure UploadChoiceExpr(obj: TEBChoiceExpr);
      procedure DownloadChoiceExpr(obj: TEBChoiceExpr);
   protected
      procedure UploadObject(obj: TEbObject); override;
      procedure DownloadObject(obj: TEbObject); override;
      function NewClassType: TEbClass; override;
      function ValidateForm: boolean; override;
      procedure PrepareNewObject(obj: TEBObject); override;
   end;

implementation
uses
   EB_RpgScript, EB_Expressions;

{$R *.dfm}

{ TfrmShowChoice }

procedure TfrmShowChoice.FormCreate(Sender: TObject);
begin
   FEdits[1] := txtChoice1;
   FEdits[2] := txtChoice2;
   FEdits[3] := txtChoice3;
   FEdits[4] := txtChoice4;
end;

function TfrmShowChoice.GetMaxAnswers: integer;
var
   i: Integer;
begin
   for i := high(FEdits) downto low(FEdits) do
      if FEdits[i].text <> '' then
         exit(i);
   result := 0;
end;

function TfrmShowChoice.NewClassType: TEbClass;
begin
   result := TEBChoiceMessage;
end;

procedure TfrmShowChoice.PrepareNewObject(obj: TEBObject);
begin
   assert(obj.ChildCount = 0);
   TEBChoiceExpr.Create(obj);
end;

procedure TfrmShowChoice.UploadChoiceExpr(obj: TEBChoiceExpr);
var
   i: integer;
begin
   grpCancel.ItemIndex := obj.values[0];
   txtLines.Text := obj.Text;
   for i := 0 to high(obj.Choices) do
      FEdits[i + 1].Text := obj.Choices[i];
   for i := length(obj.Choices) + 1 to 4 do
      FEdits[i].Text := '';
end;

procedure TfrmShowChoice.UploadObject(obj: TEbObject);
var
   sub: TEbObject;
begin
   if (obj.ClassType = TEBChoiceMessage) then
   begin
      sub := obj.children[0];
      assert(sub.ClassType = TEBChoiceExpr);
      UploadChoiceExpr(TEBChoiceExpr(sub));
   end
   else begin
      UploadChoiceExpr(obj as TEBChoiceExpr);
      FIsExpr := true;
   end;
end;

function TfrmShowChoice.ValidateForm: boolean;
var
   max: integer;
begin
   result := true;
   max := GetMaxAnswers;
   if max = 0 then
      ValidateError(txtChoice1, 'Please fill in at least one choice');
   if (grpCancel.ItemIndex > max) and (grpCancel.ItemIndex < grpcancel.Items.count - 1) then
      ValidateError(grpCancel, 'Cancel handler must be a valid choice');
   if max + txtLines.Lines.Count > 4 then
      ValidateError(txtLines, 'Number of message lines + number of options should not be more than 4');
end;

procedure TfrmShowChoice.DownloadChoiceExpr(obj: TEBChoiceExpr);
var
   count, i: integer;
   choices: TArray<string>;
begin
   obj.Clear;
   count := GetMaxAnswers;
   setLength(choices, count);
   for i := 1 to count do
      choices[i - 1] := FEdits[i].Text;
   obj.Choices := choices;
   obj.Text := txtLines.Text;
   obj.values.add(grpCancel.ItemIndex);
end;

procedure TfrmShowChoice.DownloadObject(obj: TEbObject);
const CANCEL_ELSE = 5;
var
   i: integer;
   elseBlock: TEbElseBlock;
   caseBlock: TEbCaseBlock;
begin
   if obj.ClassType = TEBChoiceMessage then
   begin
      obj.Values.Clear;
      obj.Values.Add(grpCancel.ItemIndex);
      ElseBlock := (obj as TEbCase).GetElseBlock;
      if assigned(ElseBlock) then
         obj.Children.Extract(ElseBlock);
      for I := 1 to GetMaxAnswers do
      begin
         if i < obj.ChildCount then
            caseBlock := obj.Children[i] as TEbCaseBlock
         else caseBlock := TEbCaseBlock.Create(obj);
         caseBlock.Text := FEdits[i].Text;
      end;
      for I := GetMaxAnswers + 2 to obj.ChildCount - 1 do
         obj.Children.Extract(obj.Children[i]);
      if grpCancel.ItemIndex = CANCEL_ELSE then
      begin
         if not assigned(ElseBlock) then
            ElseBlock := TEbElseBlock.Create(nil);
         obj.Add(ElseBlock);
      end
      else elseBlock.Free;
      DownloadChoiceExpr(obj.children[0] as TEBChoiceExpr);
   end
   else DownloadChoiceExpr(obj as TEBChoiceExpr);
end;

initialization
   RegisterEbEditor(TEBChoiceMessage, TfrmShowChoice);
   RegisterEbEditor(TEBChoiceExpr, TfrmShowChoice);
finalization
   UnRegisterEbEditor(TEBChoiceMessage);
   UnRegisterEbEditor(TEBChoiceExpr);
end.
