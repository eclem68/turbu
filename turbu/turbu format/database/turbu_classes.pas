unit turbu_classes;
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
   classes, sysUtils, generics.collections, DB, RTTI,
   turbu_containers, turbu_defs, turbu_constants, turbu_serialization;

type
   TRpgDecl = class;

   {$M+}
   TRpgDatafile = class;
   TRpgObject = class;
   {$M-}

   TDatafileClass = class of TRpgDatafile;

   TScriptEvent = procedure(sender: TRpgObject) of object;

   {$M+}
   {If there ever was a time when it would be nice to have multiple inheritance
   in Delphi, this is it.  TRpgObject is the base class for a class tree that
   will mirror the TRpgDatafile tree in many (but not all) cases.  TRpgObjects
   will be the actual objects used in the game engine, while TRpgDatafile exists
   for the editor's benefit and consists of templates storing only the basic
   data necessary to instantiate their associated TRpgObjects at runtime.}
   TRpgObject = class abstract(TObject)
   private
      FTemplate: TRpgDatafile;
      FOnCreate: TScriptEvent;
      FOnDestroy: TScriptEvent;
   protected
      property Template: TRpgDatafile read FTemplate;
      class function templateClass: TDatafileClass; virtual; abstract;
   public
      //marked as overload to allow access to TObject.Create
      constructor Create(base: TRpgDatafile); overload;
   published
      property OnCreate: TScriptEvent read FOnCreate write FOnCreate;
      property OnDestroy: TScriptEvent read FOnDestroy write FOnDestroy;
   end;

   TDatafileIsUploadableAttribute = class(TIsUploadableAttribute)
   protected
      function IsUploadable(instance: TValue): boolean; override;
   end;

   TDatafileRelationKeyAttribute = class(TDBRelationKeyAttribute)
   protected
      procedure SetRelationKey(instance: TValue; DB: TDataSet); override;
   end;

   [TDatafileIsUploadableAttribute]
   [TDatafileRelationKeyAttribute]
   TRpgDatafile = class abstract(TObject)
   private
      function getSignature(methodname: string): TRpgDecl;
   protected
      FName: string;
      FId: smallint;
      FModified: boolean;
      FOnCreate: TScriptEvent;
      FOnDestroy: TScriptEvent;

      class function getSetLength(mySet: TByteSet): byte;
      class function keyChar: ansiChar; virtual; abstract; //this should be a lower-case letter
      class procedure readEnd(savefile: TStream);
      class procedure writeEnd(savefile: TStream);
      class function getDatasetName: string; virtual;
      {For any descendants that implement interfaces}
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
      function GetID: integer;
      function GetName: string;
   public
      constructor Create;
      constructor Load(savefile: TStream); virtual;
      procedure save(savefile: TStream); virtual;
      procedure upload(db: TDataSet);
      procedure download(db: TDataset); virtual;
      procedure CopyToClipboard;
      constructor PasteFromClipboard;
      function GetAllEvents: TStringList;

      {property }function datasetName: string; {read getDatasetName;} //hope they fix this...
      property signature[methodname: string]: TRpgDecl read getSignature;
      property name: string read FName write FName;
      property id: smallint read FId write FId;
      property modified: boolean read FModified write FModified;
   published
      property OnCreate: TScriptEvent read FOnCreate write FOnCreate;
      property OnDestroy: TScriptEvent read FOnDestroy write FOnDestroy;
   end;
   {$M-}

   TColorShift = packed record
   private type
      TColorArray = array[TColorSet] of single;
   private
      FColorset: TColorArray;
      FHue: shortint;

      function getColor(x: TColorSet): single;
      procedure setColor(x: TColorSet; value: single);
      function isClear: boolean;
   public
      property red: single index cs_red read getColor write setColor;
      property green: single index cs_green read getColor write setColor;
      property blue: single index cs_blue read getColor write setColor;
      property sat: single index cs_sat read getColor write setColor;
      property hue: shortint read FHue write FHue;
      property clear: boolean read isClear;
   end;

   TStreamEx = class helper for TStream
   public
      procedure writeString(const data: string);
      function readString: string;
      procedure writeAString(data: AnsiString);
      function readAString: AnsiString;
      procedure writeChar(data: ansiChar);
      function readChar: ansiChar;
      procedure writeBool(data: boolean);
      function readBool: boolean;
      procedure writeByte(data: byte);
      function readByte: byte;
      procedure writeWord(data: word);
      function readWord: word;
      procedure writeInt(data: integer);
      procedure readList<T>(data: TList<T>);
      procedure writeList<T>(data: TList<T>);
      procedure readDict<T: TRpgDatafile, constructor>(data: TDictionary<string, T>);
      procedure writeDict<T: TRpgDatafile>(data: TDictionary<string, T>);
      function readInt: integer;
      function eof: boolean;
      procedure rewind;
   end;

   TRpgDataList<T: TRpgDatafile, constructor> = class(TRpgObjectList<T>)
   private
      type TEnumerator = record
      private
         FIndex: Integer;
         FMyList: TRpgDataList<T>;
      public
         constructor Create(AMyList: TRpgDataList<T>);
         function MoveNext: Boolean; inline;
         function GetCurrent: T; inline;
         property Current: T read GetCurrent;
      end;
   public
      constructor Create; virtual;
      constructor Load(savefile: TStream); virtual;
      procedure save(savefile: TStream); virtual;
      procedure upload(db: TDataSet); virtual;
      function GetEnumerator: TEnumerator;
   end;

   TNameTypeList = TList<TNameType>;

   TRpgDecl = class(TEnumerable<TNameType> {TObject})
   private
      FName: string;
      FDesignName: string;
      FRetval: integer;
      FParams: TNameTypeList;
   protected
      function DoGetEnumerator: TEnumerator<TNameType>; override;
   public
      constructor Create(aName: string; aDesignName: string); overload;
      destructor Destroy; override;

      function equals(other: TRpgDecl): boolean; reintroduce;
      function fourInts: boolean;
      function Clone: TRpgDecl;

      property name: string read FName write FName;
      property designName: string read FDesignName write FDesignName;
      property retval: integer read FRetval write FRetval;
      property params: TNameTypeList read FParams write FParams;
   end;

   TDeclList = class(TRpgObjectList<TRpgDecl>)
   private
      function getLookup(value: string): TRpgDecl;
   public
      constructor Create;
      function IndexOf(const Value: string): Integer;
      procedure Sort;

      property decl[value: string]: TRpgDecl read getLookup;
   end;

   TFieldExt = class helper for TField
   private
      function getByteSet: TByteSet;
      procedure setByteSet(const Value: TByteSet);
      function getPSMethod: TMethod;
      procedure setPSMethod(const Value: TMethod);
   public
      property asSet: TByteSet read getByteSet write setByteSet;
      property asPSMethod: TMethod read getPSMethod write setPSMethod;
   end;

   TSafeDataset = class helper for TDataset
   public
      procedure postSafe;
   end;

   TUploadByteSetAttribute = class(TDBUploadAttribute)
   public
      procedure upload(db: TDataset; field: TRttiField; instance: TObject); override;
      procedure download(db: TDataset; field: TRttiField; instance: TObject); override;
   end;

   EventTypeAttribute = class(TCustomAttribute)
   private
    FName: string;
   public
      constructor Create(const name: string);
      property name: string read FName;
   end;

   ERpgLoadError = class(Exception);

   procedure lassert(cond: boolean);

