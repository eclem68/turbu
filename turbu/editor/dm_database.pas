unit dm_database;
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
   SysUtils, Classes, DBClient, DB, Generics.Collections, RTTI,
   turbu_database_interface;

type
   TDatasetList = class(TList<TClientDataSet>)
   public
      function FindByName(const name: string): TClientDataset;
   end;

   TRelationAttribute = class(TCustomAttribute);

   TdmDatabase = class(TDataModule, IRpgDatastore)
      charClasses: TClientDataset;
      [TRelation]
      charClasses_skillset: TClientDataset;
      [TRelation]
      charClasses_Resists: TClientDataSet;
      [TRelation]
      charClasses_Conditions: TClientDataSet;
      animations: TClientDataSet;
      items_script: TClientDataSet;
      items_armor: TClientDataSet;
      items_weapon: TClientDataSet;
      items_medicine: TClientDataSet;
      items_book: TClientDataSet;
      items_skill: TClientDataSet;
      items_upgrade: TClientDataSet;
      items_variable: TClientDataSet;
      [TRelation]
      items_attributes: TClientDataSet;
      shields: TClientDataSet;
      armors: TClientDataSet;
      helmets: TClientDataSet;
      accessories: TClientDataSet;
      items_junk: TClientDataSet;
      weapons: TClientDataSet;
      commands: TClientDataSet;
      skills: TClientDataSet;
      [TRelation]
      skills_attributes: TClientDataSet;
      items: TClientDataSet;
      offhands: TClientDataSet;
      attributes: TClientDataSet;
      conditions: TClientDataSet;
      scriptRange: TClientDataSet;
      metadata: TClientDataSet;
      animations_timingSec: TClientDataSet;
      animations_frameSec: TClientDataSet;
      tilesets: TClientDataSet;
      heroes: TClientDataSet;
      heroes_Conditions: TClientDataSet;
      heroes_Resists: TClientDataSet;
      heroes_skillset: TClientDataSet;
      Floats: TClientDataSet;
      Strings: TClientDataSet;
      Switches: TClientDataSet;
      Variables: TClientDataSet;

      dsCharClasses: TDataSource;
      charClassesid: TIntegerField;
      charClassesName: TWideStringField;
      charClassesmodified: TBooleanField;
      items_scriptusableByHero: TBytesField;
      items_scriptscript: TMemoField;
      conditionscolor: TWordField;
      metadataParent: TSmallintField;
      metadataBgmState: TByteField;
      metadataMapEngine: TShortintField;
      charClassesSp: TLargeintField;
      heroesportraitShiftFColorSet1: TSingleField;

      procedure DataModuleCreate(Sender: TObject);
      procedure restoreClone(DataSet: TDataSet);
      procedure charClasses_skillsetCalcFields(DataSet: TDataSet);
      procedure DataModuleDestroy(Sender: TObject);
      procedure classFilter(DataSet: TDataSet; var Accept: Boolean);
      procedure SwitchesVarsCalcFields(DataSet: TDataSet);
   private
      { Private declarations }

      FDatasetList: TDatasetList;
      FViewList: TDatasetList;
      function usableByFilter(field: TBytesField; master: TDataset): boolean;
   public
      { Public declarations }
      procedure beginUpload;
      procedure endUpload;
      function NameLookup(const name: string; id: integer): string;
      property datasets: TDatasetList read FDatasetList write FDatasetList;
      property views: TDatasetList read FViewList write FViewList;
   end;

var
   dmDatabase: TdmDatabase;

implementation

uses
   Variants, Generics.Defaults,
   turbu_skills, turbu_defs, turbu_classes, rttiHelper;

{$R *.dfm}

function CDSComparer(const Left, Right: TClientDataset): Integer;
begin
   result := StrIComp(PChar(left.name), PChar(right.name));
end;

procedure TdmDatabase.DataModuleCreate(Sender: TObject);
var
   clone: TClientDataset;
   context: TRttiContext;
   instance: TRttiInstanceType;
   field: TRttiField;
