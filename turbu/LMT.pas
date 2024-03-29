unit LMT;
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
uses windows, classes, generics.Collections, //system libraries
     fileIO, charset_data, rm_sound; //modules

type
   {*********************************************************************
   * MapTreeData class.  This object stores the LMT entry for one map.
   *********************************************************************}
   TMapTreeData = class (TObject)
   private
      FID: word;
      FBgmData: TRmMusic;
      FCanSave: radioSet;
      FName: ansiString;
      FBgmState: radioSet;
      FCanPort: radioSet;
      FParent: word;
      FBattleBgName: ansiString;
      FGen: byte;
      FArea: boolean;
      FCanEscape: radioSet;
      FUnk06: integer;
      FBattles: word;
      FBattle: array of word;
      FUnk05: integer;
      FBgmName: ansiString;
      FBattleBgState: radioSet;
      FOpen: boolean;
      FEncounterRate: word;
      FAreaData: array [1..4] of integer;
      function GetBattle(index: integer): word;
      procedure SetBattle(index: integer; const Value: word);
      function GetArea(x: byte): integer;
      procedure SetArea(x: byte; const Value: integer);
      function GetBoundsRect: TRect;
   public
      constructor Create(theLMT: TStream; id: word);
      destructor Destroy; override;

      property bgmData: TRmMusic read FBgmData;
      property name: ansiString read FName write FName;
      property parent: word read FParent write FParent;
      property generation: byte read FGen write FGen;
      property isArea: boolean read FArea write FArea;
      property unk05: integer read FUnk05 write FUnk05;
      property unk06: integer read FUnk06 write FUnk06;
      property treeOpen: boolean read FOpen write FOpen;
      property bgmState: radioSet read FBgmState write FBgmState;
      property bgmName: ansiString read FBgmName write FBgmName;
      property battleBgState: radioSet read FBattleBgState write FBattleBgState;
      property battleBgName: ansiString read FBattleBgName write FBattleBgName;
      property canPort: radioSet read FCanPort write FCanPort;
      property canEscape: radioSet read FCanEscape write FCanEscape;
      property canSave: radioSet read FCanSave write FCanSave;
      property battles: word read FBattles write FBattles;
      property battle[index: integer]: word read GetBattle write SetBattle;
      property encounterRate: word read FEncounterRate write FEncounterRate;
      property AreaData[x: byte]: integer read GetArea write SetArea;
      property BoundsRect: TRect read GetBoundsRect;
   end;

   TVehicleSet = (vh_boat, vh_ship, vh_airship);

   {*********************************************************************
   * FullTree class.  This class contains all of the entries in the LMT.
   * mapSet and projectLen have contain the data entries and the total number
   * of elements in mapSet, respectively.
   *********************************************************************}
   TFullTree = class (TObject)
   private
      projectLen: word;
      mapSet: array of TMapTreeData;
      FHeroStartMap: smallint;
      FHeroStartX, FHeroStartY: word;
      FVhStartMap: array[TVehicleSet] of smallint;
      FVhStartX, FVhStartY: array[TVehicleSet] of word;
      FCurrentMap: word;
      inserted: boolean;
      translationTable: TDictionary<word, word>;
      function getVehicleStartX(x: TVehicleSet): word;
      function getVehicleStartY(x: TVehicleSet): word;
      function getVehicleStartMap(x: TVehicleSet): smallint;
   public
      nodeSet: array of word;
      constructor Create(theLMT: TStream);
      destructor Destroy; override;
      function getMapData(id: word): TMapTreeData;
      function getMax: word;
      procedure searchBack(var id: word);
      procedure searchForward(var id: word);
      function getBgm(const whichMap: word): ansiString;
      function lookup(x: word): word;

      property getSize: word read projectLen;
      property items[x: word]: TMapTreeData read getMapData; default;
      property vhStartMap[x: TVehicleSet]: smallint read getVehicleStartMap;
      property vhStartX[x: TVehicleSet]: word read getVehicleStartX;
      property vhStartY[x: TVehicleSet]: word read getVehicleStartY;
      property heroStartMap: smallint read FHeroStartMap;
      property heroStartX: word read FHeroStartX;
      property heroStartY: word read FHeroStartY;
      property currentMap: word read FCurrentMap;
   end;

implementation

uses math, sysUtils, //system libs
     commons, BER; //turbu libs

{Forwards}
procedure fillInLmtInt(const expected: byte; out theResult: integer); forward;
procedure fillInLmtEndInt(const expected: byte; out theResult: integer); forward;

{ TMapTreeData}