implementation
uses
windows,
   Generics.Defaults, TypInfo, Math, Clipbrd,
   commons, turbu_decl_utils, turbu_functional,
   ps_pointer, rttiHelper;

type
   TSetSaver = record
      case boolean of
         true: (aSet: TByteSet);
         false: (aArray: packed array[1..32] of byte);
   end;

threadvar
   currentloader: TStream;

{ TColorShift }

function TColorShift.getColor(x: TColorSet): single;
begin
   result := FColorset[x];
end;

procedure TColorShift.setColor(x: TColorSet; value: single);
begin
   clamp(value, 0, 2);
   FColorset[x] := value;
end;

function TColorShift.isClear: boolean;
begin
   result := (FColorset[cs_red] = 0) and (FColorset[cs_green] = 0) and (FColorset[cs_blue] = 0)
             and (FColorset[cs_sat] = 0) and (FHue = 0);
end;

{ TRpgDatafile }

procedure TRpgDatafile.CopyToClipboard;
var
   format: cardinal;
   stream: TMemoryStream;
   block: THandle;
   ptr: pointer;
begin
   format := windows.RegisterClipboardFormat(PChar('CF_' + self.ClassName));
   stream := TMemoryStream.Create;
   clipboard.Open;
   try
      self.save(stream);
      EmptyClipboard;
      block := GlobalAlloc(GMEM_DDESHARE or GMEM_MOVEABLE, stream.Size);
      ptr := GlobalLock(block);
      stream.rewind;
      stream.Read(ptr^, stream.size);
      GlobalUnLock(block);
      SetClipboardData(format, block);
   finally
      clipboard.Close;
      stream.Free;
   end;
