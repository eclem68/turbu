unit turbu_main;
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
   Controls, Classes, Forms, Menus, ExtCtrls, StdCtrls, ComCtrls, Dialogs,
   Generics.Collections, ImgList, ToolWin, ActnList, ActnMan, SyncObjs, Messages,
   PlatformDefaultStyleActnCtrls,
   JvComponentBase, JvPluginManager, JvExControls, JvxSlider,
   design_script_engine, turbu_plugin_interface, turbu_engines, turbu_map_engine,
   turbu_map_interface, turbu_map_metadata,
   sdl_frame, sdl, sdl_13, sg_defs;

type
   TfrmTurbuMain = class(TForm)
      mnuMain: TMainMenu;
      mnuDatabase: TMenuItem;
      dlgOpen: TOpenDialog;
      pluginManager: TJvPluginManager;
      sbxPallette: TScrollBox;
      splSidebar: TSplitter;
      imgPalette: TSdlFrame;
      trvMapTree: TTreeView;
      sbPalette: TScrollBar;
      sbHoriz: TScrollBar;
      sbVert: TScrollBar;
      ilToolbarIcons: TImageList;
      mnuAutosaveMaps: TMenuItem;
      ToolBar2: TToolBar;
      btnLayer1: TToolButton;
      mnuTreePopup: TPopupMenu;
      mnuEditMapProperties: TMenuItem;
      mnuDeleteMap: TMenuItem;
      ActionManager: TActionManager;
      imgLogo: TSdlFrame;
      imgBackground: TPaintBox;
      actRun: TAction;
      actPause: TAction;
      pnlZoom: TPanel;
      sldZoom: TJvxSlider;
      pbUpload: TProgressBar;
      lblUpload: TLabel;
      procedure mnu2KClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure mnuDatabaseClick(Sender: TObject);
      procedure mnuExitClick(Sender: TObject);
      procedure mnuOpenClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure imgLogoAvailable(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure sbPaletteScroll(Sender: TObject; ScrollCode: TScrollCode;
        var ScrollPos: Integer);
      procedure splSidebarMoved(Sender: TObject);
      procedure OnScrollMap(Sender: TObject; ScrollCode: TScrollCode;
        var ScrollPos: Integer);
      procedure imgPaletteMouseDown(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: Integer);
      procedure imgPaletteMouseMove(Sender: TObject; Shift: TShiftState; X,
        Y: Integer);
      procedure imgLogoMouseDown(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: Integer);
      procedure imgLogoMouseUp(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: Integer);
      procedure imgLogoMouseMove(Sender: TObject; Shift: TShiftState; X,
        Y: Integer);
      procedure btnLayer1Click(Sender: TObject);
      procedure btnLayer2Click(Sender: TObject);
      procedure trvMapTreeChange(Sender: TObject; Node: TTreeNode);
      procedure mnuAutosaveMapsClick(Sender: TObject);
      procedure btnSaveClick(Sender: TObject);
      procedure btnSaveAllClick(Sender: TObject);
      procedure mnuAddNewMapClick(Sender: TObject);
      procedure mnuEditMapPropertiesClick(Sender: TObject);
      procedure trvMapTreeContextPopup(Sender: TObject; MousePos: TPoint;
        var Handled: Boolean);
      procedure mnuDeleteMapClick(Sender: TObject);
      procedure mnuTestbugrepsClick(Sender: TObject);
      procedure btnRunClick(Sender: TObject);
      procedure btnPauseClick(Sender: TObject);
      procedure btnMapObjClick(Sender: TObject);
      procedure imgLogoDblClick(Sender: TObject);
      procedure imgLogoKeyDown(Sender: TObject; var Key: Word;
        Shift: TShiftState);
      procedure imgLogoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure imgBackgroundClick(Sender: TObject);
      procedure pluginManagerAfterLoad(Sender: TObject; FileName: string;
        const ALibHandle: {HMODULE} cardinal; var AllowLoad: Boolean);
      procedure pluginManagerBeforeUnload(Sender: TObject; FileName: string;
        const ALibHandle: Cardinal);
      procedure pluginManagerAfterUnload(Sender: TObject; FileName: string);
      procedure imgLogoPaint(Sender: TObject);
      procedure FormResize(Sender: TObject);
      procedure pnlZoomResize(Sender: TObject);
      procedure sldZoomChanged(Sender: TObject);
      procedure imgBackgroundPaint(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
      FMapEngine: IDesignMapEngine;
      FCurrentLayer: integer;
      FLastGoodLayer: integer;
      FPaletteTexture: integer;
      FPaletteSelection: TRect;
      FPaletteSelectionTiles: TRect;
      FLastPalettePos: integer;
      FCurrPalettePos: integer;
      FPaletteImages: TDictionary<integer, integer>;
      FIgnoreMouseDown: boolean;
      FZoom: double;
      FLoadSignal: TSimpleEvent;
      FDBSignal: TSimpleEvent;
      procedure loadEngine(data: TEngineData);
      procedure loadProject;
      procedure openProject(location: string);
      procedure closeProject;

      procedure loadMap(const value: word); overload;
      procedure loadMap(const value: IMapMetadata); overload;

      procedure assignPaletteImage(surface: PSdlSurface);
      procedure displayPalette(height: integer); overload;
      procedure displayPalette; overload; inline;
      procedure resizePalette;
      function calculatePaletteRect: TRect;
      procedure bindPaletteCursor;

      procedure setLayer(const value: integer);

      procedure configureScrollBars(const size, position: TSgPoint);
      procedure RequireMapEngine;
      procedure enableRunButtons(running: boolean);
      function SetMapSize(const size: TSgPoint): TSgPoint;
      procedure SetZoom(const value: double);
      procedure EnableZoom(value: boolean);
      procedure UploadDatabase;
      procedure DBCheck(const name: string);
   public
      { Public declarations }
   end;

var
  frmTurbuMain: TfrmTurbuMain;

implementation

uses
   SysUtils, Math, Graphics, Windows, OpenGL, 
   commons, rm_converter, skill_settings, turbu_database, archiveInterface,
   PackageRegistry,
   turbu_constants, turbu_characters, database, turbu_battle_engine, turbu_maps,
   turbu_classes, turbu_versioning, turbu_tilesets, turbu_defs,
   dm_database, discInterface, formats, map_tree_controller, delete_map,
   sdl_image, sdlstreams, sg_utils;

{$R *.dfm}

type
   TDatabaseLoadThread = class(TThread)
   private
      FProgressBar: TProgressBar;
      FSignal: TSimpleEvent;
   protected
      procedure Execute; override;
   public
      constructor Create(bar: TProgressBar; signal: TSimpleEvent);
   end;

const
   TILE_SIZE: integer = 16;

procedure TfrmTurbuMain.displayPalette(height: integer);

   procedure DrawPaletteCursor(const aRect: TRect);
   begin
      imgPalette.DrawRect(aRect, SDL_BLACK);
      imgPalette.DrawRect(constrictRect(aRect, 1), SDL_WHITE);
      imgPalette.DrawRect(constrictRect(aRect, 2), SDL_WHITE, $B0);
      imgPalette.DrawRect(constrictRect(aRect, 3), SDL_BLACK, $10);
   end;

var
   texture: TSdlTexture;
   displayRect: TRect;
begin
   if FPaletteTexture = -1 then
      Exit;

   texture := imgPalette.images[FPaletteTexture].surface;
   height := min(height, texture.size.Y - sbPalette.pageSize);
   displayRect := rect(0, height, imgPalette.width div 2, imgPalette.height div 2);
   imgPalette.drawTexture(texture, @displayRect, nil);
   drawPaletteCursor(calculatePaletteRect);
   imgPalette.Flip;
end;

procedure TfrmTurbuMain.displayPalette;
begin
   displayPalette(sbPalette.Position);
end;

procedure TfrmTurbuMain.enableRunButtons(running: boolean);
begin
   actRun.Enabled := not running;
   trvMapTree.Enabled := not running;
   actPause.Enabled := running;
//   btnStop.Enabled := running;
   enableZoom(not running);
end;

procedure TfrmTurbuMain.EnableZoom(value: boolean);
var
   i: integer;
begin
   for i := 0 to pnlZoom.ControlCount - 1 do
      pnlZoom.Controls[i].Enabled := value;
end;

procedure TfrmTurbuMain.resizePalette;
var
   texture: TSdlTexture;
begin
   texture := imgPalette.images[FPaletteTexture].surface;
   sbPalette.Max := texture.size.y;
   sbPalette.PageSize := imgPalette.height div 2;
   sbPalette.LargeChange := sbPalette.PageSize - TILE_SIZE;
   displayPalette;
end;

procedure TfrmTurbuMain.mnuEditMapPropertiesClick(Sender: TObject);
begin
   RequireMapEngine;
   fMapEngine.EditMapProperties(trvMapTree.currentMapID);
end;

procedure TfrmTurbuMain.mnuAddNewMapClick(Sender: TObject);
var
   newMap: IMapMetadata;
begin
   RequireMapEngine;
   newMap := FMapEngine.AddNewMap(trvMapTree.currentMapID);
   if assigned(newMap) then
      trvMapTree.addChildMap(newMap);
end;

procedure TfrmTurbuMain.mnuDeleteMapClick(Sender: TObject);
var
   deleteResult: TDeleteMapMode;
begin
   deleteResult := delete_map.deleteMapConfirm(trvMapTree.Selected.HasChildren);
   if deleteResult <> dmNone then
   begin
      FMapEngine.DeleteMap(trvMapTree.currentMapID, deleteResult);
      trvMapTree.buildMapTree(GDatabase.mapTree);
   end;
end;

procedure TfrmTurbuMain.assignPaletteImage(surface: PSdlSurface);
var
   texture: TSdlTexture;
begin
   FPaletteTexture := imgPalette.AddTexture(surface);
   texture := imgPalette.images[FPaletteTexture].surface;
   texture.ScaleMode := sdltsFast;
   bindPaletteCursor;
   resizePalette;
end;

procedure TfrmTurbuMain.closeProject;
begin
   //check for modifications first
   if assigned(FMapEngine) then
      FMapEngine.Reset;
   FreeAndNil(GDatabase);
   GArchives.clearFrom(1);
   FPaletteTexture := -1;
end;

procedure TfrmTurbuMain.configureScrollBars(const size, position: TSgPoint);

   procedure configureScrollBar(scrollbar: TScrollBar; size, pageSize, position: integer);
   begin
      scrollBar.PageSize := 1;
      scrollBar.Max := size;
      scrollBar.PageSize := pageSize;
      scrollBar.LargeChange := scrollBar.PageSize - TILE_SIZE;
      scrollBar.Position := min(position, scrollBar.Max - scrollBar.PageSize);
   end;

begin
   configureScrollBar(sbHoriz, size.x, min(imgLogo.LogicalWidth, size.x), position.x);
   configureScrollBar(sbVert, size.y, min(imgLogo.LogicalHeight, size.y), position.y);
end;

procedure TfrmTurbuMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if FLoadSignal.WaitFor(0) <> wrSignaled then
   begin
      self.Cursor := crHourGlass;
      FLoadSignal.WaitFor(INFINITE);
   end;
end;

procedure TfrmTurbuMain.FormCreate(Sender: TObject);
begin
   if getProjectFolder = '' then
      createProjectFolder;
   FPaletteTexture := -1;
   FPaletteImages := TDictionary<integer, integer>.Create;
   FZoom := 1;
   FLoadSignal := TSimpleEvent.Create;
   FDBSignal := TSimpleEvent.Create;
   FLoadSignal.SetEvent;
end;

procedure TfrmTurbuMain.FormDestroy(Sender: TObject);
begin
   FDBSignal.Free;
   FLoadSignal.Free;
   cleanupEngines;
   FMapEngine := nil;
   GScriptEngine := nil;
   FPaletteImages.Free;
end;

procedure TfrmTurbuMain.FormResize(Sender: TObject);
var
   availableSize: TSgPoint;
begin
   if assigned(FMapEngine) then
   begin
      availableSize := sgPoint(imgBackground.Width, imgBackground.Height) / FZoom;
      FMapEngine.ResizeWindow(classes.rect(ORIGIN, availableSize));
      FMapEngine.ScrollMap(sgPoint(sbHoriz.Position, sbVert.Position));
   end;
end;

procedure TfrmTurbuMain.FormShow(Sender: TObject);
var
   infile: TStream;
   plugins: TStringList;
   engines: TEngineDataList;
   plugStr: string;
   i, j: integer;
   pluginIntf: ITurbuPlugin;
begin
   GProjectFolder := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
   assert(GArchives.Add(openFolder(GProjectFolder + DESIGN_DB)) = BASE_ARCHIVE);
   inFile := nil;
   plugins := TStringList.Create;
   try
      inFile := GArchives[BASE_ARCHIVE].getFile('plugins');
      plugins.LoadFromStream(inFile);
      for plugStr in plugins do
      try
         pluginManager.LoadPlugin(plugStr, plgPackage);
      except
         on E: EPackageError do ; //TODO: Add code here to handle package loading errors
      end;
   finally
      plugins.free;
      inFile.free;
   end;
   for I := 0 to pluginManager.PluginCount - 1 do
   begin
      assert(pluginManager.Plugins[i].GetInterface(ITurbuPlugin, pluginIntf));
      engines := pluginIntf.listPlugins;
      for j := 0 to engines.Count - 1 do
         loadEngine(engines[j]);
      engines.free;
   end;
   pnlZoomResize(self);
   focusControl(trvMapTree);
end;

procedure TfrmTurbuMain.imgBackgroundClick(Sender: TObject);
begin
   FocusControl(imgLogo);
end;

procedure TfrmTurbuMain.imgLogoAvailable(Sender: TObject);
var
   surface: PSdlSurface;
   convert1, convert2: PSdlSurface;
   rw: PSDL_RWops;
   stream: TResourceStream;
   index: integer;
begin
   stream := TResourceStream.Create(HInstance, 'logo', RT_RCDATA);
   rw := SDLStreamSetup(stream);
   surface := pointer(IMG_LoadPNG_RW(rw));
   assert(assigned(surface));
   convert1 := TSdlSurface.Create(1, 1, 32);
   convert2 := TSdlSurface.Convert(surface, convert1.Format);

   index := imgLogo.AddTexture(convert2);
   SDLStreamCloseRWops(rw);
   stream.Free;
   surface.Free;
   convert1.Free;

   imgLogo.DrawTexture(index);
end;

procedure TfrmTurbuMain.imgLogoDblClick(Sender: TObject);
begin
   RequireMapEngine;
   FMapEngine.doubleClick;

   //Needed because of the order of Windows messages: the Double Click message
   //posts first, then the MouseDown after it, and this can do strange
   //things to the engine.
   FIgnoreMouseDown := true;
end;

procedure TfrmTurbuMain.imgLogoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   RequireMapEngine;
   FMapEngine.KeyDown(key, shift);
end;

procedure TfrmTurbuMain.imgLogoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   RequireMapEngine;
   FMapEngine.KeyUp(key, shift);
end;

procedure TfrmTurbuMain.imgLogoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   point: TSgPoint;
begin
   RequireMapEngine;
   if FIgnoreMouseDown then
      FIgnoreMouseDown := false
   else begin
      point := pointToGridLoc(sgPoint(x, y), sgPoint(16, 16), sbHoriz.Position, sbVert.Position, FZoom);
      case button of
         mbLeft: FMapEngine.draw(point, true);
         mbRight: FMapEngine.RightClick(point);
         else ;
      end;
   end;
end;

procedure TfrmTurbuMain.imgLogoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   RequireMapEngine;
   if (ssLeft in shift) then
      FMapEngine.draw(pointToGridLoc(sgPoint(x, y), sgPoint(16, 16), sbHoriz.Position, sbVert.Position, FZoom),
                      false);
end;

procedure TfrmTurbuMain.imgLogoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   RequireMapEngine;
   FMapEngine.doneDrawing;
end;

procedure TfrmTurbuMain.imgLogoPaint(Sender: TObject);
begin
   if assigned(FMapEngine) then
      FMapEngine.Repaint
   else SDL_RenderPresent;
end;

procedure TfrmTurbuMain.imgPaletteMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (button = mbLeft) then
   begin
      FPaletteSelection.TopLeft := point(x, y);
      imgPaletteMouseMove(sender, shift, x, y);
   end;
end;

procedure TfrmTurbuMain.imgPaletteMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   if ssLeft in shift then
   begin
      FPaletteSelection.BottomRight := point(x, y);
      bindPaletteCursor;
      displayPalette;
   end;
end;

procedure TfrmTurbuMain.loadEngine(data: TEngineData);
var
   iClass: TRpgPlugBase;
   bEngine: IBattleEngine;
   mEngine: IMapEngine;
begin
   iClass := data.engine.Create;
   case data.style of
      et_map:
      begin
         assert(iclass.GetInterface(IMapEngine, mEngine));
         addEngine(et_map, mEngine.getData, mEngine);
      end;
      et_battle:
      begin
         assert(iclass.GetInterface(IBattleEngine, bEngine));
         addEngine(et_battle, bEngine.getData, bEngine);
      end;
      et_menu: assert(false);
      et_minigame: assert(false);
      else assert(false);
   end;
end;

procedure TfrmTurbuMain.loadMap(const value: IMapMetadata);
const
   SDL_BLACK: SDL_Color = ();
begin
   FMapEngine := retrieveEngine(et_map, value.mapEngine,
                 TVersion.Create(0, 0, 0)) as IDesignMapEngine;
   FMapEngine.initialize(imgLogo.sdlWindow, GDatabase);
   FMapEngine.SetMapResizeEvent(self.SetMapSize);
   FMapEngine.autosaveMaps := mnuAutosaveMaps.checked;
   FMapEngine.loadMap(value);
   FMapEngine.ScrollMap(sgPoint(sbHoriz.Position, sbVert.Position));
   imgPalette.Select;
   imgPalette.ClearTextures;
   FPaletteImages.Clear;
   setLayer(FCurrentLayer);
   EnableZoom(true);
end;

procedure TfrmTurbuMain.loadMap(const value: word);
begin
   loadMap(GDatabase.mapTree.item[value]);
end;

procedure TfrmTurbuMain.loadProject;
begin
   if GDatabase = nil then
      GDatabase := TRpgDatabase.Create;
   FLoadSignal.SetEvent;
   trvMapTree.buildMapTree(GDatabase.mapTree);
end;

procedure TfrmTurbuMain.mnu2KClick(Sender: TObject);
begin
   closeProject;
   if frmRmConverter.loadProject = SUCCESSFUL_IMPORT then
   begin
      FDBSignal.SetEvent;
      self.loadProject;
   end;
end;

procedure TfrmTurbuMain.mnuAutosaveMapsClick(Sender: TObject);
var
   menu: TMenuItem absolute Sender;
begin
   assert(menu = mnuAutosaveMaps);
   menu.checked := not menu.checked;
   RequireMapEngine;
   FMapEngine.autosaveMaps := menu.checked;
end;

procedure TfrmTurbuMain.mnuDatabaseClick(Sender: TObject);
var
   frmDatabase: TfrmDatabase;
begin
   DBCheck('Database Editor');
   frmDatabase := TFrmDatabase.Create(nil);
   try
      frmDatabase.init(GDatabase);
      frmDatabase.ShowModal;
   finally
      frmDatabase.Free;
   end;
end;

procedure TfrmTurbuMain.mnuExitClick(Sender: TObject);
begin
   self.Close;
end;

procedure TfrmTurbuMain.mnuOpenClick(Sender: TObject);
var
   filename: string;
begin
   dlgOpen.InitialDir := getProjectFolder;
   if dlgOpen.Execute then
   begin
      filename := ExcludeTrailingPathDelimiter(ExtractFilePath(dlgOpen.FileName));
      closeProject;
      openProject(filename);
      mnuDatabase.Enabled := true;
   end;
end;

procedure TfrmTurbuMain.mnuTestbugrepsClick(Sender: TObject);
begin
   RequireMapEngine;
   (FMapEngine as IBreakable).BreakSomething;
end;

procedure TfrmTurbuMain.OnScrollMap(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
var
   scrollbar: TScrollBar absolute sender;
begin
   RequireMapEngine;
   assert(scrollbar is TScrollBar);
   scrollPos := min(scrollPos, scrollbar.Max - scrollbar.PageSize);
   fMapEngine.ScrollMap(sgPoint(sbHoriz.Position, sbVert.Position));
   trvMapTree.Selections[0].selected := true;
end;

procedure TfrmTurbuMain.UploadDatabase;
var
   thread: TDatabaseLoadThread;
begin
   thread := TDatabaseLoadThread.Create(pbUpload, FDBSignal);
   thread.FreeOnTerminate := true;
   thread.Start;
end;

procedure TfrmTurbuMain.openProject(location: string);

   procedure openArchive(folderName: string; index: integer);
   var
      filename: string;
   begin
      filename := location + folderName;
      assert(GArchives.Add(openFolder(filename)) = index);
   end;

var
   fileStream, loadStream: TStream;
   filename: string;
begin
   location := IncludeTrailingPathDelimiter(location);
   openArchive(PROJECT_DB, DATABASE_ARCHIVE);
   openArchive(MAP_DB, MAP_ARCHIVE);
   openArchive(IMAGE_DB, IMAGE_ARCHIVE);
   openArchive(SCRIPT_DB, SCRIPT_ARCHIVE);

   filename := IncludeTrailingPathDelimiter(location) + DBNAME;
   lblUpload.caption := 'Loading Database:';
   TThread.CreateAnonymousThread(
      procedure
      begin
         FLoadSignal.ResetEvent;
         fileStream := TFileStream.Create(filename, fmOpenRead);
         loadStream := TMemoryStream.Create;
         try
            loadStream.CopyFrom(fileStream, fileStream.Size);
            loadStream.rewind;
            try
               GDatabase := TRpgDatabase.Load(loadStream, true,
                 procedure(tree: IMapTree)
                 begin
                   trvMapTree.buildMapTree(tree);
                   btnLayer1Click(self);
                 end,
                 procedure(value: integer) begin pbUpload.Max := value + 2; end);
            except
               on ERpgLoadError do
               begin
                  GDatabase := nil;
                  MsgBox('TDB file is using an outdated format and can''t be loaded.', 'Load error');
                  Abort;
               end
               else begin
                  GDatabase := nil;
                  raise;
               end;
            end;
         finally
            loadStream.free;
            fileStream.Free;
         end;
         GDatabase.filename := filename;
         FLoadSignal.SetEvent;
         self.UploadDatabase;
      end).Start;
end;

procedure TfrmTurbuMain.pnlZoomResize(Sender: TObject);

   procedure CenterControl(ctrl: TControl; position: integer);
   begin
      ctrl.Left := sldZoom.GetOffsetByValue(position) - (ctrl.Width div 4);
   end;

var
   i: integer;
   ctrl: TControl;
begin
   for i := 0 to pnlZoom.ControlCount -1 do
   begin
      ctrl := pnlZoom.Controls[i];
      if (ctrl.tag <> 0) and (ctrl is TLabel) then
         CenterControl(ctrl, ctrl.tag);
   end;
end;

procedure TfrmTurbuMain.pluginManagerAfterLoad(Sender: TObject;
  FileName: string; const ALibHandle: {HMODULE} cardinal; var AllowLoad: Boolean);
begin
   Packages.AddPackage(FileName, ALibHandle);
end;

procedure TfrmTurbuMain.pluginManagerAfterUnload(Sender: TObject;
  FileName: string);
begin
   Packages.Verify;
end;

procedure TfrmTurbuMain.pluginManagerBeforeUnload(Sender: TObject;
  FileName: string; const ALibHandle: Cardinal);
begin
   Packages.RemovePackage(FileName);
end;

procedure TfrmTurbuMain.RequireMapEngine;
begin
   if not assigned(FMapEngine) then
      Abort;
end;

procedure TfrmTurbuMain.sbPaletteScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   if (FLastPalettePos = ScrollPos) or (FPaletteTexture = -1) then
      Exit;
   FCurrPalettePos := ScrollPos;
   displayPalette(ScrollPos);
   FLastPalettePos := ScrollPos;
end;

procedure TfrmTurbuMain.setLayer(const value: integer);

   procedure LoadImage(const value: integer);
   begin
      if not FPaletteImages.ContainsKey(value) then
      begin
         assignPaletteImage(FMapEngine.tilesetImage[value]);
         FPaletteImages.add(value, FPaletteTexture);
      end
      else begin
         FPaletteTexture := FPaletteImages[value];
         bindPaletteCursor;
         resizePalette;
      end;
   end;

begin
   RequireMapEngine;
   FCurrentLayer := value;
   if value >= 0 then
      FLastGoodLayer := value;
   imgPalette.Enabled := value >= 0;
   LoadImage(FLastGoodLayer);
   FMapEngine.SetCurrentLayer(value);
end;

procedure GetColorsForDate(var bg, fg: TColor);
const clOrange = $0045C9;
var
   year, month, day: word;
begin
   DecodeDate(date, year, month, day);
   if (month = 10) and (day = 31) then
   begin
      bg := clBlack;
      fg := clOrange;
   end
   else if (month = 12) and (day in [24, 25]) then
   begin
      bg := clGreen;
      fg := clRed;
   end
   else if (month = 7) and (day = 4) then
   begin
      bg := clRed;
      fg := clBlue;
   end
   else begin
      bg := clGray;
      fg := clWhite;
   end;
end;

procedure TfrmTurbuMain.imgBackgroundPaint(Sender: TObject);
var
   bg, fg: TColor;
   box: TPaintBox;
begin
   box := sender as TPaintBox;
   GetColorsForDate(bg, fg);
   box.canvas.brush.Style := bsDiagCross;
   box.canvas.brush.color := fg;
   Windows.SetBkColor(box.Canvas.Handle, ColorToRgb(bg));
   box.canvas.FillRect(box.ClientRect);
end;

function TfrmTurbuMain.SetMapSize(const size: TSgPoint): TSgPoint;
var
   pSize: TSgPoint;
begin
   pSize := size * FZoom;
   if (pSize.x >= imgBackground.ClientWidth) and (pSize.y >= imgBackground.ClientHeight) then
   begin
      imgLogo.Align := alClient;
   end
   else begin
      imgLogo.Align := alNone;
      imgLogo.Width := min(imgBackground.ClientWidth, pSize.x);
      imgLogo.Height := min(imgBackground.ClientHeight, pSize.y);
      imgLogo.Left := (imgBackground.ClientWidth - imgLogo.width) div 2;
      imgLogo.Top := (imgBackground.ClientHeight - imgLogo.height) div 2;
   end;
   if (imgLogo.Width < imgBackground.ClientWidth) and (imgLogo.Height < imgBackground.ClientHeight) then
      result := size
   else result := sgPoint(imgLogo.Width, imgLogo.Height) / FZoom;
   imgLogo.LogicalSize := result;
   configureScrollBars(size, FMapEngine.mapPosition);
end;

procedure TfrmTurbuMain.SetZoom(const value: double);
begin
   if abs(value - FZoom) < 0.01 then //comparing floats with = doesn't always work
      Exit;
   FZoom := value;
   imgLogo.Select;
   GLLineWidth(value);
   FormResize(self);
end;

procedure TfrmTurbuMain.bindPaletteCursor;
var
   height, width: integer;
   i, j: integer;
   list: TList<integer>;
begin
   RequireMapEngine;
   FPaletteSelectionTiles.TopLeft := pointToGridLoc(
     sgPoint(min(FPaletteSelection.left, FPaletteSelection.right),
             min(FPaletteSelection.top, FPaletteSelection.bottom)),
     sgPoint(16, 16), 0, FCurrPalettePos, 2);
   FPaletteSelectionTiles.BottomRight := pointToGridLoc(
     sgPoint(max(FPaletteSelection.left, FPaletteSelection.right),
             max(FPaletteSelection.top, FPaletteSelection.bottom)),
     sgPoint(16, 16), 0, FCurrPalettePos, 2);

   width := (FPaletteSelectionTiles.right - FPaletteSelectionTiles.left) + 1;
   height := (FPaletteSelectionTiles.bottom - FPaletteSelectionTiles.top) + 1;
   list := TList<integer>.Create;
   list.capacity := (height * width) + 1;
   list.add(width);
   for j := 0 to height - 1 do
      for i := 0 to width - 1 do
         list.add((6 * (FPaletteSelectionTiles.top + j)) + FPaletteSelectionTiles.Left + i);
   FMapEngine.setPaletteList(list);
end;

function TfrmTurbuMain.calculatePaletteRect: TRect;
begin
   result := multiplyRect(FPaletteSelectionTiles, 32);
   dec(result.top, FCurrPalettePos * 2);
   dec(result.bottom, FCurrPalettePos * 2);
   inc(result.right, 31);
   inc(result.bottom, 31);
end;

procedure TfrmTurbuMain.sldZoomChanged(Sender: TObject);
begin
   SetZoom(sldZoom.Value / 100);
end;

procedure TfrmTurbuMain.splSidebarMoved(Sender: TObject);
begin
//QC 89303: Can't call Abort inside a splitter's OnMoved event
//   RequireMapEngine;
   if assigned(FMapEngine) then
      resizePalette;
end;

procedure TfrmTurbuMain.DBCheck(const name: string);
begin
   if FDBSignal.WaitFor(0) = wrTimeout then
   begin
      MsgBox(format('The %s can''t be used until database loading is complete', [name]), 'Please wait...');
      Abort;
   end
end;

procedure TfrmTurbuMain.btnMapObjClick(Sender: TObject);
begin
   DBCheck('Map Object layer');
   setLayer(-1);
end;

procedure TfrmTurbuMain.btnLayer1Click(Sender: TObject);
begin
   setLayer(0);
end;

procedure TfrmTurbuMain.btnLayer2Click(Sender: TObject);
begin
   setLayer(1);
end;

procedure TfrmTurbuMain.btnPauseClick(Sender: TObject);
begin
   RequireMapEngine;
   FMapEngine.Pause;
   enableRunButtons(false);
end;

procedure TfrmTurbuMain.btnRunClick(Sender: TObject);
begin
   RequireMapEngine;
   FMapEngine.Play;
   enableRunButtons(true);
end;

procedure TfrmTurbuMain.btnSaveAllClick(Sender: TObject);
begin
   RequireMapEngine;
   FMapEngine.SaveAll;
end;

procedure TfrmTurbuMain.btnSaveClick(Sender: TObject);
begin
   RequireMapEngine;
   FMapEngine.SaveCurrent;
end;

procedure TfrmTurbuMain.trvMapTreeChange(Sender: TObject; Node: TTreeNode);
begin
   if not node.IsFirstNode then
      loadMap(IInterface(node.Data) as IMapMetadata);
end;

procedure TfrmTurbuMain.trvMapTreeContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
   topNode: boolean;
begin
   topNode := trvMapTree.selected = trvMapTree.items[0];
   mnuDeleteMap.Enabled := not topNode;
   mnuEditMapProperties.Enabled := not topNode;
end;

{ TDatabaseLoadThread }

constructor TDatabaseLoadThread.Create(bar: TProgressBar; signal: TSimpleEvent);
begin
   inherited Create(true);
   FProgressBar := bar;
   FSignal := signal;
end;

procedure TDatabaseLoadThread.Execute;
var
   index: TRpgDataTypes;
begin
   try
      try
         for index := Low(TRpgDataTypes) to High(TRpgDataTypes) do
         begin
            if self.Terminated then
               Exit;
            GDatabase.copyTypeToDB(dmDatabase, index);
            self.Queue(procedure begin FProgressBar.Position := ord(index) + 1 ; end);
         end;
         sleep(100);
         self.Synchronize(
            procedure
            begin
               frmTurbuMain.lblUpload.caption := 'Done!';
               FProgressBar.Max := FProgressBar.Position;
               frmTurbuMain.mnuDatabase.Enabled := true;
            end);
      finally
         FSignal.SetEvent;
      end;
   except
      self.Synchronize(
         procedure
         begin
            frmTurbuMain.lblUpload.caption := 'Error!';
            FProgressBar.State := pbsError;
         end);
   end;
end;

initialization
finalization
   frmTurbuMain := nil;

//The major difference between a thing that might go wrong and a thing that
//cannot possibly go wrong is that when a thing that cannot possibly go wrong
//goes wrong it usually turns out to be impossible to get at or repair.

end.