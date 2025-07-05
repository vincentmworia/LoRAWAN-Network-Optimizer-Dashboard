[Setup]
AppName=LoRaWAN Network Optimizer
AppVersion=1.0
AppPublisher=Vincent Mwenda Mworia
DefaultDirName={pf}\LoRaWAN Network Optimizer
DefaultGroupName=LoRaWAN Network Optimizer
OutputBaseFilename=LoRaWAN_Network_Optimizer_Installer
Compression=lzma
SolidCompression=yes

[Files]
Source: "D:\flutter\lorawan\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs

[Icons]
Name: "{group}\LoRaWAN Network Optimizer"; Filename: "{app}\lorawan.exe"
Name: "{commondesktop}\LoRaWAN Network Optimizer"; Filename: "{app}\lorawan.exe"; Tasks: desktopicon

[Tasks]
Name: desktopicon; Description: "Create a desktop shortcut"; GroupDescription: "Additional icons:"; Flags: unchecked

[Run]
Filename: "{app}\lorawan.exe"; Description: "Launch LoRaWAN Network Optimizer"; Flags: nowait postinstall skipifsilent