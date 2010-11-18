program Turbu;


{$R *.dres}

uses
  FastMM4,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  dialogs,
  SysUtils,
  MidasLib, {Make sure this initializes before the Application.CreateForm calls start running}
  sdl,
  sdl_canvas,
  types,
  dm_database,
  LMT in '..\LMT.pas',
  fileIO in '..\fileIO.pas',
  LDB in '..\LDB.pas',
  BER in '..\BER.pas',
  chipset in '..\chipset.pas',
  LMU in '..\LMU.pas',
  skill_data in '..\skill_data.pas',
  condition_data in '..\condition_data.pas',
  battle_anims in '..\battle_anims.pas',
  events in '..\events.pas',
  database in 'database.pas' {frmDatabase},
  turbu_main in 'turbu_main.pas' {frmTurbuMain},
  formats in '..\formats.pas',
  rm_converter in 'rm_converter.pas' {frmRmConverter},
  rm2_turbu_characters in '..\turbu format\converters\rm2_turbu_characters.pas',
  skill_settings in 'skill_settings.pas' {frmSkillLearning},
  generic_algorithm_editor in 'generic_algorithm_editor.pas' {frmAlgorithmEditor},
  rm2_turbu_database in '..\turbu format\converters\rm2_turbu_database.pas',
  conversion_table in '..\turbu format\converters\conversion_table.pas',
  frame_commands in 'frame_commands.pas' {frameHeroCommands: TFrame},
  frame_class in 'frame_class.pas' {frameClass: TFrame},
  rm2_turbu_items in '..\turbu format\converters\rm2_turbu_items.pas',
  rm2_turbu_sounds in '..\turbu format\converters\rm2_turbu_sounds.pas',
  rm2_turbu_skills in '..\turbu format\converters\rm2_turbu_skills.pas',
  logs in '..\logs.pas',
  rm2_turbu_animations in '..\turbu format\converters\rm2_turbu_animations.pas',
  rm2_turbu_resists in '..\turbu format\converters\rm2_turbu_resists.pas',
  discInterface in '..\discInterface.pas',
  frame_params in 'frame_params.pas' {frameParams: TFrame},
  attributes_editor in 'attributes_editor.pas' {frmAttributesEditor},
  frame_items in 'frame_items.pas' {frameItems: TFrame},
  turbu_script_basis in '..\turbu format\turbu_script_basis.pas',
  design_script_engine in 'design_script_engine.pas',
  rpg_list in '..\mapview\libs\script engine\rpg_list.pas',
  script_backend in '..\mapview\libs\script engine\script_backend.pas',
  script_interface in '..\mapview\libs\script engine\script_interface.pas',
  uPSI_script_interface in '..\mapview\libs\script engine\uPSI_script_interface.pas',
  findfile in '..\..\classes\findfile\findfile.pas',
  function_header in 'function_header.pas' {frmFuncHeader},
  rm2_turbu_map_metadata in '..\turbu format\converters\rm2_turbu_map_metadata.pas',
  rm2_turbu_maps in '..\turbu format\converters\rm2_turbu_maps.pas',
  conversion_report_form in '..\turbu format\converters\conversion_report_form.pas' {frmConversionReport},
  conversion_report in '..\turbu format\converters\conversion_report.pas',
  rm2_turbu_converter_thread in '..\turbu format\converters\rm2_turbu_converter_thread.pas',
  turbu_functional in '..\turbu_functional.pas',
  rm2_turbu_tilesets in '..\turbu format\converters\rm2_turbu_tilesets.pas',
  map_tree_controller in 'map_tree_controller.pas',
  delete_map in 'delete_map.pas' {dlgDeleteMap},
  rm2_turbu_map_objects in '..\turbu format\converters\rm2_turbu_map_objects.pas',
  conversion_output in '..\turbu format\converters\conversion_output.pas' {frmConversionOutput},
  rm2_turbu_event_builder in '..\turbu format\converters\rm2_turbu_event_builder.pas',
  PackageRegistry in '..\..\classes\PackageRegistry.pas';

{$R *.res}

{$WARN SYMBOL_PLATFORM OFF}
begin
   Application.Initialize;
   {$IFDEF DEBUG}
   ReportMemoryLeaksOnShutdown := DebugHook <> 0;
   {$ELSE IFDEF TEST_BUILD}
   ReportMemoryLeaksOnShutdown := true;
   {$ENDIF}
   Application.CreateForm(TfrmTurbuMain, frmTurbuMain);
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TfrmDatabase, frmDatabase);
  Application.CreateForm(TfrmRmConverter, frmRmConverter);
  Application.CreateForm(TfrmSkillLearning, frmSkillLearning);
  Application.CreateForm(TfrmFuncHeader, frmFuncHeader);
  Application.CreateForm(TfrmAlgorithmEditor, frmAlgorithmEditor);
  Application.CreateForm(TfrmAttributesEditor, frmAttributesEditor);
  if (SDL_Init(SDL_INIT_VIDEO) <> 0) then
      raise Exception.create('Unable to initialize graphics converter.');
   {$IFDEF DEBUG}
   //Create an SDL window for testing images on.
//   TSdlCanvas.Create(cmHardware, false, rect(100, 100, 640, 480), 32);
   {$ENDIF}
   Application.Run;
end.