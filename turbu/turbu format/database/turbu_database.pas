unit turbu_database;
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
   classes, sysUtils, Generics.Collections, DB, SyncObjs,
   dm_database, turbu_database_interface, turbu_map_interface, EB_RpgScript,
   turbu_characters, turbu_items, turbu_skills, turbu_classes, turbu_resists,
   turbu_battle_engine, turbu_map_engine, turbu_sprites, turbu_animations,
   turbu_containers, turbu_script_interface, turbu_game_data, turbu_terrain,
   turbu_map_metadata, turbu_tilesets, turbu_maps, turbu_monsters, turbu_sounds,
   turbu_serialization, turbu_defs, turbu_map_objects;

type
   TCharClassList = TRpgDataDict<TClassTemplate>;
   THeroTemplateList = TRpgDataDict<THeroTemplate>;
   TBattleEngineList = TRpgObjectList<TBattleEngineData>;
   TMapEngineList = TRpgObjectList<TMapEngineData>;
   TMoveMatrixArray = array of TMoveMatrix;
   TItemList = TRpgDataDict<TItemTemplate>;
   TItemMatrix = array[TItemType] of TItemList;
   TSkillList = TRpgDataDict<TSkillTemplate>;
   TAnimList = TRpgDataDict<TAnimTemplate>;
   TAttribList = TRpgDataDict<TAttributeTemplate>;
   TConditionList = TRpgDataDict<TConditionTemplate>;
   TTilesetList = TRpgDataDict<TTileset>;
   TTileDictionary = TObjectDictionary<string, TTileGroup>;
   TVehicleList = TRpgDataDict<TVehicleTemplate>;
   TMonsterList = TRpgDataDict<TRpgMonster>;
   TMonsterPartyList = TRpgDataDict<TRpgMonsterParty>;
   TBattleCharList = TRpgDataDict<TBattleCharAnim>;
   TTerrainlist = TRpgDataDict<TRpgTerrain>;

   TRpgDataTypes = (rd_class, rd_hero, rd_command, rd_item, rd_skill, rd_anim,
                    rd_attrib, rd_condition, rd_tileset, rd_switch, rd_int,
                    rd_float, rd_string, rd_vocab, rd_tilegroup, rd_script,
                    rd_vehicles, rd_monster, rd_mparty, rd_battleChar, rd_layout,
                    rd_terrain, rd_sound, rd_legacy);
   TRpgDataTypeSet = set of TRpgDataTypes;

   TBattleCommandList = class(TRpgDataDict<TBattleCommand>)
   public
      function indexOf (name: string): integer;
   end;

   TMapLoadProc = reference to procedure(tree: IMapTree);

   TLegacyData = class(TRpgDatafile)
   private
      FSection: integer;
      FData: rawByteString;
   protected
      class function keyChar: ansiChar; override;
   public
      constructor Create(const name: string; id, section: integer; const data: RawByteString); reintroduce;
      property section: integer read FSection;
      property value: RawByteString read FData;
   end;

   TLegacyDataList = TRpgObjectList<TLegacyData>;

   TRpgDatabase = class(TRpgDatafile, IRpgDatabase)
   private
      FClass: TCharClassList;
      FHero: THeroTemplateList;
      FCommand: TBattleCommandList;
      FItems: TItemMatrix;
      FSkills: TSkillList;
      FAnims: TAnimList;
      FAttributes: TAttribList;
      FConditions: TConditionList;
      FVehicles: TVehicleList;
      FMonsters: TMonsterList;
      FMonsterParties: TMonsterPartyList;
      FBattleChars: TBattleCharList;
      FTerrains: TTerrainList;

      //I need system data
      //and a battle layout section

      FGlobalEvents: TMapObjectList;
      FLayout: TGameLayout;
      FSwitches: TStringList;
      FVariables: TStringList;
      FFloats: TStringList;
      FStrings: TStringList;

      FMapTree: TMapTree;

      FMoveMatrix: TMoveMatrixArray;
      FBattleStyle: TBattleEngineList;
      FMapEngines: TMapEngineList;
      FStatSet: TStatSet;
      FTileGroup: TTileDictionary;
      FTileset: TTilesetList;
      FUploadedTypes: TRpgDataTypeSet;
      FScriptFormat: TScriptFormat;
      FScriptFile: string;
      FLegacyData: TLegacyDataList;

      FFilename: string;
      FScriptLoaded: TSimpleEvent;
      FScriptLoadError: string;
      procedure SetScriptFormat(const Value: TScriptFormat);
      function getClassCount: integer;
      function getCommandCount: integer;
      function getHeroCount: integer;

      function getProjectName: string;

      procedure uploadStringList(dataset: TDataset; list: TStringList);
      procedure UploadGlobalEvents(db: TdmDatabase);
      procedure DownloadGlobalEvents(ds: TDataset);
      procedure UploadVocab(db: TdmDatabase);
      procedure DownloadVocab(db: TdmDatabase);
      procedure UploadTileGroups(db: TdmDatabase);

      function GetMapTree: IMapTree;
      function IRpgDatabase.MapTree = GetMapTree;
   private
      FSerializer: TDatasetSerializer;
      procedure SaveScripts;
      procedure SaveToDB(db: TdmDatabase);
      procedure LoadSounds;
      procedure SaveSounds;
      function GetTileGroup(const key: string): TTileGroup;
      procedure downloadStringList(dataset: TDataset; list: TStringList);
      function GetVocab(const key: string): string;
      function GetSFX(value: TSfxTypes): TRpgSound;
      function GetBGM(value: TBgmTypes): TRpgMusic;
      function NewItem(sender: TRpgDataDict<TItemTemplate>): TItemTemplate;
      function CreateNewItem(slot: TItemType): TItemTemplate;
   protected
      FGlobalScriptBlock: TEBUnit;
      FSysVocab: TStringList;
      FCustomVocab: TStringList;
      FBgm: array[TBgmTypes] of TRpgMusic;
      FSfx: array[TSfxTypes] of TRpgSound;

      class function keyChar: ansiChar; override;
   public
      constructor Create; override;
      constructor Load(dm: TDmDatabase); reintroduce;
      destructor Destroy; override;
      procedure save(dm: TDmDatabase); reintroduce; overload;
      procedure save; reintroduce; overload;
      procedure copyToDB(db: TdmDatabase; typeSet: TRpgDataTypeSet = [];
        report: TUploadReportProc = nil);
      procedure copyTypeToDB(db: TdmDatabase; value: TRpgDataTypes);

      procedure addClass;

      procedure addHero;

      procedure addItem(slot: TItemType); overload;
      function findItem(id: integer): TItemTemplate;
      function countItems: integer;

      procedure addSkill;

      procedure addAnim;

      procedure addAttribute;
      procedure addCondition;
      procedure addTileset;
      procedure AddTileGroup(const Filename: string; newGroup: TTileGroup);
      function HasTileGroup(const filename: string): boolean;

      procedure AddLegacy(const name: string; id, section: integer; const data: RawByteString);
      function VocabNum(const key: string; num: integer): string;


      property charClasses: integer read getClassCount;
      property charClass: TCharClassList read FClass write FClass;
      property heroes: integer read getHeroCount;
      property hero: THeroTemplateList read FHero write FHero;
      property skill: TSkillList read FSkills write FSkills;
      property item: TItemMatrix read FItems write FItems;
      property items: integer read CountItems;
      property anim: TAnimList read FAnims write FAnims;
      property attributes: TAttribList read FAttributes write FAttributes;
      property conditions: TConditionList read FConditions write FConditions;
      property command: TBattleCommandList read FCommand write FCommand;
      property commands: integer read getCommandCount;
      property tileset: TTilesetList read FTileset;
      property globalEvents: TMapObjectList read FGlobalEvents;
      property layout: TGameLayout read FLayout write FLayout;
      property variable: TStringList read FVariables write FVariables;
      property switch: TStringList read FSwitches write FSwitches;
      property battleStyle: TBattleEngineList read FBattleStyle;
      property mapEngines: TMapEngineList read FMapEngines;
      property moveMatrix: TMoveMatrixArray read FMoveMatrix write FMoveMatrix;
      property mapTree: TMapTree read FMapTree write FMapTree;
      property statSet: TStatSet read FStatSet write FStatSet;
      property tileGroup[const key: string]: TTileGroup read GetTileGroup;
      property scriptFormat: TScriptFormat read FScriptFormat write SetScriptFormat;
      property scriptFile: string read FScriptFile write FScriptFile;
      property scriptBlock: TEBUnit read FGlobalScriptBlock;
      property vehicles: TVehicleList read FVehicles;
      property monsters: TMonsterList read FMonsters;
      property monsterParties: TMonsterPartyList read FMonsterParties;
      property battleChars: TBattleCharList read FBattleChars;
      property terrains: TTerrainList read FTerrains;
      property vocab[const key: string]: string read GetVocab;
      property sfx[value: TSfxTypes]: TRpgSound read GetSFX;
      property bgm[value: TBgmTypes]: TRpgMusic read GetBGM;

      property projectName: string read getProjectName;
      property uploadedTypes: TRpgDataTypeSet read FUploadedTypes;
      property Filename: string read FFilename write FFilename;
      property serializer: TDatasetSerializer read FSerializer;
      property ScriptLoaded: TSimpleEvent read FScriptLoaded;
      property scriptLoadError: string read FScriptLoadError;
   end;

   EBadDB = class(Exception);