end;

constructor TRpgDatafile.PasteFromClipboard;
var
   format: cardinal;
   stream: TMemoryStream;
   block: THandle;
   ptr: pointer;
begin
   format := windows.RegisterClipboardFormat(PChar('CF_' + self.ClassName));
   if not clipboard.HasFormat(format) then
      raise EClipboardException.CreateFmt('Clipboard does not contain data for a %s object.', [self.ClassName]);
   stream := TMemoryStream.Create;
   clipboard.Open;
   try
      block := GetClipboardData(format);
      ptr := GlobalLock(block);
      stream.Write(ptr^, GlobalSize(block));
      GlobalUnLock(block);
      stream.rewind;
      self.Load(stream);
   finally
      clipboard.Close;
      stream.Free;
   end;
end;

constructor TRpgDatafile.Create;
begin
  inherited Create; //required by the generics system
end;

function TRpgDatafile.datasetName: string;
begin
   result := self.getDatasetName;
end;

procedure TRpgDatafile.download(db: TDataset);
var
   serializer: TDatasetSerializer;
begin
   if self.datasetName <> '' then
      assert((db.Name = self.datasetName) or (self.datasetName[1] = '_'));

   serializer := TDatasetSerializer.Create;
   try
      serializer.download(self, db);
   finally
      serializer.Free;
   end;
end;

procedure TRpgDatafile.upload(db: TDataSet);
var
   serializer: TDatasetSerializer;
begin
   if self.datasetName <> '' then
      assert((db.Name = self.datasetName) or (self.datasetName[1] = '_'));

   serializer := TDatasetSerializer.Create;
   try
      serializer.upload(self, db);
   finally
      serializer.Free;
   end;
end;

function TRpgDatafile.GetAllEvents: TStringList;
var
   list: PPropList;
   i, count: integer;
   event: TMethod;
begin
   new(list);
   try
      //get all published methods (events)
      count := GetPropList(PTypeInfo(self.ClassInfo), [tkMethod], list, false);

      //fill a TStringList with the method names and addresses
      result := TStringList.Create;
      for I := 0 to Count - 1 do
      begin
         if LowerCase(copy(string(list[i].Name), 1, 2)) = 'on' then
         begin
            event := GetMethodProp(self, string(list[i].name));
            result.AddObject(string(list[i].Name), event.Code);
            if assigned(event.data) then
               assert(event.Data = self);
         end;
      end;
   finally
      dispose(list);
   end;
end;

class function TRpgDatafile.getDatasetName: string;
begin
   result := '';
end;

function TRpgDatafile.GetID: integer;
begin
   result := self.id;
end;

function TRpgDatafile.GetName: string;
begin
   result := self.name;
