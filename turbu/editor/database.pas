unit database;
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

interface

uses
   Classes, Controls, Forms, StdCtrls, ExtCtrls, ComCtrls, DB, Grids, DBGrids,
   Mask, DBCtrls,
   turbu_database, events, frame_commands, frame_class, dm_database, frame_items,
   EBListView, turbu_listGrid, variable_selector, DBIndexComboBox;

type
   TfrmDatabase = class(TForm)
      btnOK: TButton;
      btnCancel: TButton;
      btnApply: TButton;
      btnHelp: TButton;
      tabPages: TPageControl;
      tshClass: TTabSheet;
      lblGlobalEvents: TLabel;
      lstEvents: TRpgListGrid;
      pnlEvents: TPanel;
      grpName: TGroupBox;
      txtName: TDBEdit;
      grpStartCondition: TGroupBox;
      cbxStartCondition: TDBIndexComboBox;
      grpConditionSwitch: TGroupBox;
      chkHasSwitch: TDBCheckBox;
      grpEventCommands: TGroupBox;
      tshHero: TTabSheet;
      frmClass: TframeClass;
      tshItems: TTabSheet;
      frameItems1: TframeItems;
      trvGlobal: TEBTreeView;
      srcGlobals: TDataSource;
      selConditionSwitch: TSwitchSelector;
      procedure btnCodeViewClick(Sender: TObject);
      procedure chkHasSwitchClick(Sender: TObject);
      procedure tshClassShow(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormShow(Sender: TObject);
      procedure applyChanges(Sender: TObject);
      procedure btnCancelClick(Sender: TObject);
   private
      { Private declarations }
      FId: word;
      FEvent: TEvent;
      FDatabase: TRpgDatabase;
      FEventPage: TEventPage;
      FViewingCode: boolean;
      FWasInit: boolean;
      FUploaded: boolean;
      procedure initGlobalEvents;

      procedure GlobalScriptsAfterScroll(DataSet: TDataSet);
      procedure GlobalScriptsBeforeScroll(DataSet: TDataSet);
   public
      { Public declarations }
      function init(const database: TRpgDatabase): boolean;
      procedure reset;
   end;

implementation
{$R *.dfm}

uses
   commons, sysUtils, DBClient,
   turbu_battle_engine, eventBuilder, EB_RpgScript;

procedure TfrmDatabase.applyChanges(Sender: TObject);
var
   iterator: TClientDataset;
begin
   for iterator in dmDatabase.datasets do
      iterator.MergeChangeLog;
end;

procedure TfrmDatabase.btnCancelClick(Sender: TObject);
var
   iterator: TClientDataSet;
begin
   for iterator in dmDatabase.datasets do
      iterator.CancelUpdates;
end;

procedure TfrmDatabase.btnCodeViewClick(Sender: TObject);
begin
   FViewingCode := not FViewingCode;
{   case FViewingCode of
      false: txtEventScript.Text := FEventPage.eventText;
      true: txtEventScript.Text := FEventPage.eventScript;
   end;
  txtEventScript.Text := unicodeString(FEventPage.eventScript);}
end;

procedure TfrmDatabase.chkHasSwitchClick(Sender: TObject);
begin
   selConditionSwitch.Enabled := chkHasSwitch.Checked;
end;

procedure TfrmDatabase.FormShow(Sender: TObject);
var
   iterator: TClientDataset;
begin
   if not FUploaded then
   begin
      for iterator in dmDatabase.datasets do
      begin
         if assigned(iterator.CloneSource) and (iterator.RecordCount <> iterator.CloneSource.RecordCount) then
            iterator.CloneCursor(iterator.CloneSource, false, true);
         if iterator.Filtered then
         begin
            iterator.Filtered := false;
            iterator.Filtered := true;
         end;
      end;
      FUploaded := true;
   end;
   frmClass.onShow;
   frameItems1.onShow;

   GlobalScriptsAfterScroll(srcGlobals.DataSet);
   srcglobals.dataset.BeforeScroll := self.GlobalScriptsBeforeScroll;
   srcglobals.dataset.AfterScroll := self.GlobalScriptsAfterScroll;
end;

procedure TfrmDatabase.GlobalScriptsAfterScroll(DataSet: TDataSet);
begin
   trvGlobal.proc.Free;
   trvGlobal.proc := TEBObject.Load(dataset.FieldByName('EventText').Value) as TEBProcedure;
end;

procedure TfrmDatabase.GlobalScriptsBeforeScroll(DataSet: TDataSet);
begin
   dataset.Edit;
   dataset.FieldByName('EventText').Value := trvGlobal.proc.Serialize;
   dataset.Post;
end;

procedure TfrmDatabase.FormClose(Sender: TObject; var Action: TCloseAction);
var
   iterator: TClientDataSet;
begin
   frmClass.onHide;
   for iterator in dmDatabase.datasets do
      iterator.LogChanges := false;
   srcglobals.dataset.BeforeScroll := nil;
   srcglobals.dataset.AfterScroll := nil;
end;

function TfrmDatabase.init(const database: TRpgDatabase): boolean;
begin
   result := true;
   if FWasInit then
      Exit;

   FDatabase := database;
   initGlobalEvents;
   frmClass.initClasses;
   FWasInit := true;
end;

procedure TfrmDatabase.initGlobalEvents;
begin
   {$MESSAGE WARN 'TfrmDatabase.initGlobalEvents is not implemented'}
end;

procedure TfrmDatabase.reset;
begin
   FWasInit := false;
end;

procedure TfrmDatabase.tshClassShow(Sender: TObject);
var
   needs3: boolean;
   i: integer;
begin
   if not assigned(GDatabase) then
      Exit;

   needs3 := false;
   for I := 0 to GDatabase.battleStyle.High do
      needs3 := (needs3) or (GDatabase.battleStyle[i].view in NEED_BATTLE_SPRITES);
   if (needs3) and (frmClass.tabGraphics.Tabs.Count = 2) then
      frmClass.tabGraphics.Tabs.Add('Battle Sprite')
   else if (not needs3) and (frmClass.tabGraphics.Tabs.Count = 3) then
      frmClass.tabGraphics.Tabs.Delete(2);
end;

end.