var
   GDatabase: TRpgDatabase;

const
   MIN_DBVERSION = 47;
   DBVERSION = 47;

implementation
uses
   Windows, Variants,
   math, TypInfo,
   archiveInterface, commons,
   turbu_constants, turbu_engines, turbu_versioning, turbu_plugin_interface,
   turbu_functional,
   uDatasetHelper;

{ TLegacyData }

constructor TLegacyData.Create(const name: string; id, section: integer;
  const data: RawByteString);
begin
   inherited Create;
   FName := name;
   FID := id;
   FSection := section;
   FData:= data;
end;

class function TLegacyData.keyChar: ansiChar;
begin
   result := 'l';
end;

const
   DBNAME = 'TURBU RPG Database';

{ TRpgDatabase }

constructor TRpgDatabase.Create;
var
   i: TItemType;
begin
   inherited Create;
   GDatabase := self;
   FName := DBNAME;
   FID := DBVERSION;
   FSerializer := TDatasetSerializer.Create;
   FSerializer.OnClosedDataset := dmDatabase.OnClosedDataset;
   FSerializer.OnReleaseClosedDataset := dmDatabase.OnReleaseClosedDataset;

   for I := low(TItemType) to high(TItemType) do
   begin
      FItems[i] := TItemList.Create(dmDatabase.items, FSerializer);
      FItems[i].OnGetNewObject := self.NewItem;
   end;
   FAttributes := TAttribList.Create(dmDatabase.attributes, FSerializer);
   FConditions := TConditionList.Create(dmDatabase.conditions, FSerializer);
   FBattleStyle := TBattleEngineList.Create(false);
   FMapEngines := TMapEngineList.Create(false);
   FLayout := TGameLayout.Create;
   FSwitches := TStringList.Create;
   FVariables := TStringList.Create;
   FFloats := TStringList.Create;
   FStrings := TStringList.Create;
   FSysVocab := TStringList.Create;
   FCustomVocab := TStringList.Create;
   FLegacyData := TLegacyDataList.Create;
   FClass := TCharClassList.Create(dmDatabase.charClasses, FSerializer);
   FHero := THeroTemplateList.Create(dmDatabase.heroes, FSerializer);
   FSkills := TSkillList.Create(dmDatabase.skills, FSerializer);
   FAnims := TAnimList.Create(dmDatabase.animations, FSerializer);
   FCommand := TBattleCommandList.Create(dmDatabase.commands, FSerializer);
   FTileGroup := TTileDictionary.Create([doOwnsValues]);
   FTileset := TTilesetList.Create(dmDatabase.tilesets, FSerializer);
   FGlobalEvents := TMapObjectList.Create;
   FVehicles := TVehicleList.Create(dmDatabase.vehicles, FSerializer);
   FMonsters := TMonsterList.Create(dmDatabase.monsters, FSerializer);
   FMonsterParties := TMonsterPartyList.Create(dmDatabase.mparties, FSerializer);
   FBattleChars := TBattleCharList.Create(dmDatabase.battleChars, FSerializer);
   FTerrains := TTerrainList.Create(dmDatabase.terrain, FSerializer);
   FScriptLoaded := TSimpleEvent.Create;
   FScriptLoaded.ResetEvent;
