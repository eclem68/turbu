unit turbu_2k_battle_engine;
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
   turbu_battle_engine, sdl_13;

type
   T2kBattleEngine = class(TBattleEngine)
   private
   public
      constructor Create; override;
      procedure initialize(window: TSdlWindowId); override;
      function startBattle(party: {TRpgParty} TObject; foes: TObject; conditions: TBattleConditions): TBattleResultData; override;
   end;

implementation
uses
   turbu_versioning;

{ T2kBattleEngine }

constructor T2kBattleEngine.Create;
begin
   self.data := TBattleEngineData.Create('First-person battle engine', TVersion.Create(0, 1, 1), bv_firstPerson, bt_turns);
end;

procedure T2kBattleEngine.initialize(window: TSdlWindowId);
begin
   //fill this in
   FInitialized := true;
end;

function T2kBattleEngine.startBattle(party: {TRpgParty} TObject; foes: TObject; conditions: TBattleConditions): TBattleResultData;
begin
   result.result := br_victory;
   result.data := nil;
end;

end.