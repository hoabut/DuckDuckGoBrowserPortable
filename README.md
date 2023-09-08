![image info](./duckduckgobrowserportable_readme_version_0.47.1_gh_files/media/image1.png)

DuckDuckGo Browser Portable

**Overview**

DuckDuckGo Browser Portable is a private, fast, and secure web browser
in a privacy, simplified, \'easy button\' fashion. It\'s packaged with a
PortableApps.com launcher as a portable app, so you can use it from a
cloud folder, portable drive, or local folder without needing to install
it on each PC. Learn more about [DuckDuckGo
Browser](https://www.duckduckgo.com/) ...

September 2, 2023 release version 0.47.1:

Notables in this release: Initial release

[Download latest
release](https://github.com/hoabut/DuckDuckGoBrowserPortable/releases/tag/v0.47.1)

[Go to the DuckDuckGo Browser Portable
Homepage](https://portableapps.com/node/68697)

**DuckDuckGo Browser: Microsoft Edge WebView2**

DuckDuckGo Browser uses [Microsoft Edge
WebView2](https://learn.microsoft.com/en-us/microsoft-edge/webview2/)
technology which makes this native 64-bit hybrid app a fantastic
provider of web experiences. In terms of privacy this app provides as
complete a privacy picture as possible in just the app space and nothing
else.

**DuckDuckGo Browser: PortableAppsFormat Portability Notes**

DuckDuckGo Browser can auto update itself so Custom.nsh scripts are
necessary to disable it:

\${SegmentFile}

!define DISABLER \".disabled\"

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

!macroend

In addition, DuckDuckGo Browser also leaves behind "breadcrumbs" in
\\ProgramData\\Microsoft\\NetFramework\\BreadcrumbStore\\ with a large
percentage of them belonging to the system. It seems all of the files
generated are zero bytes. In DuckDuckGoBrowserPortable.ini some
directories moves and force cleanups:

\[DirectoriesMove\]

breadcrumb=%ALLUSERSAPPDATA%\\Microsoft\\NetFramework\\BreadcrumbStore

\[DirectoriesCleanupForce\]

1=%ALLUSERSAPPDATA%\\Microsoft\\NetFramework\\BreadcrumbStore

As for settings and data, DuckDuckGo Browser stores them in the registry
and %LOCALAPPDATA% which again requires adjustments and cleanups:

\[RegistryKeys\]

DDGBrowser=HKCU\\SOFTWARE\\DuckDuckGo

DDGBrowserEdgeWebView=HKCU\\SOFTWARE\\Microsoft\\EdgeWebView

\[RegistryCleanupIfEmpty\]

1=HKCU\\SOFTWARE\\DuckDuckGo

2=HKCU\\SOFTWARE\\Microsoft\\EdgeWebView

\[DirectoriesMove\]

profile=%LOCALAPPDATA%\\DuckDuckGo

\[DirectoriesCleanupIfEmpty\]

1=%LOCALAPPDATA%\\DuckDuckGo

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