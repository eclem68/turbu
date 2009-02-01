unit item_code;
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
   rpg_list, hero_data, script_engine, script_backend, chipset_graphics,
   chipset_data, skill_code;

type
   TJunkItem = class(TRpgItem)
   protected
      function getOnField: boolean; override;
   public
      function usableBy(hero: word): boolean; override;
   end;

   TEquipment = class abstract(TRpgItem)
   private
      function getAgi: smallint;
      function getAtk: smallint;
      function getDef: smallint;
      function getMind: smallint;
   protected
      function getOnField: boolean; override;
   public
      function usableBy(hero: word): boolean; override;

      property attack: smallint read getAtk;
      property defense: smallint read getDef;
      property speed: smallint read getAgi;
      property mind: smallint read getMind;
   end;

   TWeapon = class(TEquipment)
   end;

   TShield = class(TEquipment)
   end;

   TArmor = class(TEquipment)
   end;

   THelmet = class(TEquipment)
   end;

   TRelic = class(TEquipment)
   end;

   TAppliedItem = class abstract(TRpgItem)
   protected
      function getOnField: boolean; override;
   public
      function usableBy(hero: word): boolean; override;
      function usableArea: boolean;
      function areaItem: boolean; virtual;
      procedure use(target: TRpgHero); virtual;
      procedure useArea;
   end;

   TRecoveryItem = class(TAppliedItem)
   private
   public
      function usableBy(hero: word): boolean; override;
      procedure use(target: TRpgHero); override;
   end;

   TBookItem = class(TAppliedItem)
   private
   public
      function usableBy(hero: word): boolean; override;
      procedure use(target: TRpgHero); override;
   end;

   TStatItem = class(TAppliedItem)
   private
   public
      function usableBy(hero: word): boolean; override;
      procedure use(target: TRpgHero); override;
   end;

   TSkillItem = class(TAppliedItem)
   private
      FSkill: TRpgSkill;
   protected
      function getOnField: boolean; override;
   public
      constructor create(const item, quantity: word); override;

      function usableBy(hero: word): boolean; override;
      function areaItem: boolean; override;
      procedure use(target: TRpgHero); override;

      property skill: TRpgSkill read FSkill;
   end;

   TSwitchItem = class(TRpgItem)
   protected
      function getOnField: boolean; override;
   public
      function usableBy(hero: word): boolean; override;
      procedure use;
   end;

implementation

uses item_data, skill_data, script_interface, commons;

{ TEquipment }

function TEquipment.getAgi: smallint;
begin
   result := template.speed;
end;

function TEquipment.getAtk: smallint;
begin
   result := template.attack;
end;

function TEquipment.getDef: smallint;
begin
   result := template.defense;
end;

function TEquipment.getMind: smallint;
begin
   result := template.mind;
end;

function TEquipment.getOnField: boolean;
begin
   result := false;
end;

function TEquipment.usableBy(hero: word): boolean;
begin
   result := self.template.usableBy[hero];
end;

{ TAppliedItem }

function TAppliedItem.areaItem: boolean;
begin
   result := template.areaMedicine;
end;

function TAppliedItem.getOnField: boolean;
begin
   result := true;
end;

function TAppliedItem.usableArea: boolean;
var
  I: Integer;
begin
   result := false;
   for I := 1 to MAXPARTYSIZE do
      if GParty[i] <> GCurrentEngine.hero[0] then
         result := result or usableBy(GParty[i].template.id);
      //end if
   //end for
end;

function TAppliedItem.usableBy(hero: word): boolean;
begin
   result := self.template.usableBy[hero];
   if GCurrentEngine.hero[hero].dead then
      result := result and template.condition[CTN_DEAD]
   else if template.deadOnly then
      result := false;
   //end if
end;

procedure TAppliedItem.use(target: TRpgHero);
begin
   if not self.areaItem then
      self.useOnce;
   //end if
end;

procedure TAppliedItem.useArea;
var
   i: Integer;
begin
   for I := 1 to MAXPARTYSIZE do
      if GParty[i] <> GCurrentEngine.hero[0] then
         self.use(GParty[i]);
      //end if
   //end for
   self.useOnce;
end;

{ TRecoveryItem }

function TRecoveryItem.usableBy(hero: word): boolean;
begin
   result := false;
   if not inherited usableBy(hero) then
      Exit;

   with self.template do
   begin
      if (hpPercent > 0) or (hpHeal > 0) then
         result := result or (GParty[hero].hp < GParty[hero].maxHp);
      if (mpPercent > 0) or (mpHeal > 0) then
         result := result or (GParty[hero].mp < GParty[hero].maxMp);
      if (outOfBattle) then
         result := result and (GGameEngine.state <> in_battle);
   end;
end;

procedure TRecoveryItem.use(target: TRpgHero);
var
   fraction: single;
   I: Integer;
begin
   for i := 1 to GDatabase.conditions + 1 do
      if template.condition[i] then
         target.condition[i] := false;
      //end if
   //end for
   if template.hpPercent <> 0 then
   begin
      fraction := template.hpPercent / 100;
      target.hp := target.hp + trunc(target.maxHp * fraction);
   end;
   if template.mpPercent <> 0 then
   begin
      fraction := template.mpPercent / 100;
      target.mp := target.mp + trunc(target.maxMp * fraction);
   end;
   target.hp := target.hp + template.hpHeal;
   target.mp := target.mp + template.mpHeal;
   inherited use(target);
end;

{ TBookItem }

function TBookItem.usableBy(hero: word): boolean;
begin
   result := inherited usableBy(hero) and not GCurrentEngine.hero[hero].skill[self.template.skill];
end;

procedure TBookItem.use(target: TRpgHero);
begin
   target.skill[template.skill] := true;
   inherited;
end;

{ TStatItem }

function TStatItem.usableBy(hero: word): boolean;
begin
   result := false;
   if not inherited usableBy(hero) then
      Exit;
end;

procedure TStatItem.use(target: TRpgHero);
begin
   target.maxHp := target.maxHp + template.permHP;
   target.maxMp := target.maxMP + template.permMP;
   target.attack := target.attack + template.permAttack;
   target.defense := target.defense + template.permDefense;
   target.mind := target.mind + template.permMind;
   target.agility := target.agility + template.permSpeed;
   inherited;
end;

{ TSkillItem }

function TSkillItem.areaItem: boolean;
begin
   result := FSkill.template.range = sr_helpAll;
end;

constructor TSkillItem.Create(const item, quantity: word);
begin
   inherited;
   FSkill := GSkills[template.skill];
end;

function TSkillItem.getOnField: boolean;
begin
   result := self.skill.template.usableOnField;
end;

function TSkillItem.usableBy(hero: word): boolean;
begin
   if not inherited usableBy(hero) then
   begin
      result := false;
      Exit;
   end;

   result := FSkill.usableOn(hero);
end;

procedure TSkillItem.use(target: TRpgHero);
begin
   FSkill.useHero(target, target);
   inherited;
end;

{ TSwitchItem }

function TSwitchItem.getOnField: boolean;
begin
   result := self.template.onField;
end;

function TSwitchItem.usableBy(hero: word): boolean;
begin
   result := false;
end;

procedure TSwitchItem.use;
begin
   GSwitches[self.template.switch] := true;
   self.useOnce;
end;

{ TJunkItem }

function TJunkItem.getOnField: boolean;
begin
   result := false;
end;

function TJunkItem.usableBy(hero: word): boolean;
begin
   result := false;
end;

end.
