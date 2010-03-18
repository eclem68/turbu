unit rm2_turbu_animations;
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
   battle_anims, turbu_animations;

type

   T2k2AnimCell = class helper for turbu_animations.TAnimCell
   public
      constructor Convert(base: battle_anims.TAnimCell; frame: word);
   end;

   T2k2AnimEffects = class helper for turbu_animations.TAnimEffects
   public
      constructor Convert(base: battle_anims.TAnimEffects);
   end;

   T2k2RpgAnim = class helper for TAnimTemplate
   public
      constructor convert(base: TBattleAnim; id: word);
   end;

implementation
uses
   types,
   commons, turbu_sounds,
   rm2_turbu_sounds;

{ T2k2RpgAnim }

constructor T2k2RpgAnim.convert(base: TBattleAnim; id: word);
var
   i, j: integer;
begin
   inherited Create;
   self.id := id;
   self.name := string(base.name);
   self.filename := string(base.filename);
   self.hitsAll := base.hitsAll;
   self.yTarget := TAnimYTarget(base.yTarget);

   self.frame := TAnimFrameList.Create;
   frame.Capacity := (base.frames + 1) * 2;
   for I := 1 to base.frames do
      for j := 1 to high(base.frame[i]) do
         self.frame.Add(TAnimCell.Convert(base.frame[i][j], i));

   effect := TAnimEffectList.Create;
   effect.Add(TAnimEffects.Create);
   effect.Capacity := base.effects + 1;
   for i := 1 to base.effects do
      effect.add(TAnimEffects.Convert(base.effect[i]));
end;

{ T2k2AnimCell }

constructor T2k2AnimCell.Convert(base: battle_anims.TAnimCell; frame: word);
begin
   self.id := base.index;
   self.frame := frame;
   self.position := point(base.x, base.y);
   self.zoom := point(base.zoom, base.zoom);
   self.color := base.color;
   self.saturation := base.saturation;
end;

{ T2k2AnimEffects }

constructor T2k2AnimEffects.Convert(base: battle_anims.TAnimEffects);
begin
   self.id := base.frame;
   if assigned(base.sound) then   
      self.sound := TRpgSound.Convert(base.sound);
   self.flashWhere := TFlashTarget(base.flashWhere);
   self.color := TRpgColor.Create(base.r, base.g, base.b, base.a);
end;

end.