end;

class function TRpgDatafile.getSetLength(mySet: TByteSet): byte;
var
   setSaver: TSetSaver;
begin
   if mySet = [] then
      Exit(0);

   setSaver.aSet := mySet;
   result := 32;
   while (result > 0) and (setSaver.aArray[result] = 0) do
      dec(result);
end;

function TRpgDatafile.getSignature(methodname: string): TRpgDecl;
var
   name: string;
   typename: EventTypeAttribute;
   prop: TRttiProperty;
begin
   prop := TRttiContext.Create.GetType(self.classtype).GetProperty(methodname);
   if not assigned(prop) then
      raise EPropertyError.CreateFmt('Event %s does not exist in class %s.', [methodname, self.ClassName]);
   typename := prop.GetAttribute(EventTypeAttribute) as EventTypeAttribute;
   if assigned(typename) then
      name := typename.name
   else name := prop.PropertyType.Name;
   result := turbu_decl_utils.GetSignature(name);
end;

class procedure TRpgDatafile.writeEnd(savefile: TStream);
begin
   savefile.writeChar(upCase(keyChar));
end;

class procedure TRpgDatafile.readEnd(savefile: TStream);
begin
   lassert(savefile.readChar = UpCase(keyChar));
end;

{$Q-}{$R-}
constructor TRpgDatafile.Load(savefile: TStream);
begin
   currentloader := savefile;
   FId := savefile.readWord;
   FName := savefile.readString;
end;

procedure TRpgDatafile.save(savefile: TStream);
begin
   savefile.WriteWord(FId);
   savefile.WriteString(FName);
end;
{$Q+}{$R+}

function TRpgDatafile.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TRpgDatafile._AddRef: Integer;
begin
   result := -1;
end;

function TRpgDatafile._Release: Integer;
begin
   result := -1;
end;

{ TStreamEx }

function TStreamEx.eof: boolean;
begin
   result := self.Position = self.Size;
end;

{$Q-}{$R-}
function TStreamEx.readAString: AnsiString;
var
   len: integer;
begin
   try
      self.readBuffer(len, 4);
      if len > 0 then
      begin
         setLength(result, len);
         self.ReadBuffer(result[1], len);
      end;
   except
      on EIntOverflow do
         result := '';
   end;
end;

function TStreamEx.readBool: boolean;
begin
   self.ReadBuffer(result, 1);
end;

function TStreamEx.readByte: byte;
begin
   self.ReadBuffer(result, 1);
end;

function TStreamEx.readChar: ansiChar;
begin
   self.ReadBuffer(result, 1);
end;

function TStreamEx.readInt: integer;
begin
   self.readBuffer(result, 4);
end;

procedure TStreamEx.readList<T>(data: TList<T>);
var
   i: integer;
   value: T;
begin

   i := self.readInt;
   data.Capacity := i;
   for I := 0 to i - 1 do
   begin
      self.Read(value, sizeof(T));
      data.Add(value);
   end;
end;

procedure TStreamEx.readDict<T>(data: TDictionary<string, T>);
var
   i: integer;
begin
   for i := 1 to self.readInt do
      data.Add(self.readString, T.Load(self));
end;

function TStreamEx.readString: string;
var
   len: integer;
   iString: UTF8String;
begin
   try
      self.readBuffer(len, 4);
      if len > 0 then
      begin
         setLength(iString, len);
         self.ReadBuffer(iString[1], len);
         result := string(iString);
      end;
   except
      on EIntOverflow do
         result := '';
      else raise;
   end;
end;

function TStreamEx.readWord: word;
begin
   self.readBuffer(result, 2);
end;

procedure TStreamEx.rewind;
begin
   self.Seek(0, soFromBeginning);
end;

procedure TStreamEx.writeAString(data: AnsiString);
var
   len: cardinal;
begin
   len := length(data);
   self.WriteBuffer(len, 4);
   if len > 0 then
      self.WriteBuffer(data[1], len);