{*********************************************************************
* The only member function this object really needs, the constructor takes
* a fileStream containing an RPG_RT.LMT file as a parameter and reads in the
* record from the file.
*********************************************************************}
constructor TMapTreeData.Create(theLMT: TStream; id: word);
var
   dummy: byte;
   i: word;
begin
try
   inherited Create;
   FID := id;
   name := getStrSec (1, theLMT, fillInBlankStr);
   parent := getNumSec(2, theLMT, fillInLmtInt);
   generation := getNumSec(3, theLMT, fillInLmtInt);
   isArea := not getChboxSec(4, theLMT, fillInLmtInt); //for some reason, the
                                //format is backwards here.  The NOT fixes that.
   unk05 := getNumSec(5, theLMT, fillInLmtInt);
   unk06 := getNumSec(6, theLMT, fillInLmtInt);
   treeOpen := getChboxSec(7, theLMT, fillInLmtInt);
   bgmState := getRsetSec($0b, theLMT, fillInLmtInt);
   FBgmData := TRmMusic.Create($0C, theLMT);
   bgmName := FBgmData.filename;

   battleBGState := getRsetSec($15, theLMT, fillInLmtInt);
   if battleBgState = third then              //$16 is an optional section, only
      battleBgName := getStrSec($16, theLMT, fillInBlankStr); //included if necessary.
   canPort := getRSetSec($1F, theLMT, fillInLmtInt);
   canEscape := getRSetSec($20, theLMT, fillInLmtInt);
   canSave := getRSetSec($21, theLMT, fillInLmtInt);

   {The following is a kludgy workaround involving the list header for the
   battle section.}
   if not peekAhead(theLMT, $29) then
      raise EParseMessage.create('LMT field x29 not found for section ' + intToStr(id));
   TBerConverter.Create(theLMT);
   theLMT.read(dummy, 1);
   battles := dummy;

   {reads the section header, then uses getNumSec to retrieve the battle record.
   The records seem to be treated as lists; perhaps there will be a future problem
   found involving a second record.}
   SetLength(FBattle, battles);
   for i := 1 to battles do
   begin
      theLMT.Read(dummy, 1);
      if dummy <> i then
         raise EParseMessage.create('LMT encounter record ' + intToStr(i) + 'not found in section ' + intToStr(id));
      battle[i - 1] := getNumSec(1, theLMT, fillInLmtInt);
      theLMT.Read(dummy, 1);
      if dummy <> 0 then
         raise EParseMessage.create('LMT x29 final section padding of \0 not found for section ' + intToStr(id) + ', encounter #' + intToStr(i))
   end;

   encounterRate := getNumSec($2C, theLMT, fillInLmtInt);
   theLMT.Read(dummy, 1);
   if dummy = $33 then
   begin
      theLMT.Read(dummy, 1);
      if dummy <> $10 then
         raise EParseMessage.create('Error: Section x33 length was set at' + intToHex(dummy, 2) + ' instead of x10!')
      else
      begin
         for dummy := 1 to 4 do
            theLMT.Read(FAreaData[dummy], 4)
      end
   end
   else if dummy > $33 then
   begin
      raise EParseMessage.create('Error: Expected section x33 not found!');
   end
   else if dummy < 33 then
   begin
      raise EParseMessage.create('Error: Expected section x33, but found section x' + intToHex(dummy, 2) + ' stuck in there first.');
   end;
   theLMT.read(dummy, 1);
   if dummy <> 0 then
      raise EParseMessage.create('LMT section ' + intToStr(id) + ' final 0 not found.')
except
   on E: EParseMessage do
   begin
      msgBox(E.message, 'TMapTreeData.Create says:', MB_OK);
      raise EMessageAbort.Create
   end
end //end of TRY block
end;

destructor TMapTreeData.Destroy;
begin
   FBgmData.Free;
   inherited;
end;

function TMapTreeData.GetArea(x: byte): integer;
begin
   assert(x in [1..4]);
   result := FAreaData[x];
end;

function TMapTreeData.GetBattle(index: integer): word;
begin
   result := FBattle[index];
end;

function TMapTreeData.GetBoundsRect: TRect;
var
   overlay: PRect;
begin
   pointer(overlay) := @FAreaData[1];
   result := overlay^;
end;

procedure TMapTreeData.SetArea(x: byte; const Value: integer);
begin
   assert(x in [1..4]);
   FAreaData[x] := value;
end;

procedure TMapTreeData.SetBattle(index: integer; const Value: word);
begin
   FBattle[index] := Value;
end;

constructor TFullTree.Create(theLMT: TStream);
var
   dummy16: word;
   i: word;
   converter: intX80;
   v: TVehicleSet;
   last, maxVal: word;
