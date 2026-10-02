![image info](./duckduckgobrowserportable_readme_version_0.160.10_gh_files/media/image1.png)

DuckDuckGo Browser Portable

**Overview**

DuckDuckGo Browser Portable is a private, fast, and secure web browser
in a privacy, simplified, \'easy button\' fashion. It\'s packaged with a
PortableApps.com launcher as a portable app, so you can use it from a
cloud folder, portable drive, or local folder without needing to install
it on each PC. Learn more about [DuckDuckGo
Browser](https://www.duckduckgo.com/) ...

September 29, 2026 release version 0.160.10:

Notables in this release:

I. Language changed to Base=%PortableApps.comLocaleName% which should
use LanguageStrings

II\. For completeness: Settings additions, changes, and more related to
new release version, previous versions, and others have been addressed
to move files, directories, registry entries, and more to portable data
directory

[Download latest
release](https://github.com/hoabut/DuckDuckGoBrowserPortable/releases/download/v0.160.10)

[Go to the DuckDuckGo Browser Portable
Homepage](https://portableapps.com/node/68697)

**DuckDuckGo Browser: Microsoft Edge WebView2**

DuckDuckGo Browser uses [Microsoft Edge
WebView2](https://learn.microsoft.com/en-us/microsoft-edge/webview2/)
technology which makes this native 64-bit hybrid app a fantastic
provider of web experiences. In terms of privacy this app provides as
complete a privacy picture as possible in just the app space and nothing
else. To elaborate more, there are these services behind the app
enforces lots of privacy lockdowns and much, much more.

**DuckDuckGo Browser: PortableAppsFormat Portability Notes**

DuckDuckGo Browser can auto update itself so Custom.nsh scripts and
recently evolved into something much more than just scripts (i.e., using
PortableApps Launcher built-in tool to access certain built-in plugins)
are necessary to disable auto updates and addressing many other issues.
Together let's just call it 'scripts and developments'. There were many
changes to the app in many ways that requires addressing registry
entries, files, directories, and more for completeness sake.

;Custom.nsh version 1.01

;Definitions: Registry key equals registry key name which is the name
itself only

;for example, HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store

;Definitions: Registry key value equals registry key name plus value
associated with it

;for example, HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store
%PAL:LastPortableAppsBaseDir%%PAL:LastDirectory%\\\\DuckDuckGoBrowserPortable.exe

;or example, HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store
\$EXEDIR\\DuckDuckGoBrowserPortable.exe

\${SegmentFile}

Var RACF

Var RRVST

Var RRVTY

Var SACFA

Var SACFU

Var DVDRV

!define DISABLER \".disabled\"

!define DDGBrowserAppCompatFlags
\"\$EXEDIR\\DuckDuckGoBrowserPortable.exe\"

\${SegmentPrePrimary}

;Disable auto updater only

\${If} \${FileExists}
\"\$EXEDIR\\App\\DuckDuckGoBrowser\\DuckDuckGo.Updater.exe\"

Rename \"\$EXEDIR\\App\\DuckDuckGoBrowser\\DuckDuckGo.Updater.exe\"
\"\$EXEDIR\\App\\DuckDuckGoBrowser\\DuckDuckGo.Updater.exe\${DISABLER}\"

\${EndIf}

\${If} \${FileExists}
\"\$EXEDIR\\App\\DuckDuckGoBrowser\\DuckDuckGo.Updater.dll\"

Rename \"\$EXEDIR\\App\\DuckDuckGoBrowser\\DuckDuckGo.Updater.dll\"
\"\$EXEDIR\\App\\DuckDuckGoBrowser\\DuckDuckGo.Updater.dll\${DISABLER}\"

\${EndIf}

\${registry::KeyExists} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\$RACF

Pop \$RACF

;to keep things easier to read only If statements and nested If
statements are used it is just for readabilities as there are many other
advanced methods

;logic is KeyExists before any Read

\${If} \$RACF == 0

;keeping MessageBoxes for debugging purposes if need be

;MessageBox MB_OK \"PrePrimary Registry key name/registry key exists\"

\${registry::Read} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\"\${DDGBrowserAppCompatFlags}\" \$RRVST \$RRVTY

Pop \$RRVST

Pop \$RRVTY

;MessageBox MB_OK \$RRVST

;MessageBox MB_OK \$RRVTY

\${EndIf}

\${If} \$RACF == -1

;MessageBox MB_OK \"PrePrimary Registry key name/registry key does not
exists\"

\${EndIf}

\${If} \$RRVTY != \"\"

;MessageBox MB_OK \"PrePrimary Registry key value/registry key name plus
value associated with it exists\"

\${registry::SaveKey} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\"\$EXEDIR\\Data\\settings\\DDGBrowserAppCompatFlagsANSI.reg\" \"/U=0
/N=\${DDGBrowserAppCompatFlags}\" \$SACFA

Pop \$SACFA

\${If} \$SACFA == 0

;MessageBox MB_OK \"PrePrimary Registry key value saved/export to file
in ANSI NSIS successfully\"

\${EndIf}

\${If} \$SACFA == -1

;MessageBox MB_OK \"PrePrimary Registry key value saved/export to file
in ANSI NSIS fails; this is more than likely registry key value does not
exist\"

\${EndIf}

\${registry::SaveKey} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\"\$EXEDIR\\Data\\settings\\DDGBrowserAppCompatFlagsUNICODE.reg\" \"/U=1
/N=\${DDGBrowserAppCompatFlags}\" \$SACFU

Pop \$SACFU

\${If} \$SACFU == 0

;only after success second SaveKey of registry key value to file does
DeleteValue occurs

;MessageBox MB_OK \"PrePrimary Registry key value saved/export to file
in UNICODE NSIS successfully\"

\${registry::DeleteValue} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\"\${DDGBrowserAppCompatFlags}\" \$DVDRV

Pop \$DVDRV

\${If} \$DVDRV == 0

;MessageBox MB_OK \"PrePrimary Registry key value deleted successfully\"

\${EndIf}

\${If} \$DVDRV == -1

;MessageBox MB_OK \"PrePrimary fails to delete Registry key value\"

\${EndIf}

\${EndIf}

\${If} \$SACFU == -1

;MessageBox MB_OK \"PrePrimary Registry key value saved/export to file
in UNICODE NSIS fails; this is more than likely registry key value does
not exist\"

\${EndIf}

\${EndIf}

!macroend

;SegmentPostPrimary is used to confirm registry key value is not
available as expected

\${SegmentPostPrimary}

\${registry::KeyExists} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\$RACF

Pop \$RACF

;to keep things easier to read only If statements and nested If
statements are used it is just for readabilities as there are many other
advanced methods

;logic is KeyExists before any Read

\${If} \$RACF == 0

;keeping MessageBoxes for debugging purposes if need be

;MessageBox MB_OK \"PostPrimary Registry key name/registry key exists\"

\${registry::Read} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\"\${DDGBrowserAppCompatFlags}\" \$RRVST \$RRVTY

Pop \$RRVST

Pop \$RRVTY

;MessageBox MB_OK \$RRVST

;MessageBox MB_OK \$RRVTY

\${EndIf}

\${If} \$RACF == -1

;MessageBox MB_OK \"PostPrimary Registry key name/registry key does not
exists\"

\${EndIf}

\${If} \$RRVTY != \"\"

;MessageBox MB_OK \"PostPrimary Registry key value/registry key name
plus value associated with it exists\"

\${registry::SaveKey} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\"\$EXEDIR\\Data\\settings\\DDGBrowserAppCompatFlagsANSI.reg\" \"/U=0
/N=\${DDGBrowserAppCompatFlags}\" \$SACFA

Pop \$SACFA

\${If} \$SACFA == 0

;MessageBox MB_OK \"PostPrimary Registry key value saved/export to file
in ANSI NSIS successfully\"

\${EndIf}

\${If} \$SACFA == -1

;MessageBox MB_OK \"PostPrimary Registry key value saved/export to file
in ANSI NSIS fails; this is more than likely registry key value does not
exist\"

\${EndIf}

\${registry::SaveKey} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\"\$EXEDIR\\Data\\settings\\DDGBrowserAppCompatFlagsUNICODE.reg\" \"/U=1
/N=\${DDGBrowserAppCompatFlags}\" \$SACFU

Pop \$SACFU

\${If} \$SACFU == 0

;only after success second SaveKey of registry key value to file does
DeleteValue occurs

;MessageBox MB_OK \"PostPrimary Registry key value saved/export to file
in UNICODE NSIS successfully\"

\${registry::DeleteValue} \"HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store\"
\"\${DDGBrowserAppCompatFlags}\" \$DVDRV

Pop \$DVDRV

\${If} \$DVDRV == 0

;MessageBox MB_OK \"PostPrimary Registry key value deleted
successfully\"

\${EndIf}

\${If} \$DVDRV == -1

;MessageBox MB_OK \"PostPrimary fails to delete Registry key value\"

\${EndIf}

\${EndIf}

\${If} \$SACFU == -1

;MessageBox MB_OK \"PostPrimary Registry key value saved/export to file
in UNICODE NSIS fails; this is more than likely registry key value does
not exist\"

\${EndIf}

\${EndIf}

!macroend

To ensure registry entries (i.e., registry keys and registry key values)
with spaces in them are properly handle reliably, Custom.nsh scripts and
developments are used to address them. Code comments should suffice
enough to explain quite a bit of logic behind them.

In addition, DuckDuckGo Browser also leaves behind 'breadcrumbs' in
\\ProgramData\\Microsoft\\NetFramework\\BreadcrumbStore\\ with a large
percentage of them belonging to the system. During extremely rare times
this directory, \\ProgramData\\Microsoft\\NetFramework\\BreadcrumbStore,
requires elevated access to see its contents. It seems all of the files
generated are zero bytes. In DuckDuckGoBrowserPortable.ini some
directories moves and force cleanups:

\[DirectoriesMove\]

breadcrumb=%ALLUSERSAPPDATA%\\Microsoft\\NetFramework\\BreadcrumbStore

\[DirectoriesCleanupForce\]

1=%ALLUSERSAPPDATA%\\Microsoft\\NetFramework\\BreadcrumbStore

Well, there are also recent version and past versions that have:

\[DirectoriesMove\]

%LOCALAPPDATA%\\DuckDuckGo

%LOCALAPPDATA%\\DuckDuckGo.WebView.Published

%LOCALAPPDATA%\\Local\\Temp\\DuckDuckGo

%USERPROFILE%\\Desktop

They are taken care of with

\[DirectoriesMove\]

profile=%LOCALAPPDATA%\\DuckDuckGo

profilewebviewpublished=%LOCALAPPDATA%\\DuckDuckGo.WebView.Published

localtemp=%LOCALAPPDATA%\\Local\\Temp\\DuckDuckGo

desktop=%USERPROFILE%\\Desktop

and

\[DirectoriesCleanupIfEmpty\]

1=%LOCALAPPDATA%\\DuckDuckGo

2=%LOCALAPPDATA%\\DuckDuckGo.WebView.Published

3=%LOCALAPPDATA%\\Local\\Temp\\DuckDuckGo

Circling back to settings, data, and more, DuckDuckGo Browser stores
them in the registry which requires adjustments and cleanups:

\[RegistryKeys\]

DDGBrowser=HKCU\\SOFTWARE\\DuckDuckGo

DDGBrowserEdgeWebView=HKCU\\SOFTWARE\\Microsoft\\EdgeWebView

DDGBrowserAppUserModelId=HKCU\\SOFTWARE\\Classes\\AppUserModelId

DDGBrowserAppCompatFlags=HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store

DDGBrowserFeatureUsageAppSwitched=HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\FeatureUsage\\AppSwitched

DDGBrowserSearchJumplistData=HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search\\JumplistData

\[RegistryCleanupIfEmpty\]

1=HKCU\\SOFTWARE\\DuckDuckGo

2=HKCU\\SOFTWARE\\Microsoft\\EdgeWebView

3=HKCU\\SOFTWARE\\Classes\\AppUserModelId

4=HKCU\\SOFTWARE\\Microsoft\\Windows
NT\\CurrentVersion\\AppCompatFlags\\Compatibility Assistant\\Store

5=HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\FeatureUsage\\AppSwitched

6=HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search\\JumplistData

Getting back to the Custom.nsh scripts and developments logic there is a
quick mention that there might seem to be some duplicate codes in and/
or between 'SegmentPrePrimary' and 'SegmentPostPrimary' but they are
done on the purpose because the OS could regenerate specific registry
key value indicated in the codes.

Finally, there are OS "Prefetch" for application startup optimizations.
The ".pf" files are encrypted and the system cleans them up
periodically. For example,

\\Windows\\Prefetch\\DUCKDUCKGO.EXE-E750B5B0.pf

\\Windows\\Prefetch\\DUCKDUCKGOBROWSERPORTABLE.EXE-3168E4EC.pf

\\Windows\\Prefetch\\MSEDGEWEBVIEW2.EXE-7CF93497.pf

\\Windows\\Prefetch\\MSEDGEWEBVIEW2.EXE-7CF93498.pf

\\Windows\\Prefetch\\MSEDGEWEBVIEW2.EXE-7CF93499.pf

\\Windows\\Prefetch\\MSEDGEWEBVIEW2.EXE-7CF9349A.pf

\\Windows\\Prefetch\\MSEDGEWEBVIEW2.EXE-7CF9349E.pf

\\Windows\\Prefetch\\MSEDGEWEBVIEW2.EXE-7CF9349F.pf

\\Windows\\Prefetch\\Op-MSEDGEWEBVIEW2.EX-7CF93497-00000001.pf

Besides being the definitive [portable
app](https://portableapps.com/about/what_is_a_portable_app), it is very
workable in other OS/platform such as Linux, UNIX, BSD, etc. via Wine
(winehq.org) & Mac OS X via CrossOver, Wineskin, WineBottler, PlayOnMac.

Finally, "Why PortableApps.com Format and a PortableApps.com Installer?"
Perhaps, a read at
<https://portableapps.com/about/what_is_a_portable_app#whypaf> would
suffice.
