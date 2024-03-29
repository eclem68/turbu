{ *****************************************************************************
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
  ***************************************************************************** }

unit EditFullHeal;

interface

uses
   DBClient, Classes, Controls, ExtCtrls, DB, StdCtrls, DBCtrls,
   EventBuilder, variable_selector, ebPartyBase, IDLookupCombo, EBEdit,
   button_edit;

type
   [EditorCategory('Characters', 'Full Heal')]
   [EditorContext('RM2K')]
   TfrmEBEditFullHeal = class(TfrmEBPartyBase)
   protected
      function NewClassType: TEbClass; override;
   end;

implementation
uses
   EB_Characters, EB_Expressions;

{$R *.dfm}

{ TfrmEBFullHeal }

function TfrmEBEditFullHeal.NewClassType: TEbClass;
begin
   result := TEBFullHeal;
end;

initialization
   RegisterEbEditor(TEBFullHeal, TfrmEBEditFullHeal);
finalization
   UnRegisterEbEditor(TEBFullHeal);
end.
