unit rm2_turbu_map_metadata;
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
   Generics.Collections,
   LMT, turbu_map_metadata, conversion_report;

type
   T2k2MapMetadata = class helper for TMapMetadata
   public
      constructor Convert(base: TMapTreeData; basetree: TFullTree; id: smallint);
   end;

   T2k2MapTree = class helper for TMapTree
   public
      constructor Convert(base: TFullTree; compact: boolean);
   end;

implementation
uses
   Types, Math, SysUtils,
   turbu_sounds, rm2_turbu_sounds, turbu_containers;

{ T2k2MapMetadata }

constructor T2k2MapMetadata.Convert(base: TMapTreeData; basetree: TFullTree; id: smallint);
begin
   inherited Create;
   self.name := string(base.name);
   self.id := id;
   self.parent := base.parent;
   self.scrollPosition := point(base.unk05, base.unk06);
   self.treeOpen := base.treeOpen;
   self.bgmState := TInheritedDecision(base.bgmState);
   self.bgmData := TRpgMusic.Convert(base.bgmData);
   self.battleBgState := TInheritedDecision(base.battleBgState);
   self.battleBgName := string(base.battleBgName);
   self.canPort := TInheritedDecision(base.canPort);
   self.canEscape := TInheritedDecision(base.canEscape);
   self.canSave := TInheritedDecision(base.canSave);
   self.mapEngine := 'TURBU basic map engine';
end;

{ T2k2MapTree }

constructor T2k2MapTree.Convert(base: TFullTree; compact: boolean);
var
   i: integer;
   current: TMapTreeData;
begin
   self.Create;
   self.FMapEngines.Add('TURBU basic map engine');
   for I := 0 to high(base.nodeSet) do
   begin
      current := base.getMapData(base.nodeSet[i]);
      if assigned(current) then
      begin
         if ((not current.isArea) or (i = 0)) then
            self.Add(TMapMetadata.Convert(current, base, base.nodeSet[i]))
         else if current.isArea then
         begin
            //TODO: Handle map regions
         end;
      end;
   end;
   self.currentMap := base.currentMap;
end;

end.