end;

constructor TRpgDatabase.Load(dm: TDmDatabase);
var
   ds: TDataset;
   stream: TBytesStream;
   i, j: integer;
   dummy: string;
begin
   self.Create;

   ds := dm.dbData;
   FName := ds.FieldByName('name').AsString;
   FID := ds.FieldByName('id').AsInteger;
   if FID < MIN_DBVERSION then
      raise EBadDB.Create('This project is using an out-of-date database and can''t be loaded.');

   FScriptFormat := TScriptFormat(ds.FieldByName('scriptFormat').AsInteger);
   FScriptFile := ds.FieldByName('scriptFile').AsString;

   TThread.CreateAnonymousThread(
      procedure
      var eventStream: TStream;
      begin
         try
            eventStream := GArchives[SCRIPT_ARCHIVE].getFile(FScriptFile);
            try
               FGlobalScriptBlock := TEBUnit.LoadFromStream(eventStream) as TEBUnit;
               FScriptLoaded.SetEvent;
            finally
               eventStream.Free;
            end;
         except
            on E: Exception do
            begin
               FreeAndNil(FScriptLoaded);
               FScriptLoadError := format('%s: %s', [E.ClassName, E.Message]);
            end;
         end;
      end).Start;

   FMapTree := TMapTree.Load(dm);

   stream := TBytesStream.Create(ds.FieldByName('statSet').AsBytes);
   try
      FStatSet := TStatSet.load(stream);
   finally
      stream.Free;
   end;

   stream := TBytesStream.Create(ds.FieldByName('moveMatrix').AsBytes);
   try
      SetLength(FMoveMatrix, stream.readWord);
      for I := 0 to high(FMoveMatrix) do
      begin
         SetLength(FMoveMatrix[i], stream.readWord);
         for j := 0 to high(FMoveMatrix[i]) do
         begin
            SetLength(FMoveMatrix[i,j], stream.readWord);
            stream.readBuffer(FMoveMatrix[i,j,0], length(FMoveMatrix[i,j]));
         end;
      end;
   finally
      stream.Free;
   end;

   stream := TBytesStream.Create(ds.FieldByName('battleStyles').AsBytes);
   try
      for I := 1 to stream.readByte do
      begin
         dummy := stream.readString; //order of operations issue
         FBattleStyle.Add(requireEngine(et_battle, dummy, TVersion.Create(stream.readInt)) as TBattleEngineData);
      end;
   finally
      stream.Free;
   end;

   stream := TBytesStream.Create(ds.FieldByName('mapStyles').AsBytes);
   try
      for I := 1 to stream.readByte do
      begin
         dummy := stream.readString; //order of operations issue
         FMapEngines.Add(requireEngine(et_map, dummy, TVersion.Create(stream.readInt)) as TMapEngineData);
      end;
   finally
      stream.Free;
   end;

   FLayout.download(FSerializer, dm.syslayout);
   LoadSounds;
   DownloadStringList(dm.Switches, FSwitches);
   DownloadStringList(dm.Variables, FVariables);
   DownloadVocab(dm);
   DownloadGlobalEvents(dm.GlobalScripts);