end;

procedure TStreamEx.writeBool(data: boolean);
begin
   self.WriteBuffer(data, 1);
end;

procedure TStreamEx.writeByte(data: byte);
begin
   self.WriteBuffer(data, 1);
end;

procedure TStreamEx.writeChar(data: ansiChar);
begin
   self.WriteBuffer(data, 1);
end;

procedure TStreamEx.writeInt(data: integer);
begin
   self.WriteBuffer(data, 4);
end;

procedure TStreamEx.writeList<T>(data: TList<T>);
var
   value: T;
begin
   self.writeInt(data.Count);
   for value in data do
      self.write(value, sizeof(T));
end;

procedure TStreamEx.writeDict<T>(data: TDictionary<string, T>);
var
   enumerator: TPair<string, T>;
begin
   self.writeInt(data.Count);
   for enumerator in data do
   begin
      self.writeString(enumerator.Key);
      enumerator.Value.save(self);
   end;
end;

procedure TStreamEx.writeString(const data: string);
var
   len: cardinal;
   oString: UTF8String;
begin
   oString := UTF8String(data);
   len := length(oString);
   self.WriteBuffer(len, 4);
   if len > 0 then
      self.WriteBuffer(oString[1], len);
end;

procedure TStreamEx.writeWord(data: word);
begin
   self.WriteBuffer(data, 2);
end;
{$Q+}{$R+}

{ Classless }

procedure lassert(cond: boolean);
begin
   if not cond then
      raise ERpgLoadError.Create('Savefile corrupt at address ' + intToStr(currentloader.Position));
end;

{ TDeclList }

function declComp(const Left, Right: TRpgDecl): Integer;
begin
   result := CompareText(left.name, right.name)
end;

constructor TDeclList.Create;
begin
   inherited Create(TComparer<TRpgDecl>.Construct(declComp));
   Self.OwnsObjects := true;
end;

function TDeclList.getLookup(value: string): TRpgDecl;
begin
   result := self[indexOf(value)];
end;

function TDeclList.IndexOf(const Value: string): Integer;
var
   dummy: TRpgDecl;
begin
   dummy := TRpgDecl.Create(value, '');
   try
      if not self.BinarySearch(dummy, result) then
         result := -1;
   finally
      dummy.Free;
   end;
end;

procedure TDeclList.Sort;
var
   i: integer;
begin
   inherited Sort;
   i := 1;
   while i < self.Count do
   begin
      if self[i].name = self[i - 1].name then
         self.Delete(i)
      else inc(i);
   end;
end;

{ TRpgDecl }

constructor TRpgDecl.Create(aName, aDesignName: string);
begin
   FName := aName;
   FDesignName := aDesignName;
   FParams := TNameTypeList.Create;
end;

destructor TRpgDecl.Destroy;
begin
   FParams.Free;
   inherited Destroy;
end;

function TRpgDecl.Clone: TRpgDecl;
var
   param: TNameType;
begin
   result := TRpgDecl.Create(FName, FDesignName);
   result.FParams := TNameTypeList.Create;
   for param in self.FParams do
     result.FParams.Add(param);
end;

function TRpgDecl.DoGetEnumerator: TEnumerator<TNameType>;
begin
   result := FParams.GetEnumerator;
end;

function TRpgDecl.equals(other: TRpgDecl): boolean;
var
   i: integer;
begin
   result := (FParams.Count = other.params.Count) and (Self.retval = other.retval);
   if result then
      for i := 0 to FParams.Count - 1 do
         result := result and (FParams[i].typeVar = other.params[i].typeVar)
                   and (FParams[i].flags = other.params[i].flags)
end;

function TRpgDecl.fourInts: boolean;
var
   i: integer;
begin
   result := FParams.Count >= 5;
   if result then
      for I := 1 to 4 do
         result := result and (FParams[i].typeVar = vt_S32);
end;

{ TFieldExt }

