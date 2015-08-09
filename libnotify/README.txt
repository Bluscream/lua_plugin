README
-- German-Part --
-- See English below --

--- Hinweise zur Nutzung unter Windows ---

1. Es wird Growl for Windows benötigt.
	http://www.growlforwindows.com/gfw/default.aspx
2. Growl muss in einem Verzeichnis ohne Leerzeichen abgelegt sein!!
3. Der Pfad zur "growlnotify.exe" incl. der executable muss entsprechend angepasst werden!!
	Anpassung unter OSConfig. Windows.GROWL_Exec.PATH in def.lua
	
--- Hinweise zur Nutzung unter Linux ---

1. Es wird das Paket "libnotify-bin" (Name des Paketes unter Ubuntu, andere Distributionen evtl. abweichend) benötigt.
	Dies beinhaltet das Tool "notify-bin"!!

--- Hinweise zur Nutzung ---

In der Datei def.lua können alle Events einzeln aktiviert, bzw. deaktiviert werden.
Für die Events Poke und TextReceive wird ein Fix für die ts3events.lua benötigt
	http://forum.teamspeak.com/showthread.php?t=58263

Es ist zwingend in def.lua das entsprechend verwendete Betriebssystem einzutragen,
der Eintrag sollte einem der SupportedOS-Einträge entsprechen!!

--- Installationsanweisung ---

1. Die heruntergeladene Datei entpacken und den Ordner "libnotify" in ihren "lua_plugin"-Ordner einfügen.
2. Falls sie mehrere Lua-Scripte mit Autoload nutzen, fügen sie bitte den Eintrag "libnotify" in einer neuen Zeile
zur Datei "modules.txt" im "lua_plugin"-Ordner hinzu. Sollten sie keine solche Datei besitzen, wird das Script automatisch geladen.
3. Aktivieren sie in der Datei "def.lua" alle Events, die sie angezeigt haben möchten.
4. Ändern sie den Eintrag bei "activatedListType" auf "blacklist", oder nutzen sie den Befehl "/lua run addServerToList",
wenn sie mit einem Server verbunden sind, um die Events anzuzeigen.

-- English section --

--- Using this script under Windows ---

1. You need to install Growl for Windows
	http://www.growlforwindows.com/gfw/default.aspx
2. Growl has to be installed in a Path without any spaces.
3. The path to "growlnotify.exe" with appended the filename of the executable has to be changed.
	Change this value under OSConfig. Windows.GROWL_Exec.PATH in "def.lua"

--- Using this script under Linux---

1. You have to install the package "libnotify-bin" (packagename of Ubuntu, other distributions can have other packagenames)
	This package includes "notify-bin", the tool, which is needed.

--- Using this script ---
All Events can be seperately activated / deactivated in "def.lua".
For using Poke and Textreceive you have to patch your "ts3events.lua". The Fix can be found here:
	http://forum.teamspeak.com/showthread.php?t=58263

Please change the Entry "activeOS" in "def.lua" to the OS, you use, and which is mentioned as an entry under supportedOS.

--- Install-Advise ---

1. unzip the file and copy the folder "libnotify" into your "lua_plugin"-folder.
2. if you are using a "module.txt"-file, add "libnotify" as a new line to this file.
3. Activate all Events that you want to use.
4. Change "activatedListType" in def.lau to "blacklist",or use "/lua run addServerToList" when connected to a Server,
to activate the library for all or only the Servers, on which you have used this command.

--- Changelog ---
Version 1.0
	Usable functions:
		- Client join your Channel
		- Client left your Channel (including left Server out of your Channel)
		- Client whispers to you
	Functions unusable without 2 fixes within ts3events (siehe Hinweise zur Nutzung)
		- Client Pokes you
		- Client writes Message to you
		- Client writes Message to your Channel

Version 1.1
	- Fixxed minor Bugs
	- Added "Client moved in your channel from other"
	- Added "client moved out of your channel from other"
	- All events can be activated/deactivated in def-file 

Version 1.2
	- Added Support for Windows using Growl
	
Version 1.3
	- Added Support for Black-/Whitelisting of Servers
	- New Commands for List-Managing implemented
		- "AddServerToList" for adding Server to Black-/Whitelist
		- "delServerFromList" for deleting Server from Black-/Whitelist
	- List-file will be stored in your Config-Directory, so every User can have it's own list
	
Version 1.4
	- Added Support for multiple languages
	- Added English Messages
