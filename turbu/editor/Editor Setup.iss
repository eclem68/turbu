; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "TURBU"
#define MyAppVerName "TURBU Editor 0.9.4"
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
OutputBaseFilename=TURBU_Editor_0.9.4
Compression=lzma
SolidCompression=yes
ChangesAssociations=yes

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: ..\bin\EngineBasis.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\default_format.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\turbu_design_basis.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\default_format_design.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\battle_default.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\map_default.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\map_default_design.tep; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\Turbu.exe; DestDir: {app}; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: ..\..\dlls\dbxdrivers.ini; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\dbxfb4d15.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\ftgl.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\fbclient.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\ib_util.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\icudt30.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\icuuc30.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\disharmony.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\libdiscord.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\libpng16.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\msvcp80.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\msvcr80.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\SDL2.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\sdl2_image.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\..\dlls\zlib1.dll; DestDir: {app}; Flags: ignoreversion
Source: ..\bin\design\scripts\general\battle_algorithms.trs; DestDir: {app}\design\scripts\general
Source: ..\bin\design\scripts\general\dt_algorithms.trs; DestDir: {app}\design\scripts\general
Source: ..\bin\design\scripts\general\skill_algorithms.trs; DestDir: {app}\design\scripts\general
Source: ..\bin\design\scripts\menu\menuscripts.trs; DestDir: {app}\design\scripts\menu
Source: ..\bin\design\plugins; DestDir: {app}\design\
Source: C:\Users\public\Documents\RAD Studio\8.0\bpl\JvPluginSystem150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\public\Documents\RAD Studio\8.0\bpl\JvCore150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\public\Documents\RAD Studio\8.0\bpl\JvControls150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\public\Documents\RAD Studio\8.0\bpl\JvCustom150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\public\Documents\RAD Studio\8.0\bpl\JvDB150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\public\Documents\RAD Studio\8.0\bpl\JvDlgs150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\public\Documents\RAD Studio\8.0\bpl\JvSystem150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\public\Documents\RAD Studio\8.0\bpl\JvStdCtrls150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\Public\Documents\RAD Studio\8.0\Bpl\JclVcl150.bpl; DestDir: {app}; Flags: ignoreversion
Source: C:\Users\Public\Documents\RAD Studio\8.0\Bpl\Jcl150.bpl; DestDir: {app}; Flags: ignoreversion
Source: c:\Windows\SysWOW64\rtl150.bpl; DestDir: {app}; Flags: ignoreversion
Source: c:\Windows\SysWOW64\vclimg150.bpl; DestDir: {app}; Flags: ignoreversion
Source: c:\Windows\SysWOW64\vclx150.bpl; DestDir: {app}; Flags: ignoreversion
Source: c:\Windows\SysWOW64\vcldb150.bpl; DestDir: {app}; Flags: ignoreversion
Source: c:\Windows\SysWOW64\dbrtl150.bpl; DestDir: {app}; Flags: ignoreversion
Source: c:\Windows\SysWOW64\vcl150.bpl; DestDir: {app}; Flags: ignoreversion
Source: c:\Windows\SysWOW64\dsnap150.bpl; DestDir: {app}; Flags: ignoreversion
Source: c:\Windows\SysWOW64\dbxcommondriver150.bpl; DestDir: {app}; Flags: ignoreversion

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