end;

procedure TRpgDatabase.save(dm: TDmDatabase);
var
   ds: TDataset;
   stream: TBytesStream;
   i, j: integer;
   mapname: string;
begin
   ds := dm.dbData;
   assert(ds.RecordCount < 2);
   if ds.RecordCount = 0 then
      ds.Append
   else ds.Edit;

   ds.FieldByName('name').AsString := FName;
   ds.FieldByName('id').AsInteger := FID;

   FMapTree.SaveAll(dm);

   stream := TBytesStream.Create;
   try
      FStatSet.save(stream);
      ds.FieldByName('statSet').AsBytes := stream.Bytes;
   finally
      stream.Free;
   end;

   stream := TBytesStream.Create;
   try
      stream.writeWord(length(FMoveMatrix));
      for I := 0 to high(FMoveMatrix) do
      begin
         stream.writeWord(length(FMoveMatrix[i]));
         for j := 0 to high(FMoveMatrix[i]) do
         begin
            stream.writeWord(length(FMoveMatrix[i,j]));
            stream.WriteBuffer(FMoveMatrix[i,j,0], length(FMoveMatrix[i,j]));
         end;
      end;
      ds.FieldByName('moveMatrix').AsBytes := stream.Bytes;
   finally
      stream.Free;
   end;

   ds.FieldByName('scriptFormat').AsInteger := ord(FScriptFormat);
   ds.FieldByName('scriptFile').AsString := FScriptFile;

   stream := TBytesStream.Create;
   try
      stream.WriteByte(FBattleStyle.Count);
      for I := 0 to FBattleStyle.High do
      begin
         stream.writeString(FBattleStyle[i].name);
         stream.writeInt(FBattleStyle[i].version.value);
      end;
      ds.FieldByName('battleStyles').AsBytes := stream.Bytes;
   finally
      stream.Free;
   end;

   stream := TBytesStream.Create;
   try
      stream.WriteByte(FMapEngines.Count);
      for I := 0 to FMapEngines.High do
      begin
         stream.writeString(FMapEngines[i].name);
         stream.writeInt(FMapEngines[i].version.value);
      end;
      ds.FieldByName('mapStyles').AsBytes := stream.Bytes;
   finally
      stream.Free;
   end;
   ds.Post;

   mapname := FMapTree[FMapTree.currentMap].mapEngine;
   ds := dm.boot;
   assert(ds.RecordCount < 2);
   if ds.RecordCount = 0 then
      ds.Append
   else ds.Edit;
   ds.FieldByName('id').AsInteger := 0;
   ds.FieldByName('EngineName').AsString := mapname;
   ds.FieldByName('Version').AsInteger := requireEngine(et_map, mapname, TVersion.Create(0)).version.value;
   ds.Post;
