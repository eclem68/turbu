unit turbu_maps;

interface
uses
   types, classes, generics.collections, DB,
   turbu_defs, turbu_classes, turbu_map_interface, turbu_tilesets,
   SG_defs;

type
   TTileList = packed array of TTileRef;
   TTileMap = array of TTileList;

   TMapScrollType = (stNone, stScroll, stAutoscroll);
   TScriptFormat = (sfEvents, sfScripts, sfCompiled, sfLegacy);
   TWraparound = set of (wrHorizontal, wrVertical);

   TDirs8 = (n, ne, e, se, s, sw, w, nw);
   TFuzzy = (no, yes, either);
   TNeighbors = packed array [TDirs8] of TFuzzy;

   TMapRegion = class(TRpgDatafile)
   private
      FBounds: TRect;
      FEncounterScript: string;
      function GetBattleCount: integer;
      procedure SetBattleCount(const Value: integer);
   protected
      FBattles: TPWordArray;
      FEncounters: T4IntArray;
      class function keyChar: ansiChar; override;
   public
      constructor Load(savefile: TStream);
      procedure save(savefile: TStream); override;
      procedure upload(db: TDataSet); override;
      procedure download(db: TDataset); override;

      property bounds: TRect read FBounds write FBounds;
      property battles: TPWordArray read FBattles write FBattles;
      property battleCount: integer read GetBattleCount write SetBattleCount;
      property encounterScript: string read FEncounterScript write FEncounterScript;
      property encounterParams: T4IntArray read FEncounters write FEncounters;
   end;

   TRegionList = class(TObjectList<TMapRegion>);

   TRpgMap = class(TRpgDatafile, IRpgMap)
   private
      FTileset: integer;
      FSize: TSgPoint;
      FDepth: byte;
      FWraparound: TWraparound;
      FTileMap: TTileMap;
      FHasBG: boolean;
      FBgName: string;
      FVScroll: TMapScrollType;
      FHScroll: TMapScrollType;
      FScrollSpeed: TSgPoint;
      FScriptFormat: TScriptFormat;
      FScriptFile: string;
      FRegions: TRegionList;
      FEncounterScript: string;
      procedure SetSize(const Value: TSgPoint);
      procedure SetDepth(const Value: byte);
      procedure SetScriptFormat(const Value: TScriptFormat);
      function GetBattleCount: integer;
      procedure SetBattleCount(const Value: integer);
      function GetTileset: integer;
      procedure SetTileset(const Value: integer);
   protected
      FEncounters: T4IntArray;
      FBattles: TPWordArray;
      class function keyChar: ansiChar; override;
   public
      constructor Load(savefile: TStream);
      procedure save(savefile: TStream); override;
      procedure upload(db: TDataSet); override;
      procedure download(db: TDataset); override;
      destructor Destroy; override;

      procedure assignTile(const x, y, layer: integer; const tile: TTileRef);
      function getTile(const x, y, layer: integer): TTileRef;

      property tileset: integer read FTileset write FTileset;
      property size: TSgPoint read FSize write SetSize;
      property depth: byte read FDepth write SetDepth;
      property wraparound: TWraparound read FWraparound write FWraparound;
      property tileMap: TTileMap read FTileMap write FTileMap;
      property hasBackground: boolean read FHasBG write FHasBG;
      property bgName: string read FBgName write FBgName;
      property hScroll: TMapScrollType read FHScroll write FHScroll;
      property vScroll: TMapScrollType read FVScroll write FVScroll;
      property scrollSpeed: TSgPoint read FScrollSpeed write FScrollSpeed;
      property scriptFormat: TScriptFormat read FScriptFormat write SetScriptFormat;
      property scriptFile: string read FScriptFile write FScriptFile;
      property battles: TPWordArray read FBattles write FBattles;
      property battleCount: integer read GetBattleCount write SetBattleCount;
      property encounterScript: string read FEncounterScript write FEncounterScript;
      property encounterParams: T4IntArray read FEncounters write FEncounters;
      property regions: TRegionList read FRegions write FRegions;
   end;

implementation
uses
   math;

{ TRpgMap }

constructor TRpgMap.Load(savefile: TStream);
var
   i: integer;
   len: integer;
   size: TSgPoint;
begin
   inherited Load(savefile);
   FTileset := savefile.readInt;
   savefile.ReadBuffer(size, sizeof(TSgPoint));
   self.SetSize(size);
   self.depth := savefile.readByte;
   savefile.readBuffer(FWraparound, sizeof(FWraparound));
   for I := 0 to self.depth - 1 do
      savefile.ReadBuffer(FTileMap[i, 0], length(FTileMap[i]) * sizeof(TTileRef));
   FHasBG := savefile.readBool;
   savefile.ReadBuffer(FHScroll, sizeof(TMapScrollType));
   savefile.ReadBuffer(FVScroll, sizeof(TMapScrollType));
   savefile.ReadBuffer(FScrollSpeed, sizeof(TSgPoint));
   savefile.ReadBuffer(FScriptFormat, sizeof(TScriptFormat));
   scriptFile := savefile.readString;
   battleCount := savefile.ReadInt;
   if battleCount > 0 then
      savefile.ReadBuffer(FBattles[0], length(FBattles) * sizeof(word));
   FEncounterScript := savefile.readString;
   savefile.ReadBuffer(FEncounters, sizeof(T4IntArray));
   len := savefile.readInt;
   FRegions := TRegionList.Create;
   FRegions.Capacity := max(len, FRegions.Capacity);
   if FRegions.Count > 0 then
   begin
      lassert(savefile.readChar = TMapRegion.keyChar);
      for i := 0 to len - 1 do
         FRegions.Add(TMapRegion.Load(savefile));
      lassert(savefile.readChar = UpCase(TMapRegion.keyChar));
   end;
   lassert(savefile.readChar = self.keyChar);
