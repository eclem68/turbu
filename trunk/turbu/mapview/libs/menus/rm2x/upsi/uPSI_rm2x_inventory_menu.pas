unit uPSI_rm2x_inventory_menu;
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

{
This file has been generated by UnitParser v0.7, written by M. Knight
and updated by NP. v/d Spek and George Birbilis. 
Source Code from Carlo Kok has been used to implement various sections of
UnitParser. Components of ROPS are used in the construction of UnitParser,
code implementing the class wrapper is taken from Carlo Kok's conv utility

}
interface
 
uses
   SysUtils
  ,Classes
  ,uPSComponent
  ,uPSRuntime
  ,uPSCompiler
  ;
 
type 
(*----------------------------------------------------------------------------*)
  TPSImport_rm2x_inventory_menu = class(TPSPlugin)
  protected
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_TEquipmentPage(CL: TPSPascalCompiler);
procedure SIRegister_TGameEquipmentMenu(CL: TPSPascalCompiler);
procedure SIRegister_TEqInventoryMenu(CL: TPSPascalCompiler);
procedure SIRegister_TCharStatBox(CL: TPSPascalCompiler);
procedure SIRegister_rm2x_inventory_menu(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_TEquipmentPage(CL: TPSRuntimeClassImporter);
procedure RIRegister_TGameEquipmentMenu(CL: TPSRuntimeClassImporter);
procedure RIRegister_TEqInventoryMenu(CL: TPSRuntimeClassImporter);
procedure RIRegister_TCharStatBox(CL: TPSRuntimeClassImporter);
procedure RIRegister_rm2x_inventory_menu(CL: TPSRuntimeClassImporter);

procedure Register;

implementation


uses
   windows
  ,chipset_data
  ,item_data
  ,rpg_list
  ,script_backend
  ,rm2x_menu_components
  ,menu_basis
  ,frames
  ,asphyreSprite
  ,rm2x_inventory_menu
  ;
 
 
procedure Register;
begin
  RegisterComponents('Pascal Script', [TPSImport_rm2x_inventory_menu]);
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_TEquipmentPage(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TMenuPage', 'TEquipmentPage') do
  with CL.AddClassN(CL.FindClass('TMenuPage'),'TEquipmentPage') do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TGameEquipmentMenu(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TRm2kGameMenuBox', 'TGameEquipmentMenu') do
  with CL.AddClassN(CL.FindClass('TRm2kGameMenuBox'),'TGameEquipmentMenu') do
  begin
    RegisterMethod('Constructor Create( parent : TSpriteEngine; coords : TRect; main : TMenuEngine; owner : TMenuPage)');
    RegisterProperty('char', 'TRpgHero', iptrw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TEqInventoryMenu(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCustomScrollBox', 'TEqInventoryMenu') do
  with CL.AddClassN(CL.FindClass('TCustomScrollBox'),'TEqInventoryMenu') do
  begin
    RegisterMethod('Constructor Create( parent : TSpriteEngine; coords : TRect; main : TMenuEngine; owner : TMenuPage)');
    RegisterMethod('Procedure show( slot : TItemType)');
    RegisterProperty('char', 'TRpgHero', iptw);
    RegisterProperty('slot', 'byte', iptw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_TCharStatBox(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TSystemFrame', 'TCharStatBox') do
  with CL.AddClassN(CL.FindClass('TSystemFrame'),'TCharStatBox') do
  begin
    RegisterProperty('char', 'TRpgHero', iptw);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_rm2x_inventory_menu(CL: TPSPascalCompiler);
begin
  SIRegister_TCharStatBox(CL);
  SIRegister_TEqInventoryMenu(CL);
  SIRegister_TGameEquipmentMenu(CL);
  SIRegister_TEquipmentPage(CL);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure TGameEquipmentMenuchar_W(Self: TGameEquipmentMenu; const T: TRpgHero);
begin Self.char := T; end;

(*----------------------------------------------------------------------------*)
procedure TGameEquipmentMenuchar_R(Self: TGameEquipmentMenu; var T: TRpgHero);
begin T := Self.char; end;

(*----------------------------------------------------------------------------*)
procedure TEqInventoryMenuslot_W(Self: TEqInventoryMenu; const T: byte);
begin Self.slot := T; end;

(*----------------------------------------------------------------------------*)
procedure TEqInventoryMenuchar_W(Self: TEqInventoryMenu; const T: TRpgHero);
begin Self.char := T; end;

(*----------------------------------------------------------------------------*)
procedure TCharStatBoxchar_W(Self: TCharStatBox; const T: TRpgHero);
begin Self.char := T; end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TEquipmentPage(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TEquipmentPage) do
  begin
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TGameEquipmentMenu(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TGameEquipmentMenu) do
  begin
    RegisterPropertyHelper(@TGameEquipmentMenuchar_R,@TGameEquipmentMenuchar_W,'char');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TEqInventoryMenu(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TEqInventoryMenu) do
  begin
    RegisterMethod(@TEqInventoryMenu.show, 'show');
    RegisterPropertyHelper(nil,@TEqInventoryMenuchar_W,'char');
    RegisterPropertyHelper(nil,@TEqInventoryMenuslot_W,'slot');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_TCharStatBox(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TCharStatBox) do
  begin
    RegisterPropertyHelper(nil,@TCharStatBoxchar_W,'char');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_rm2x_inventory_menu(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TCharStatBox(CL);
  RIRegister_TEqInventoryMenu(CL);
  RIRegister_TGameEquipmentMenu(CL);
  RIRegister_TEquipmentPage(CL);
end;



{ TPSImport_rm2x_inventory_menu }
(*----------------------------------------------------------------------------*)
procedure TPSImport_rm2x_inventory_menu.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_rm2x_inventory_menu(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_rm2x_inventory_menu.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_rm2x_inventory_menu(ri);
end;
(*----------------------------------------------------------------------------*)


end.