end;

procedure TRpgDatabase.SaveScripts;
var
   stream: TStream;
begin
   stream := TStringStream.Create(FGlobalScriptBlock.Serialize, TEncoding.UTF8, false);
   try
      stream.rewind;
      GArchives[SCRIPT_ARCHIVE].writeFile(self.scriptFile, stream);
   finally
      stream.Free;
   end;
end;

procedure TRpgDatabase.SaveToDB(db: TdmDatabase);
var
   stream: TBytesStream;
begin
   stream := TBytesStream.Create;
   try
      Save(stream);
   finally
      stream.free;
   end;
end;

procedure TRpgDatabase.save;
begin
   SaveToDB(dmDatabase);
   dmDatabase.SaveAll;
   SaveScripts;
end;

destructor TRpgDatabase.Destroy;
var
   i: TItemType;
   bgm: TBgmTypes;
   sfx: TSfxTypes;
begin
  for bgm := Low(TBgmTypes) to High(TBgmTypes) do
    FBgm[bgm].Free;
  for sfx := Low(TSfxTypes) to High(TSfxTypes) do
    FSfx[sfx].Free;
   FScriptLoaded.Free;
   FLegacyData.Free;
   FTerrains.Free;
   FBattleChars.Free;
   FMonsterParties.Free;
   FMonsters.Free;
   FVehicles.Free;
   FSerializer.Free;
   FSysVocab.Free;
   FCustomVocab.Free;
   FGlobalScriptBlock.Free;
   FGlobalEvents.Free;
   FSwitches.Free;
   FVariables.Free;
   FFloats.Free;
   FStrings.Free;
   FClass.Free;
   FHero.Free;
   FCommand.Free;
   FSkills.Free;
   for i := low(TItemType) to high(TItemType) do
      FItems[i].free;
   FAnims.Free;
   FConditions.Free;
   FAttributes.Free;
   FLayout.Free;
   FMapTree.Free;
   FStatSet.Free;
   FTileGroup.Free;
   FTileset.Free;
   FBattleStyle.Free;
   FMapEngines.Free;
   inherited Destroy;
end;

procedure TRpgDatabase.copyToDB(db: TdmDatabase; typeSet: TRpgDataTypeSet = [];
  report: TUploadReportProc = nil);
var
   i: TRpgDataTypes;
begin
   runThreadsafe(db.beginUpload, true);
   try
      if typeSet = [] then
      begin
         if assigned(report) then
            report('Preparing Data: system');
         self.save(db);
         typeSet := [low(TRpgDataTypes)..high(TRpgDataTypes)];
      end;
      for i in typeSet do
      begin
         if assigned(report) then
            report(format('Preparing Data: %s', [copy(typInfo.GetEnumName(typeinfo(TRpgDataTypes), ord(i)), 4, MAXINT)]));
         copyTypeToDB(db, i);
      end;
   finally
      runThreadsafe(db.endUpload, true);
   end;
end;

procedure TRpgDatabase.uploadStringList(dataset: TDataset; list: TStringList);
var
   i: integer;
   nameField: TWideStringField;
   idField: TIntegerField;
begin
   idField := dataset.FieldByName('id') as TIntegerField;
   nameField := dataset.FieldByName('name') as TWideStringField;
   dataset.DisableControls;
   try
      dataset.Append;
      idFIeld.Value := 0;
      nameField.Value := 'Local';
      dataset.Post;

      for I := 0 to List.Count - 1 do
      begin
         dataset.Append;
         idFIeld.Value := i + 1;
         nameField.Value := list[i];
         dataset.Post;
      end;
   finally
      dataset.EnableControls;
   end;
end;

