unit EB_Messages;

interface
uses
   Classes,
   EventBuilder, EB_RpgScript;

type
   [UsesUnit('Messages')]
   TEBMessageObject = class(TEBObject);

   TEBShowMessage = class(TEBMessageObject)
   protected
      function MultilineText(indent, overhang: integer): string;
   public
      function GetScript(indent: integer): string; override;
      function GetLine: string;
      function GetNode: TEBNode; override;
   end;

   TEBMessageOptions = class(TEBMessageObject)
   public
      function GetScript(indent: integer): string; override;
      function GetNodeText: string; override;
   end;

   TEBPortrait = class(TEBMessageObject)
   public
      function GetScript(indent: integer): string; override;
      function GetNodeText: string; override;
   end;

   [UsesUnit('Messages')]
   TEBChoiceMessage = class(TEBCase)
   public
      constructor Create(AParent: TEBObject; choiceString: string; cancelCase: integer);
      function GetNodeText: string; override;
   end;

   TEBInputNumber = class(TEBMessageObject)
   public
      function GetScript(indent: integer): string; override;
      function GetNodeText: string; override;
   end;

implementation
uses
   SysUtils,
   EB_Expressions;

{ TEBShowMessage }

function TEBShowMessage.GetLine: string;
begin
   result := 'Message: ' + self.Text;
end;

function TEBShowMessage.GetNode: TEBNode;
var
   subobj: TEBObject;
begin
   result := inherited GetNode;
   for subobj in self do
   begin
      assert(subobj is TEBExtension);
      result.Add(subobj.GetNode);
   end;
end;

function TEBShowMessage.GetScript(indent: integer): string;
begin
   result := IndentString(indent) + format('ShowMessage(%s);', [self.MultilineText(indent, 12)]);
end;

function TEBShowMessage.MultilineText(indent, overhang: integer): string;
var
   wrap: string;
begin
   wrap := QuotedStr('+ CRLF +' + #13#10) + self.IndentString(indent) + StringOfChar(' ', overhang);
   result := QuotedStr(StringReplace(self.Text, #13#10, wrap, [rfReplaceAll]));
end;

{ TEBMessageOptions }

function TEBMessageOptions.GetNodeText: string;
begin
   result := 'Set Message Options: ';
   case boolean(Values[0]) of
      false: result := result + 'Opaque, ';
      true: result := result + 'Transparent, ';
   end;
   case Values[1] of
      0: result := result + 'Top, ';
      1: result := result + 'Middle, ';
      2: result := result + 'Bottom, ';
   end;
   case boolean(Values[2]) of
      false: result := result + 'Fixed Position, ';
      true: result := result + 'Don''t Hide Hero, ';
   end;
   case boolean(Values[3]) of
      false: result := result + 'Continue Events';
      true: result := result + 'Wait Until Done';
   end;
end;

function TEBMessageOptions.GetScript(indent: integer): string;
const
   CALL = 'messageOptions(%s, %s, %s, %s);';
   MBOX: array[1..3] of string = ('mb_top', 'mb_middle', 'mb_bottom');
begin
   result := format(CALL, [BOOL_STR[Values[0]], MBOX[values[1]],
                           BOOL_STR[values[2]], BOOL_STR[Values[3]]]);
end;

{ TEBPortrait }

function TEBPortrait.GetNodeText: string;
begin
   result := 'Set Message Face: ';
   if Text= '' then
      result := result + 'None'
   else
   begin
      result := result + Text + ' ' + intToStr(Values[0] + 1) + ', ';
      case boolean(Values[1]) of
         false: result := result + 'Left';
         true: result := result + 'Right';
      end;
      if Values[2] = 1 then
         result := result + ', Flipped';
   end; //end else
end;

function TEBPortrait.GetScript(indent: integer): string;
const
   CALL = 'setPortrait(%s, %d, %s, %s);';
begin
   if text = '' then
      result := 'clearPortrait;'
   else
      result := format(CALL, [quotedStr(text), Values[0], BOOL_STR[Values[1]],
                              BOOL_STR[Values[2]]]);
end;

{ TEBInputNumber }

function TEBInputNumber.GetNodeText: string;
const
   LINE = 'Input Number: %d Digits, Var[%d]';
begin
   result := format(LINE, [Values[0], Values[1]]);
end;

function TEBInputNumber.GetScript(indent: integer): string;
const
   LINE = 'variable[%d] := inputNumber(%d);';
begin
   result := IndentString(indent) + format(LINE, [Values[1], Values[0]]);
end;

{ TEBChoiceMessage }

constructor TEBChoiceMessage.Create(AParent: TEBObject; choiceString: string; cancelCase: integer);
var
   choice: TEBCall;
begin
   choice := TEBCall.Create('ShowChoice');
   choice.Add(TEBStringValue.Create(choiceString));
   choice.Add(TEBIntegerValue.Create(cancelCase));
   inherited Create(AParent, choice);
end;

function TEBChoiceMessage.GetNodeText: string;
begin
   result := 'Show Choice: ' + self.Text;
end;

initialization
   RegisterClasses([TEBShowMessage, TEBMessageOptions, TEBPortrait, TEBChoiceMessage,
                    TEBInputNumber]);
end.
