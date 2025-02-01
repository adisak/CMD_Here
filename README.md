# CMD_Here
"CMD_Here" is a simple way to launch a CMD Window in the directory by double clicking the icon

When you run "CMD_Here.bat", the new command console window will open in the same directory and will run a configuration script as well if the configuration script is present.  It can easily be copied to any directory you want to do work from that requires setup which can be initialized with the configuration script.

It can also be run to set a currently open command console to the configuration settings that double-clicking the icon would perform.  If you run it again in a command console that was already set to the CMD_Here configuration, it will spawn an additional separate working command console window for you.

----- ----- -----

Lightweight Use Method (Preferred if possible):

You can copy "CMD_Here_Lite.bat" instead of "CMD_Here.bat" which offers a smaller footprint as it doesn't copy "CMD_Here.bat" directly.

However, this also requires that you install (copy) "CMD_Here_Global.bat" to a directory in your PATH and modify it to point correctly at the directory for "CMD_Here.bat" if the "scripts" directory for "CMD_Here" is not in your current PATH.  This also has the benefit of allowing "CMD_Here.bat" to be updated independently as it's indirectly called from  "CMD_Here_Lite.bat" rather than copied.

To add user environment customizations, also copy "CH_UserConfig.bat" to the same directory that you copied "CMD_Here_Lite.bat" and modify "CH_UserConfig.bat" with your customizations.

----- ----- -----

Stand-Alone Use Method (does not require installing "CMD_Here_Global.bat" to PATH):

Copy "CMD_Here.bat" to the directory you want to launch a command window from.

Optionally copy "CH_RunConfig.bat" and "CH_UserConfig.bat" to the same directory and add any customizations you would like to "CH_UserConfig.bat".
