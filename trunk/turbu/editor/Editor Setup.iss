; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "TURBU"
#define MyAppVerName "TURBU Editor 0.8.1"
#define MyAppPublisher "Dragon Slayers, Inc."
#define MyAppURL "http://www.turbu-rpg.com/"
#define MyAppExeName "Turbu.exe"

[Setup]
AppName={#MyAppName}
AppVerName={#MyAppVerName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=.\setup
OutputBaseFilename=TURBU_Editor_0.8.1
Compression=lzma
SolidCompression=yes
ChangesAssociations=yes

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: ..\bin\EngineBasis.bpl; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\default_format.bpl; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\turbu_design_basis.bpl; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\default_format_design.bpl; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\battle_default.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\map_default.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\map_default_design.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\Turbu.exe; DestDir: {app}; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: ..\..\dlls\libogg-0.dll; DestDir: {sys}
Source: ..\..\dlls\libpng12-0.dll; DestDir: {sys}
Source: ..\..\dlls\libvorbis-0.dll; DestDir: {sys}
Source: ..\..\dlls\libvorbisfile-3.dll; DestDir: {sys}
Source: ..\..\dlls\SDL.dll; DestDir: {app}
Source: ..\..\dlls\sdl_image.dll; DestDir: {app}
Source: ..\..\dlls\SDL_mixer.dll; DestDir: {sys}
Source: ..\..\dlls\smpeg.dll; DestDir: {sys}
Source: ..\..\dlls\zlib1.dll; DestDir: {sys}
Source: ..\bin\design\scripts\general\battle_algorithms.trs; DestDir: {app}\design\scripts\general
Source: ..\bin\design\scripts\general\dt_algorithms.trs; DestDir: {app}\design\scripts\general
Source: ..\bin\design\scripts\general\skill_algorithms.trs; DestDir: {app}\design\scripts\general
Source: ..\bin\design\scripts\menu\menuscripts.trs; DestDir: {app}\design\scripts\menu
Source: ..\bin\design\plugins; DestDir: {app}\design\
Source: C:\Users\mason\Documents\RAD Studio\7.0\bpl\JvPluginSystem140.bpl; DestDir: {sys}
Source: C:\Users\mason\Documents\RAD Studio\7.0\bpl\JvCore140.bpl; DestDir: {sys}
Source: C:\Users\mason\Documents\RAD Studio\7.0\bpl\JvControls140.bpl; DestDir: {sys}
Source: C:\Users\mason\Documents\RAD Studio\7.0\bpl\JvCustom140.bpl; DestDir: {sys}
Source: C:\Users\mason\Documents\RAD Studio\7.0\bpl\JvDB140.bpl; DestDir: {sys}
Source: C:\Users\mason\Documents\RAD Studio\7.0\bpl\JvDlgs140.bpl; DestDir: {sys}
Source: C:\Users\mason\Documents\RAD Studio\7.0\bpl\JvSystem140.bpl; DestDir: {sys}
Source: C:\Users\mason\Documents\RAD Studio\7.0\bpl\JvStdCtrls140.bpl; DestDir: {sys}
Source: C:\Users\Public\Documents\RAD Studio\7.0\Bpl\JclVcl140.bpl; DestDir: {sys}
Source: C:\Users\Public\Documents\RAD Studio\7.0\Bpl\Jcl140.bpl; DestDir: {sys}
Source: c:\Windows\SysWOW64\rtl140.bpl; DestDir: {sys}
Source: c:\Windows\SysWOW64\vclimg140.bpl; DestDir: {sys}
Source: c:\Windows\SysWOW64\vclx140.bpl; DestDir: {sys}
Source: c:\Windows\SysWOW64\vcldb140.bpl; DestDir: {sys}
Source: c:\Windows\SysWOW64\dsnap140.bpl; DestDir: {sys}
Source: c:\Windows\SysWOW64\dbrtl140.bpl; DestDir: {sys}
Source: c:\Windows\SysWOW64\midas.dll; DestDir: {sys}
Source: c:\Windows\SysWOW64\vcl140.bpl; DestDir: {sys}

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#MyAppExeName}
Name: {group}\{cm:UninstallProgram,{#MyAppName}}; Filename: {uninstallexe}
Name: {commondesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon

[Run]
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#MyAppName}}; Flags: nowait postinstall skipifsilent

[Registry]
Root: HKCU; Subkey: Software\TURBU; ValueType: string; ValueName: TURBU Projects Folder; Flags: uninsdeletekey deletekey; Tasks: ; Languages: ; ValueData: {userdocs}\TURBU Projects
Root: HKCR; Subkey: .trs; ValueType: string; ValueName: ; ValueData: TurbuRpgScript; Flags: uninsdeletevalue
Root: HKCR; Subkey: TurbuRpgScript; ValueType: string; ValueName: ; ValueData: TURBU RpgScript file; Flags: uninsdeletekey
Root: HKCR; Subkey: TurbuRpgScript\DefaultIcon; ValueType: string; ValueName: ; ValueData: {app}\turbu.exe,1

[Dirs]
Name: {userdocs}\TURBU Projects; Flags: uninsneveruninstall; Tasks: ; Languages: 
Name: {app}\design
Name: {app}\design\scripts
Name: {app}\design\scripts\general
Name: {app}\design\scripts\menu