end;

procedure TRpgMap.save(savefile: TStream);
var
   region: TMapRegion;
   tileList: TTileList;
begin
   inherited Save(savefile);
   savefile.writeInt(FTileset);
   savefile.WriteBuffer(FSize, sizeof(TSgPoint));
   savefile.writeByte(FDepth);
   savefile.writeBuffer(FWraparound, sizeof(FWraparound));
   for tileList in FTileMap do
      savefile.WriteBuffer(tileList[0], length(tileList) * sizeof(TTileRef));
   savefile.writeBool(FHasBG);
   savefile.WriteBuffer(FHScroll, sizeof(TMapScrollType));
   savefile.WriteBuffer(FVScroll, sizeof(TMapScrollType));
   savefile.WriteBuffer(FScrollSpeed, sizeof(TSgPoint));
   savefile.WriteBuffer(FScriptFormat, sizeof(TScriptFormat));
   savefile.WriteString(scriptFile);
   savefile.WriteInt(battleCount);
   if battleCount > 0 then
      savefile.WriteBuffer(FBattles[0], length(FBattles) * sizeof(word));
   savefile.writeString(FEncounterScript);
   savefile.WriteBuffer(FEncounters, sizeof(T4IntArray));
   savefile.writeInt(FRegions.Count);
   if FRegions.Count > 0 then
   begin
      savefile.writeChar(TMapRegion.keyChar);
      for region in FRegions do
         region.save(savefile);
      savefile.writeChar(UpCase(TMapRegion.keyChar));
   end;
   savefile.writeChar(self.keyChar);
end;

procedure TRpgMap.assignTile(const x, y, layer: integer; const tile: TTileRef);
begin
   FTileMap[layer][(y * FSize.x) + x] := tile;
end;

function TRpgMap.getTile(const x, y, layer: integer): TTileRef;
begin
   result := FTileMap[layer][(y * FSize.x) + x];
end;

destructor TRpgMap.Destroy;
begin
   FRegions.Free;
   inherited Destroy;
end;

procedure TRpgMap.upload(db: TDataSet);
begin
   inherited;
   assert(false);
end;

procedure TRpgMap.download(db: TDataset);
begin
   inherited;
   assert(false);
end;

function TRpgMap.GetBattleCount: integer;
begin
   result := Length(FBattles);
end;

function TRpgMap.GetTileset: integer;
begin
  Result := FTileset;
end;

class function TRpgMap.keyChar: ansiChar;
begin
   result := 'm';
end;

procedure TRpgMap.SetBattleCount(const Value: integer);
begin
   setLength(FBattles, Value);
end;

procedure TRpgMap.SetDepth(const Value: byte);
begin
   FDepth := Value;
   setLength(FTileMap, value);
   setSize(FSize);
end;

procedure TRpgMap.SetScriptFormat(const Value: TScriptFormat);
begin
   FScriptFormat := Value;
   //do more here
end;

procedure TRpgMap.SetSize(const Value: TSgPoint);
var
   i: integer;
begin
   FSize := Value;
   for i := low(FTileMap) to high(FTileMap) do
      setLength(FTileMap[i], value.x * value.y);
end;

procedure TRpgMap.SetTileset(const Value: integer);
begin
  FTileset := Value;
end;

{ TMapRegion }

constructor TMapRegion.Load(savefile: TStream);
begin
   inherited Load(savefile);
   savefile.ReadBuffer(FBounds, sizeof(TRect));
   battleCount := savefile.ReadInt;
   if battleCount > 0 then
      savefile.ReadBuffer(FBattles[0], length(FBattles) * sizeof(word));
   FEncounterScript := savefile.readString;
   savefile.ReadBuffer(FEncounters, sizeof(T4IntArray));
   lassert(savefile.readChar = self.keyChar);
end;

procedure TMapRegion.save(savefile: TStream);
begin
   inherited Save(savefile);
   savefile.WriteBuffer(FBounds, sizeof(TRect));
   savefile.WriteInt(battleCount);
   if battleCount > 0 then
      savefile.WriteBuffer(FBattles[0], length(FBattles) * sizeof(word));
   savefile.writeString(FEncounterScript);
   savefile.WriteBuffer(FEncounters, sizeof(T4IntArray));
   savefile.writeChar(self.keyChar);
end;

function TMapRegion.GetBattleCount: integer;
begin
   result := length(FBattles);
end;

class function TMapRegion.keyChar: ansiChar;
begin
   result := 'r';
end;

procedure TMapRegion.SetBattleCount(const Value: integer);
begin
   setLength(FBattles, Value);
end;

procedure TMapRegion.upload(db: TDataSet);
begin
   inherited;
   assert(false);
end;

procedure TMapRegion.download(db: TDataset);
begin
   inherited;
   assert(false);
end;

end.