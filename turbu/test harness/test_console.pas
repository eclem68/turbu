unit test_console;
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
  SysUtils, Classes, Controls, Forms, Menus, StdCtrls, Dialogs,
  turbu_map_engine, turbu_map_interface,
  database;

type
   TfrmTestConsole = class(TForm)
      MainMenu1: TMainMenu;
      mnuDatabase: TMenuItem;
      mnuTestDatasets: TMenuItem;
      mnuTestLoading: TMenuItem;
      mnuTestDatabasewindow1: TMenuItem;
      mnuFile: TMenuItem;
      mnuTestConversion1: TMenuItem;
      mnuSetDefaultProject: TMenuItem;
      mnuGraphics: TMenuItem;
      mnuCreateSdlWindow: TMenuItem;
      mnuTestSDL: TMenuItem;
      mnuTestMapLoading: TMenuItem;
      mnuTree: TMenuItem;
      mnuTestMapTree: TMenuItem;
      estLDBLoading1: TMenuItem;
      mnuEditMapProperties: TMenuItem;
      mnuTestMapResizing: TMenuItem;
      mnuDebugMapResizing: TMenuItem;
      N2: TMenuItem;
      estRenderTargets1: TMenuItem;
      mnuEventEditor: TMenuItem;
      mnuMaps: TMenuItem;
      mnuTestMapObjectContainers: TMenuItem;
      mnuTestDatabaseUpload: TMenuItem;
      mnuTestPartySetup: TMenuItem;
    mnuGenerateDBScript: TMenuItem;
    txtOutput: TMemo;
    estTextRendering1: TMenuItem;
    mnuTestMessageBox: TMenuItem;
    mnuTestGameEngine: TMenuItem;
      procedure mnuTestDatasetsClick(Sender: TObject);
      procedure mnuTestLoadingClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure mnuTestDatabasewindow1Click(Sender: TObject);
      procedure mnuTestConversion1Click(Sender: TObject);
      procedure mnuSetDefaultProjectClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure mnuCreateSdlWindowClick(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure mnuTestSDLClick(Sender: TObject);
      procedure mnuTestMapLoadingClick(Sender: TObject);
      procedure mnuTestMapTreeClick(Sender: TObject);
      procedure estLDBLoading1Click(Sender: TObject);
      procedure mnuEditMapPropertiesClick(Sender: TObject);
      procedure mnuTestMapResizingClick(Sender: TObject);
      procedure mnuDebugMapResizingClick(Sender: TObject);
      procedure estRenderTargets1Click(Sender: TObject);
      procedure mnuEventEditorClick(Sender: TObject);
      procedure mnuTestMapObjectContainersClick(Sender: TObject);
      procedure mnuTestDatabaseUploadClick(Sender: TObject);
      procedure mnuTestPartySetupClick(Sender: TObject);
    procedure mnuGenerateDBScriptClick(Sender: TObject);
    procedure estTextRendering1Click(Sender: TObject);
    procedure mnuTestMessageBoxClick(Sender: TObject);
    procedure mnuTestGameEngineClick(Sender: TObject);
   private
      { Private declarations }
      FEngine: IDesignMapEngine;
      folder, outFolder: string;
      FCurrentMap: IRpgMap;
      procedure setupConversionPaths;
      procedure renderTest(Sender: TObject);
   public
      { Public declarations }
   end;

var
  frmTestConsole: TfrmTestConsole;

implementation

uses
   Contnrs, DB, DBClient, Generics.Collections, Registry, windows, Variants,
   Opengl,
   dm_database, turbu_database, test_project, dm_shaders,
   archiveInterface, discInterface, test_map_tree, test_canvas,
   turbu_constants, conversion_report, conversion_report_form,
   rm2_turbu_converter_thread, turbu_OpenGL, turbu_2k_frames,
   commons, fileIO, formats, LDB, LMT, LMU, timing, project_folder,
   turbu_characters, locate_files, map_tree_controller, turbu_containers,
   rm2_turbu_characters, rm2_turbu_database,
   turbu_engines, turbu_plugin_interface, turbu_battle_engine,
   turbu_2k3_battle_engine, turbu_2k_battle_engine, turbu_sprites,
   turbu_maps, turbu_classes, turbu_2k_map_engine_D,
   turbu_tbi_lib, turbu_sdl_image, EventBuilder,
   MapObject_Editor,
   sdl_canvas, sdl_13, SG_defs,
   test_map_size, turbu_text_utils;

{$R *.dfm}

var
   freeList: TObjectList;
   lCanvas: TSdlCanvas;

procedure TfrmTestConsole.mnuTestDatabaseUploadClick(Sender: TObject);
begin
   if not assigned(GDatabase) then
      mnuTestLoadingClick(Sender);
   GDatabase.copyToDB(dmDatabase, []);

   if sender = mnuTestDatabaseUpload then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuTestDatabasewindow1Click(Sender: TObject);
var
   frmDatabase: TFrmDatabase;
begin
   if not dmDatabase.charClasses.Active then
      mnuTestDatasetsClick(sender);
   if VarIsNull(dmDatabase.switches.Lookup('id', 0, 'DisplayName')) then
      mnuTestDatabaseUploadClick(Sender);

   frmDatabase := TFrmDatabase.Create(nil);
   try
      frmDatabase.init(GDatabase);
      frmDatabase.ShowModal;
   finally
      frmDatabase.Free;
   end;
end;

procedure TfrmTestConsole.mnuCreateSdlWindowClick(Sender: TObject);
var
   form: TfrmTesting;
begin
   if not assigned(lCanvas) then
   begin
      form := TfrmTesting.Create(self);
      form.Show;
      Application.ProcessMessages;
      form.SdlFrame1.LogicalSize := point(960, 720);
      lCanvas := TSdlCanvas.CreateFrom(form.SdlFrame1.SdlWindow);
   end;
   if (sender = mnuCreateSdlWindow) and (assigned(lCanvas)) then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuSetDefaultProjectClick(Sender: TObject);
begin
   frmTestProjLocation.getLocation(folder);
   setupConversionPaths;
end;

procedure TfrmTestConsole.mnuTestConversion1Click(Sender: TObject);

   procedure openArchive(folderName: string; index: integer);
   var
      filename: string;
   begin
      filename := IncludeTrailingPathDelimiter(outFolder) + folderName;
      assert(GArchives.Add(newFolder(filename)) = index);
   end;

var
   filename: string;
   conversionReport: IConversionReport;
begin
   GArchives.clearFrom(1);
   openArchive(MAP_DB, MAP_ARCHIVE);
   openArchive(IMAGE_DB, IMAGE_ARCHIVE);
   openArchive(SCRIPT_DB, SCRIPT_ARCHIVE);
   openArchive(MUSIC_DB, MUSIC_ARCHIVE);
   openArchive(SFX_DB, SFX_ARCHIVE);
   openArchive(VIDEO_DB, VIDEO_ARCHIVE);

   filename := IncludeTrailingPathDelimiter(folder);

   GCurrentFolder := folder;
   GProjectFolder := outFolder;

   frmConversionReport := TfrmConversionReport.Create(Application);
   ConversionReport := frmConversionReport;
   frmConversionReport.thread := TConverterThread.Create(conversionReport, folder, outFolder, pf_2k);
   case frmConversionReport.ShowModal of
      mrOk:;
      else ;
   end;
end;

procedure TfrmTestConsole.mnuTestMapLoadingClick(Sender: TObject);
begin
   if not assigned(GDatabase) then
      mnuTestLoadingClick(Sender);
   if not assigned(lCanvas) then
      mnuCreateSdlWindowClick(sender);

   FEngine.loadMap(GDatabase.mapTree[8]);
   FCurrentMap := T2kMapEngineD(FEngine).CurrentMap.mapObj;

   if sender = mnuTestMapLoading then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuEditMapPropertiesClick(Sender: TObject);
begin
   if not assigned(FEngine) then
      mnuTestLoadingClick(Sender);

   FEngine.editMapProperties(1);
   if sender = mnuEditMapProperties then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuEventEditorClick(Sender: TObject);
var
   map: TRpgMap;
begin
   mnuTestDatabaseUploadClick(sender);

   map := TRpgMap(FCurrentMap);
   TfrmObjectEditor.EditMapObject(map.mapObjects[1], map,
                                  GDatabase.tileset[map.tileset].name);
   if sender = mnuEventEditor then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuTestGameEngineClick(Sender: TObject);
begin
   if FEngine = nil then
      mnuTestLoadingClick(sender);
   FEngine.Start;
//   if sender = mnuTestGameEngine then
//      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.estLDBLoading1Click(Sender: TObject);
var
   fromFolder: IArchive;
   FLdb: TLcfDatabase;
   datafile, optimStream: TStream;
//   legacy: TLegacySections;
//   key: byte;
const
	SECTIONS_I_KNOW_HOW_TO_READ = [$0b..$0d, $11..$14, $17..$18, $1e];
begin
   optimStream := nil;
   fLDB := nil;
//   legacy := nil;
   fromFolder := discInterface.openFolder(folder);
   try
      datafile := fromFolder.getFile('RPG_RT.ldb');
      try
         optimStream := TMemoryStream.Create;
            optimStream.CopyFrom(dataFile, datafile.Size);
         optimStream.rewind;
         if getString(optimStream) <> 'LcfDataBase' then
            raise EParseMessage.create('RPG_RT.LDB is corrupt!');

         GProjectFormat := scanRmFormat(optimStream);
OutputDebugString('SAMPLING ON');
         FLdb := TLcfDataBase.Create(optimStream);
OutputDebugString('SAMPLING OFF');
         //end of format and database check
{         legacy := TLegacySections.Create;
         optimStream.rewind;
         getString(optimStream);
         while not optimStream.eof do
         begin
            key := peekAhead(optimStream);
            if not key in SECTIONS_I_KNOW_HOW_TO_READ then
               legacy.Add(key, getStrSec(key, optimStream, nil))
            else skipSec(key, optimStream);
         end;}
      finally
         datafile.Free;
         optimStream.Free;
      end;
   finally
      FLdb.Free;
//      legacy.Free;
   end;
   application.MessageBox('Test completed successfully!', 'Done loading LDB');
end;

procedure TfrmTestConsole.mnuTestMapTreeClick(Sender: TObject);
var
   form: TfrmMapTree;
begin
   if not assigned(GDatabase) then
      mnuTestLoadingClick(Sender);
   form := TfrmMapTree.Create(nil);
   try
      form.trvMapTree.buildMapTree(GDatabase.mapTree);
      form.ShowModal;
   finally
      form.Free;
   end;
end;

procedure TfrmTestConsole.mnuTestMessageBoxClick(Sender: TObject);
var
  i: Integer;
begin
   if not assigned(FEngine) then
      mnuTestLoadingClick(Sender);

   TThread.CreateAnonymousThread(
      procedure
      begin
         GMenuEngine.ShowMessage('Testing 123', false);
      end).Start;
   sleep(100);
   for i := 1 to 20 do
   begin
      glEnable(GL_ALPHA_TEST);
      glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
      glEnable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


      GMenuEngine.Draw;
      SDL_RenderPresent(lCanvas.Renderer);
      sleep(64);
//      TRpgTimestamp.frameLength := 64;
   end;
end;

procedure TfrmTestConsole.mnuTestPartySetupClick(Sender: TObject);
var
   i, j: integer;
begin
   if not assigned(FEngine) then
      mnuTestLoadingClick(Sender);
   FEngine.Play;
   for j := 0 to 14 do
      for i := 0 to 19 do
         FEngine.rightClick(SGPoint(i, j));
   if sender = mnuTestPartySetup then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.setupConversionPaths;
var
   dummy: string;
begin
  folder := IncludeTrailingPathDelimiter(GetRegistryValue('\Software\TURBU', 'TURBU Test Project'));
  if folder <> '\' then
  begin
    dummy := ExtractFileName(ExcludeTrailingPathDelimiter(folder));
    outFolder := getProjectFolder + dummy;
  end;
end;

procedure TfrmTestConsole.mnuTestMapResizingClick(Sender: TObject);
var
   map: TRpgMap;
   i: Integer;
   newsize: TSgPoint;
   mode: byte;
   msg: string;
begin
   if not assigned(FEngine) then
      mnuTestLoadingClick(Sender);

   map := (FCurrentMap as TRpgMap);
   for i := 1 to 100 do
   begin
      newsize := sgPoint(Random(300) + 1, Random(300) + 1);
      mode := random(9) + 1;
      msg := format('Resizing: (%d, %d), mode %d.', [newsize.x, newsize.y, mode]);
      OutputDebugString(PChar(msg));
      map.calcBlitBounds(newsize, mode);
   end;
   if sender = mnuTestMapResizing then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuDebugMapResizingClick(Sender: TObject);
var
   map: TRpgMap;
   newsize: TSgPoint;
   mode: byte;
begin
   if not assigned(FEngine) then
      mnuTestLoadingClick(Sender);

   map := (FCurrentMap as TRpgMap);
   frmTestMapSize.showmodal;
   newsize := sgPoint(frmTestMapSize.spnX.Value, frmTestMapSize.spnY.Value);
   mode := frmTestMapSize.spnMode.Value;
   asm int 3 end;
   map.adjustSize(newsize, mode);
   if sender = mnuDebugMapResizing then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.FormCreate(Sender: TObject);
begin
   if getProjectFolder = '\' then
      createProjectFolder;
   TEBObject.Datastore := dmDatabase;
end;

procedure TfrmTestConsole.FormDestroy(Sender: TObject);
begin
   TEBObject.Datastore := nil;
   lCanvas.Free;
   FCurrentMap := nil;
   FEngine := nil;
end;

procedure TfrmTestConsole.FormShow(Sender: TObject);
type
   TBattleEngineClass = class of TBattleEngine;
   TMapEngineClass = class of TMapEngine;

   {$WARN CONSTRUCTING_ABSTRACT OFF}
   procedure addBattleEngine(aClass: TBattleEngineClass);
   var
      engine: TBattleEngine;
   begin
      engine := aClass.Create;
      addEngine(et_battle, engine.data, engine);
   end;

   procedure AddMapEngine(aClass: TMapEngineClass);
   var
      engine: TMapEngine;
   begin
      engine := aClass.Create;
      addEngine(et_map, engine.data, engine);
   end;
   {$WARN CONSTRUCTING_ABSTRACT ON}

begin
   JITEnable := 0;
   GProjectFolder := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
   assert(GArchives.Add(openFolder(GProjectFolder + DESIGN_DB)) = BASE_ARCHIVE);
   addBattleEngine(T2kBattleEngine);
   addBattleEngine(T2k3BattleEngine);
   addMapEngine(T2kMapEngineD);
   setupConversionPaths;
   mnuTestConversion1.Enabled := folder <> '\';
end;

procedure TfrmTestConsole.mnuGenerateDBScriptClick(Sender: TObject);
begin
   if not dmDatabase.charClasses.Active then
      mnuTestDatasetsClick(sender);
   txtOutput.Lines.text := dmDatabase.dbScript;
   if sender = mnuGenerateDBScript then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuTestDatasetsClick(Sender: TObject);
var
   dataset: TCustomClientDataSet;
begin
   if dmDatabase = nil then
      mnuTestLoadingClick(sender);
   for dataset in dmDatabase.datasets do
   try
      dataset.Close;
      dataset.CreateDataSet;
   except
      asm int 3 end;
      Abort;
   end;
   if sender = mnuTestDatasets then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuTestLoadingClick(Sender: TObject);
var
   location: string;

   procedure openArchive(folderName: string; index: integer);
   var
      filename: string;
   begin
      filename := location + folderName;
      assert(GArchives.Add(openFolder(filename)) = index);
   end;

begin
   if not assigned(lCanvas) then
      mnuCreateSdlWindowClick(sender);
   if assigned(GDatabase) then
      Exit;
   try
      location := IncludeTrailingPathDelimiter(GetRegistryValue('\Software\TURBU', 'TURBU Test Project Output'));
      GArchives.clearFrom(1);
      openArchive(MAP_DB, MAP_ARCHIVE);
      openArchive(IMAGE_DB, IMAGE_ARCHIVE);
      openArchive(SCRIPT_DB, SCRIPT_ARCHIVE);
      openArchive(MUSIC_DB, MUSIC_ARCHIVE);
      openArchive(SFX_DB, SFX_ARCHIVE);
      openArchive(VIDEO_DB, VIDEO_ARCHIVE);
      FEngine := T2kMapEngineD.Create;
      FEngine.initialize(lCanvas.Window, IncludeTrailingPathDelimiter(location) + DBNAME);
   except
      asm int 3 end;
      Abort;
   end;
   if sender = mnuTestLoading then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.mnuTestSDLClick(Sender: TObject);
begin
   if not assigned(GDatabase) then
      mnuTestLoadingClick(Sender);
   if not assigned(lCanvas) then
      mnuCreateSdlWindowClick(Sender);

   renderTest(sender);
   SDL_RenderPresent(lcanvas.Renderer);
   if sender = mnuTestSdl then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.renderTest(Sender: TObject);
const
   FULL_FILENAME = 'mapsprite\%s.png';
var
   filename: string;
   filestream: TStream;
   image: TRpgSdlImage;
   lrect: TRect;
begin
   filename := format(FULL_FILENAME, [GDatabase.charClass[1].mapSprite]);
   fileStream := GArchives[IMAGE_ARCHIVE].getFile(filename);
   try
      image := TRpgSdlImage.CreateSprite(lcanvas.Renderer, loadFromTBI(fileStream), filename, nil);
   finally
      fileStream.Free;
   end;

   SDL_SetRenderDrawColor(lcanvas.Renderer, $ff, $ff, $ff, $ff);
   lrect := rect(0, 0, 320, 240);
   SDL_RenderFillRect(lcanvas.Renderer, @lrect);
   lCanvas.Draw(image, ORIGIN, []);
   image.Free;
end;

procedure TfrmTestConsole.mnuTestMapObjectContainersClick(Sender: TObject);
begin
   if not assigned(FCurrentMap) then
      mnuTestMapLoadingClick(sender);

   FEngine.SetCurrentLayer(-1);
   FCurrentMap := nil;
   FEngine := nil;
   if sender = mnuTestMapObjectContainers then
      Application.MessageBox('Test concluded successfully!', 'Finished.')
end;

procedure TfrmTestConsole.estRenderTargets1Click(Sender: TObject);
var
   targets: TSdlRenderTargets;
begin
   if not assigned(GDatabase) then
      mnuTestLoadingClick(Sender);
   if not assigned(lCanvas) then
      mnuCreateSdlWindowClick(Sender);

   targets := TSdlRenderTargets.Create;
   try
      targets.add(TSdlRenderTarget.Create(lcanvas.size));
      targets.RenderOn(0, self.renderTest, 0, true);
      lCanvas.SetRenderer;
      assert(SDL_RenderCopy(lcanvas.Renderer, targets[0].handle, nil, nil) = 0);
      SDL_RenderPresent(lcanvas.Renderer);
      if sender = mnuTestSdl then
         Application.MessageBox('Test concluded successfully!', 'Finished.')
   finally
      targets.free;
   end;
end;

procedure TfrmTestConsole.estTextRendering1Click(Sender: TObject);
begin
   if not assigned(FEngine) then
      mnuTestLoadingClick(Sender);

   glEnable(GL_ALPHA_TEST);
   glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
   glEnable(GL_BLEND);
   glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

//   lCanvas.Clear(SDL_WHITE);
   GFontEngine.drawText('Testing 123', 100, 100, 12);
   lCanvas.Flip;
end;

initialization
   freeList := TObjectList.Create(true);

finalization
   freeList.Free;

end.