procedure TRpgDatabase.downloadStringList(dataset: TDataset; list: TStringList);
var
   nameField: TWideStringField;
   idField: TIntegerField;
begin
   idField := dataset.FieldByName('id') as TIntegerField;
   nameField := dataset.FieldByName('name') as TWideStringField;
   dataset.DisableControls;
   try
      dataset.First;
      while not dataset.eof do
      begin
         if idField.Value > 0 then
            list.add(nameField.Value);
         dataset.next;
      end;
   finally
      dataset.EnableControls;
   end;
end;

procedure TRpgDatabase.UploadGlobalEvents(db: TdmDatabase);
var
   obj: TRpgMapObject;
   page: TRpgEventPage;
   ds: TDataset;
   id: integer;
   idField: TIntegerField;
   nameField: TWideStringField;
   condField: TIntegerField;
   hasSwitchField: TBooleanField;
   switchField: TIntegerField;
begin
   ds := db.GlobalScripts;
   ds.DisableControls;
   try
      idField := ds.FieldByName('id') as TIntegerField;
      nameField := ds.FieldByName('Name') as TWideStringField;
      condField := ds.FieldByName('StartCondition') as TIntegerField;
      hasSwitchField := ds.FieldByName('HasSwitch') as TBooleanField;
      switchField := ds.FieldByName('switch') as TIntegerField;
      id := 0;
      for obj in FGlobalEvents do
      begin
         inc(id);
         page := obj.pages.First;
         ds.Append;
         idField.Value := id;
         nameField.Value := page.scriptName;
         condField.Value := ord(page.startCondition);
         hasSwitchField.Value := pc_switch1 in page.conditionBlock.conditions;
         switchField.Value := page.conditionBlock.switch1Set;
         ds.Post;
      end;
   finally
      ds.EnableControls;
   end;
end;

procedure TRpgDatabase.DownloadGlobalEvents(ds: TDataset);
var
   obj: TRpgMapObject;
   page: TRpgEventPage;
   nameField: TWideStringField;
   condField: TIntegerField;
   hasSwitchField: TBooleanField;
   switchField: TIntegerField;
begin
   ds.DisableControls;
   try
      nameField := ds.FieldByName('Name') as TWideStringField;
      condField := ds.FieldByName('StartCondition') as TIntegerField;
      hasSwitchField := ds.FieldByName('HasSwitch') as TBooleanField;
      switchField := ds.FieldByName('switch') as TIntegerField;
      ds.First;
      while not ds.eof do
      begin
         obj := TRpgMapObject.Create;
         FGlobalEvents.Add(obj);
         page := TRpgEventPage.Create(obj, 1);
         obj.AddPage(page);
         page.scriptName := nameField.Value;
         page.startCondition := TStartCondition(condField.Value);
         if hasSwitchField.Value then
            page.conditionBlock.conditions := [pc_switch1];
         page.conditionBlock.switch1Set := switchField.Value;
         ds.next;
      end;
   finally
      ds.EnableControls;
   end;
end;

procedure TRpgDatabase.UploadTileGroups(db: TdmDatabase);
var
   grp: TTileGroup;
begin
   for grp in FTileGroup.Values do
      grp.upload(FSerializer, db.tilegroups);
end;

procedure TRpgDatabase.UploadVocab(db: TdmDatabase);
var
   i: integer;
begin
   for I := 0 to FSysVocab.Count - 1 do
      db.Vocab.AppendRecord([FSysVocab.Names[i], FSysVocab.ValueFromIndex[i]]);
   for I := 0 to FCustomVocab.Count - 1 do
      db.CustomVocab.AppendRecord([FCustomVocab.Names[i], FCustomVocab.ValueFromIndex[i]]);
end;

procedure TRpgDatabase.DownloadVocab(db: TdmDatabase);
var
   line: variant;
   k, v: TField;
begin
   k := db.Vocab.FieldByName('Key');
   v := db.Vocab.FieldByName('Val');
   db.Vocab.First;
   for line in db.vocab do
      FSysVocab.Values[K.AsString] := v.AsString;

   k := db.CustomVocab.FieldByName('Key');
   v := db.CustomVocab.FieldByName('Val');
   db.CustomVocab.First;
   for line in db.CustomVocab do
      FCustomVocab.Values[K.AsString] := v.AsString;
end;

procedure TRpgDatabase.copyTypeToDB(db: TdmDatabase; value: TRpgDataTypes);
var
   i: integer;
   enumerator: TRpgDatafile;