begin
try
   inherited Create;
   inserted := false;
   last := 0;
   translationTable := TDictionary<word, word>.Create;
   converter := TBerConverter.Create (theLMT);
   projectLen := converter.getData;
   SetLength(mapSet, projectLen);
   dec(projectLen);
   maxVal := projectLen;
   for i := 0 to projectLen do
   begin
      converter.read(theLMT);
      dummy16 := converter.getData;
      if ((i = 0) and (dummy16 = 0)) or (dummy16 >= last) then
      begin
         if dummy16 > maxVal then
         begin
            setLength(mapSet, dummy16 + 1);
            maxVal := dummy16;
         end;
         mapSet[dummy16] := TMapTreeData.Create(theLMT, i);
         translationtable.Add(dummy16, i);
         last := dummy16;
      end
      else raise EParseMessage.CreateFmt('LMT section %d not found!', [i]);
   end;
   converter.read(theLMT);
   dummy16 := converter.getData;
   assert (dummy16 = projectLen + 1);
   setLength(nodeSet, projectLen + 1);
   for i := 0 to projectLen do
   begin
      converter.read(theLMT);
      nodeSet[i] := converter.getData
   end;
   assert(nodeSet[0] = 0);
   converter.read(theLMT);
   FCurrentMap := converter.getData;
   FHeroStartMap := getNumSec(1, theLMT, fillInLmtEndInt);
   FHeroStartX := getNumSec(2, theLMT, fillInZeroInt);
   FHeroStartY := getNumSec(3, theLMT, fillInZeroInt);
   i := 3;
   for v := low(TVehicleSet) to high (TVehicleSet) do
   begin
      inc(i, 8);
      FVhStartMap[v] := getNumSec(i, theLMT, fillInLmtEndInt);
      inc(i);
      FVhStartX[v] := getNumSec(i, theLMT, fillInLmtEndInt);
      inc(i);
      FVhStartY[v] := getNumSec(i, theLMT, fillInLmtEndInt);
   end;
   assert(peekAhead(theLMT, 0));
   projectLen := max(projectLen, maxVal + 1);
except
   on E: EParseMessage do
   begin
      msgBox(E.message, 'TFullTree.Create says:', MB_OK);
      raise EMessageAbort.Create
   end
end; //end of TRY block
end;

destructor TFullTree.Destroy;
var
   map: TMapTreeData;
begin
   translationtable.Free;
   for map in mapSet do
      map.Free;
   inherited Destroy;
end;

function TFullTree.getBgm(const whichMap: word): ansiString;
var currentMap: word;
begin
   currentMap := whichMap;
   result := '';
   repeat
      if (self[currentMap].bgmName <> '') and (self[currentMap].bgmName <> '(OFF)') then
         result := self[currentMap].bgmName
      else currentMap := self[currentMap].parent;
   until (currentMap = 0) or (result <> '');
end;

function TFullTree.getMapData(id: word): TMapTreeData;
begin
   result := mapSet[id]
end;

function TFullTree.getMax: word;
begin
   result := high(mapSet);
   while (mapSet[result].isArea = true) and (mapSet[result].name <> '') do
      dec(result);
end;

function TFullTree.getVehicleStartMap(x: TVehicleSet): smallint;
begin
   result := FVhStartMap[x];
end;

function TFullTree.getVehicleStartX(x: TVehicleSet): word;
begin
   result := FVhStartX[x];
end;

function TFullTree.getVehicleStartY(x: TVehicleSet): word;
begin
   result := FVhStartY[x];
end;

procedure TFullTree.searchBack(var id: word);
begin
   repeat
      dec(id)
   until mapSet[id].isArea = false
end;

procedure TFullTree.searchForward(var id: word);
begin
   repeat
      inc(id)
   until mapSet[id].isArea = false
end;

function TFullTree.lookup(x: word): word;
begin
   result := translationtable[x];
end;

procedure fillInLmtInt(const expected: byte; out theResult: integer);
begin
   case expected of
      2, 3, 5, 6: theResult := 0;
      7: theResult := integer(false);
      $2C: theResult := 25;
   else
      begin
         msgBox ('No case implemented for x' + IntToHex(expected, 2) + '!', 'FillInLmtInt says:', MB_OK);
         raise EMessageAbort.Create
      end
   end;
end;

procedure fillInLmtEndInt(const expected: byte; out theResult: integer);
begin
   case expected of
      1, $B, $15, $1F: theResult := -1;
      $C, $D, $16, $17, $20, $21: theResult := 0;
   else
      begin
         msgBox ('No case implemented for x' + IntToHex(expected, 2) + '!', 'FillInLmtEndInt says:', MB_OK);
         raise EMessageAbort.Create
      end
   end;
end;

end.