function TFieldExt.getByteSet: TByteSet;
begin
   assert(self.DataSize = SizeOf(Result));
   assert(self.GetData(@Result));
end;

procedure TFieldExt.setByteSet(const Value: TByteSet);
begin
   assert(self.DataSize = SizeOf(Value));
   self.SetData(@value);
end;

function TFieldExt.getPSMethod: TMethod;
begin
   result.Code := ps_pointer.mamhLoc;
   result.Data := pointer(Self.AsInteger);
end;

procedure TFieldExt.setPSMethod(const Value: TMethod);
begin
   assert(value.Code = ps_pointer.mamhLoc);
   self.asInteger := integer(Value.Data);
end;

{ TSafeDataset }

procedure TSafeDataset.postSafe;
begin
   if self.state in dsEditModes then
      self.Post;
end;

{ TRpgDataList<T> }

constructor TRpgDataList<T>.Create;
begin
   inherited Create(true);
   self.Add(T.Create);
end;

function TRpgDataList<T>.GetEnumerator: TEnumerator;
begin
   result := TEnumerator.Create(self);
end;

constructor TRpgDataList<T>.Load(savefile: TStream);
var
   i: integer;
begin
   self.Create;
   lassert(savefile.readChar = T.keyChar);
   self.Capacity := savefile.readInt + 1;
   for I := 1 to self.Capacity - 1 do
      self.Add(T.load(savefile));
   lassert(savefile.readChar = UpCase(T.keyChar));
end;

procedure TRpgDataList<T>.save(savefile: TStream);
var
   iterator: T;
begin
   savefile.writeChar(UpCase(T.keyChar));
   savefile.writeInt(self.High);
   for iterator in self do
      if iterator.id = 0 then
         Continue
      else iterator.save(savefile);
   savefile.writeChar(T.keyChar);
end;

procedure TRpgDataList<T>.upload(db: TDataSet);
var
   iterator: T;
begin
   for iterator in self do
   begin
      if iterator.id = 0 then
         Continue
      else iterator.upload(db);
   end;
   if self.Count > 1 then
      db.postSafe;
end;

{ TRpgObject }

constructor TRpgObject.Create(base: TRpgDatafile);
begin
   FTemplate := base;
   assert(base is self.templateClass);
end;

{ TRpgDataList<T>.TEnumerator }

constructor TRpgDataList<T>.TEnumerator.Create(AMyList: TRpgDataList<T>);
begin
   FMyList := AMyList;
   FIndex := 0;
end;

function TRpgDataList<T>.TEnumerator.GetCurrent: T;
begin
   Result := FMyList[FIndex];
end;

function TRpgDataList<T>.TEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FMyList.Count - 1;
  if Result then
    Inc(FIndex);
end;

{ TUploadByteSetAttribute }

procedure TUploadByteSetAttribute.download(db: TDataset; field: TRttiField; instance: TObject);
begin
   field.SetValue(instance, TValue.From<TByteSet>(TDatasetSerializer.getField(db, field).asSet));
end;

procedure TUploadByteSetAttribute.upload(db: TDataset; field: TRttiField; instance: TObject);
begin
   TDatasetSerializer.getField(db, field).asSet := field.GetValue(instance).AsType<TByteSet>;
end;

{ TDatafileIsUploadableAttribute }

function TDatafileIsUploadableAttribute.IsUploadable(instance: TValue): boolean;
var
   datafile: TRpgDatafile;
begin
   datafile := instance.AsObject as TRpgDatafile;
   result := datafile.id <> 0;
end;

{ TDatafileRelationKeyAttribute }

procedure TDatafileRelationKeyAttribute.SetRelationKey(instance: TValue;
  DB: TDataSet);
var
   datafile: TRpgDatafile;
begin
   datafile := instance.AsType<TRpgDatafile>;
   db.FieldByName('master').AsInteger := datafile.id;
end;

{ EventTypeAttribute }

constructor EventTypeAttribute.Create(const name: string);
begin
   FName := name;
end;

end.