begin
   context := TRttiContext.Create;
   instance := context.GetType(TdmDatabase) as TRttiInstanceType;

   FDatasetList := TDatasetList.Create(TComparer<TClientDataset>.Construct(CDSComparer));
   for field in instance.GetDeclaredFields do
      if (field.FieldType as TRttiInstanceType).metaclassType = TClientDataset then
      begin
         if not assigned(field.GetAttribute(TRelationAttribute)) then
            FDatasetList.Add(field.GetValue(self).AsObject as TClientDataset);
      end;
   FDatasetList.Sort;

   FViewList := TDatasetList.Create;
   FViewList.AddRange([shields, armors, helmets, accessories, weapons, offhands]);

   for clone in TArray<TClientDataset>.Create(shields, armors, helmets, accessories) do
      clone.CloneCursor(items_armor, false, true);
   weapons.CloneCursor(items_weapon, false, true);
   offhands.CloneCursor(items, false, true);
   for clone in FDatasetList do
   begin
      if Pos('items_', clone.Name) = 1 then
         clone.CloneCursor(items, false);
      clone.tag := integer(clone.CloneSource);
   end;
end;

procedure TdmDatabase.DataModuleDestroy(Sender: TObject);
begin
   FDatasetList.Free;
   FViewList.Free;
end;

procedure TdmDatabase.beginUpload;
var
   ds: TClientDataset;
begin
   for ds in datasets do
   begin
      ds.AutoCalcFields := false;
      ds.LogChanges := false;
      ds.DisableControls;
   end;
end;

procedure TdmDatabase.endUpload;
var
   ds: TClientDataset;
begin
   for ds in dmDatabase.datasets do
   begin
      ds.AutoCalcFields := true;
      ds.LogChanges := true;
      ds.EnableControls;
   end;
end;

function TdmDatabase.NameLookup(const name: string; id: integer): string;
var
   dataset: TClientDataset;
   lResult: variant;
begin
   dataset := FDatasetList.FindByName(name);
   if assigned(dataset) then
   begin
      lResult := dataset.Lookup('id', id, 'name');
      if lResult = Null then
         result := ''
      else result := lResult;
   end
   else result := '';
end;

procedure TdmDatabase.charClasses_skillsetCalcFields(DataSet: TDataSet);
var
   func: TSkillGainDisplayFunc;
   result: string;
   args: T4IntArray;
   i: integer;
begin
   if dataset.FieldByName('modified').IsNull then
      Exit;

   func := TSkillGainDisplayFunc(dataset.FieldByName('method.displayAddress').asPSMethod);
   if not assigned(TMethod(func).data) then
      result := '?'
   else
   begin
      for I := 1 to 4 do
         args[i] := dataset.FieldByName(format('nums[%d]', [i])).AsInteger;
      if dataset.FieldByName('method.arrayArgs').AsBoolean then
         result := TSkillGainDisplayArrayFunc(func)(args)
      else
         result := func(args[1], args[2], args[3], args[4])
      //end if
   end;
   dataset.FieldByName('id').AsString := result;
end;

procedure TdmDatabase.classFilter(DataSet: TDataSet; var Accept: Boolean);
begin
   accept := Self.usableByFilter(DataSet.FieldByName('usableByClass') as TBytesField, charClasses);
end;

procedure TdmDatabase.restoreClone(DataSet: TDataSet);
begin
   if dataset.tag <> 0 then
   begin
      DataSet.AfterOpen := nil;
      (dataSet as TClientDataSet).CloneCursor(TClientDataset(dataset.Tag), false, true);
      DataSet.AfterOpen := self.restoreClone;
   end;
end;

procedure TdmDatabase.SwitchesVarsCalcFields(DataSet: TDataSet);
const
   DISPLAY_NAME = '%.4d: %s';
var
   idField: TIntegerField;
   nameField: TWideStringField;
begin
   idField := dataset.FieldByName('id') as TIntegerField;
   nameField := dataset.FieldByName('name') as TWideStringField;
   dataset.FieldByName('DisplayName').AsString := format(DISPLAY_NAME, [idField.Value, nameField.Value]);
end;

function TdmDatabase.usableByFilter(field: TBytesField; master: TDataset): boolean;
begin
   result := master.FieldByName('id').AsInteger in field.asSet;
end;

{ TDatasetList }

function TDatasetList.FindByName(const name: string): TClientDataset;
var
  L, H: Integer;
  mid, cmp: Integer;
begin
  Result := nil;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    mid := L + (H - L) shr 1;
    cmp := StrIComp(PChar(self[mid].name), PChar(name));
    if cmp < 0 then
      L := mid + 1
    else
    begin
      H := mid - 1;
      if cmp = 0 then
        Exit(self[mid])
    end;
  end;
end;

end.