begin
   if value in FUploadedTypes then
      Exit;

   runThreadsafe(db.beginUpload, true);
   try
   case value of
      rd_class: FClass.upload;
      rd_hero: FHero.upload;
      rd_command: FCommand.upload;
      rd_item:
      begin
         for i := ord(low(TItemType)) to ord(high(TItemType)) do
         begin
            for enumerator in FItems[TItemType(i)].Values do
               if enumerator.id > 0 then
               begin
                  enumerator.upload(FSerializer, db.items);
                  db.items.FieldByName('itemType').AsInteger := i;
               end;
            db.items.postSafe;
         end;
      end;
      rd_skill: FSkills.upload;
      rd_anim: FAnims.upload;
      rd_attrib: FAttributes.upload;
      rd_condition: FConditions.upload;
      rd_tileset: FTileset.upload;
      rd_vehicles: FVehicles.upload;
      rd_monster: FMonsters.upload;
      rd_mParty: FMonsterParties.upload;
      rd_battleChar: FBattleChars.upload;
      rd_switch: uploadStringList(db.Switches, FSwitches);
      rd_int: uploadStringList(db.Variables, FVariables);
      rd_float: uploadStringList(db.Floats, FFloats);
      rd_string: uploadStringList(db.Strings, FStrings);
      rd_vocab: UploadVocab(db);
      rd_script: UploadGlobalEvents(db);
      rd_tilegroup: UploadTileGroups(db);
      rd_layout: FLayout.upload(FSerializer, db.syslayout);
      rd_terrain: FTerrains.upload;
      rd_sound: SaveSounds;
      rd_legacy:
      begin
         for enumerator in FLegacyData do
            enumerator.upload(FSerializer, db.LegacyData);
         db.LegacyData.postSafe;
      end;
      else assert(false);
   end;
   finally
      runThreadsafe(db.endUpload, true);
   end;

{   for dummy in db.datasets do
      dummy.First; }
   include(FUploadedTypes, value);
end;

function TRpgDatabase.findItem(id: integer): TItemTemplate;
var
   i: TItemType;
begin
   dmDatabase.items.Active := true;
   i := TItemType(integer(dmDatabase.items.Lookup('id', id, 'itemType')));
   result := FItems[i][id];
end;

function TRpgDatabase.getClassCount: integer;
begin
   result := FClass.GetCount;
end;

function TRpgDatabase.getHeroCount: integer;
begin
   result := FHero.GetCount;
end;

function TRpgDatabase.GetMapTree: IMapTree;
begin
   result := FMapTree;
end;

function TRpgDatabase.getProjectName: string;
begin
   result := FMapTree[0].name;
end;

function TRpgDatabase.GetSFX(value: TSfxTypes): TRpgSound;
begin
   result := FSfx[value];
end;

function TRpgDatabase.GetBGM(value: TBgmTypes): TRpgMusic;
begin
   result := FBgm[value];
end;

function TRpgDatabase.GetTileGroup(const key: string): TTileGroup;
begin
   if not FTileGroup.TryGetValue(key, result) then
   begin
      dmDatabase.EnsureTileGroups;
      if not dmDatabase.tilegroups.Locate('name', key, []) then
         raise EDatabaseError.CreateFmt('Tilegroup %s not found in database', [key]);
      result := TTileGroup.Create;
      result.download(FSerializer, dmDatabase.tilegroups);
      FTileGroup.Add(result.filename, result);
   end;
end;

function TRpgDatabase.GetVocab(const key: string): string;
begin
   result := FSysVocab.Values[key];
   if result = '' then
      result := FCustomVocab.Values[key];
end;

function TRpgDatabase.VocabNum(const key: string;
  num: integer): string;
begin
   result := GetVocab(format(key, [num]));
   if result = '' then
      result := GetVocab(format(key, [1]));
end;

function TRpgDatabase.HasTileGroup(const filename: string): boolean;
begin
   result := FTileGroup.ContainsKey(filename);
end;

class function TRpgDatabase.keyChar: ansiChar;
begin
   result := #0;
   assert(false, 'Database files don''t require a key char.');
end;

procedure TRpgDatabase.SetScriptFormat(const Value: TScriptFormat);
begin
   FScriptFormat := Value;
   // do more here
end;

function TRpgDatabase.getCommandCount: integer;
begin
   result := FCommand.GetCount;
end;

procedure TRpgDatabase.addAnim;
begin
   FAnims.add(TAnimTemplate.Create);
end;

procedure TRpgDatabase.addAttribute;
begin
   FAttributes.add(TAttributeTemplate.Create);
end;

procedure TRpgDatabase.addClass;
begin
   FClass.Add(TClassTemplate.Create);
end;

procedure TRpgDatabase.addCondition;
begin
   FConditions.add(TConditionTemplate.Create);
end;

procedure TRpgDatabase.addHero;
begin
   FHero.Add(THeroTemplate.Create);
end;

function TRpgDatabase.CreateNewItem(slot: TItemType): TItemTemplate;
begin
   case slot of
      it_junk: result := TJunkTemplate.Create;
      it_weapon: result := TWeaponTemplate.Create;
      it_armor: result := TArmorTemplate.Create;
      it_medicine: result := TMedicineTemplate.Create;
      it_upgrade: result := TStatItemTemplate.Create;
      it_book: result := TSkillBookTemplate.Create;
      it_skill: result := TSkillItemTemplate.Create;
      it_variable: result := TVariableItemTemplate.Create;
      it_script: result := TScriptItemTemplate.Create;
      else raise Exception.Create('Invalid item slot');
   end;
end;

function TRpgDatabase.NewItem(sender: TRpgDataDict<TItemTemplate>): TItemTemplate;
var
   slot: TItemType;
begin
   for slot := Low(TItemType) to High(TItemType) do
      if sender = FItems[slot] then
         exit(CreateNewItem(slot));
   raise Exception.Create('Invalid New Item slot'); //should not see this
end;

procedure TRpgDatabase.addItem(slot: TItemType);
var
   newItem: TItemTemplate;
begin
   newItem := CreateNewItem(slot);
   FItems[slot].Add(newItem);
end;

procedure TRpgDatabase.AddLegacy(const name: string; id, section: integer;
  const data: RawByteString);
begin
   FLegacyData.Add(TLegacyData.Create(name, id, section, data));
end;

procedure TRpgDatabase.addSkill;
begin
   FSkills.Add(TSkillTemplate.Create);
end;

procedure TRpgDatabase.AddTileGroup(const Filename: string;
  newGroup: TTileGroup);
begin
   FTileGroup.Add(filename, newGroup);
end;

procedure TRpgDatabase.addTileset;
begin
   FTileset.Add(TTileset.Create);
end;

procedure TRpgDatabase.LoadSounds;
var
   bgm: TBgmTypes;
   sfx: TSfxTypes;
begin
   for bgm := Low(TBgmTypes) to High(TBgmTypes) do
   begin
      dmDatabase.SysSound.Locate('id;isMusic', VarArrayOf([ord(bgm), true]), []);
      FBgm[bgm] := TRpgMusic.Create;
      FBgm[bgm].Download(FSerializer, dmDatabase.SysSound);
   end;
   for sfx := Low(TSfxTypes) to High(TSfxTypes) do
   begin
      dmDatabase.SysSound.Locate('id;isMusic', VarArrayOf([ord(sfx), false]), []);
      FSfx[sfx] := TRpgSound.Create;
      FSfx[sfx].Download(FSerializer, dmDatabase.SysSound);
   end;
end;

procedure TRpgDatabase.SaveSounds;
var
   bgm: TBgmTypes;
   sfx: TSfxTypes;
   isMusic: TBooleanField;
begin
   isMusic := dmDatabase.SysSound.FieldByName('isMusic') as TBooleanField;
   for bgm := Low(TBgmTypes) to High(TBgmTypes) do
   begin
      FBgm[bgm].Upload(FSerializer, dmDatabase.SysSound);
      isMusic.Value := true;
   end;
   for sfx := Low(TSfxTypes) to High(TSfxTypes) do
   begin
      FSfx[sfx].Upload(FSerializer, dmDatabase.SysSound);
      isMusic.Value := false;
   end;
   dmDatabase.SysSound.Post;
end;

function TRpgDatabase.countItems: integer;
var i: TItemType;
begin
   result := 0;
   for i := low(TItemType) to high(TItemType) do
      inc(result, FItems[i].GetCount);
end;

{ TBattleCommandList }

function TBattleCommandList.indexOf(name: string): integer;
var
   enumerator: TBattleCommand;
begin
   result := -1;
   for enumerator in self.Values do
      if enumerator.name = name then
         Exit(enumerator.id);
end;

initialization
finalization
begin
   GDatabase.Free;
//   GScriptEngine := nil;
end;

end.
