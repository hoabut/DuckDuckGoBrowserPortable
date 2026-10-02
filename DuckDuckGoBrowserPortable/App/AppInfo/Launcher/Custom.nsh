;Custom.nsh version 1.01

;Definitions: Registry key equals registry key name which is the name itself only
;for example, HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store
;Definitions: Registry key value equals registry key name plus value associated with it
;for example, HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store	%PAL:LastPortableAppsBaseDir%%PAL:LastDirectory%\\DuckDuckGoBrowserPortable.exe
;or example, HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store	$EXEDIR\DuckDuckGoBrowserPortable.exe

${SegmentFile}

Var RACF
Var RRVST
Var RRVTY
Var SACFA
Var SACFU
Var DVDRV
!define DISABLER ".disabled"
!define DDGBrowserAppCompatFlags "$EXEDIR\DuckDuckGoBrowserPortable.exe"

${SegmentPrePrimary}

	;Disable auto updater only
	${If} ${FileExists} "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.exe"
			Rename "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.exe" "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.exe${DISABLER}"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.dll"
			Rename "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.dll" "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.dll${DISABLER}"
	${EndIf}
	${registry::KeyExists} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" $RACF
	Pop $RACF
;to keep things easier to read only If statements and nested If statements are used it is just for readabilities as there are many other advanced methods
	;logic is KeyExists before any Read
	${If} $RACF == 0
		;keeping MessageBoxes for debugging purposes if need be
		;MessageBox MB_OK "PrePrimary Registry key name/registry key exists"
		${registry::Read} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "${DDGBrowserAppCompatFlags}" $RRVST $RRVTY
		Pop $RRVST
		Pop $RRVTY
		;MessageBox MB_OK $RRVST
		;MessageBox MB_OK $RRVTY
	${EndIf}
	${If} $RACF == -1
		;MessageBox MB_OK "PrePrimary Registry key name/registry key does not exists"
	${EndIf}
	${If} $RRVTY != ""
		;MessageBox MB_OK "PrePrimary Registry key value/registry key name plus value associated with it exists"
		${registry::SaveKey} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "$EXEDIR\Data\settings\DDGBrowserAppCompatFlagsANSI.reg" "/U=0 /N=${DDGBrowserAppCompatFlags}" $SACFA
		Pop $SACFA
		${If} $SACFA == 0
			;MessageBox MB_OK "PrePrimary Registry key value saved/export to file in ANSI NSIS successfully"
		${EndIf}
		${If} $SACFA == -1
			;MessageBox MB_OK "PrePrimary Registry key value saved/export to file in ANSI NSIS fails; this is more than likely registry key value does not exist"
		${EndIf}
		${registry::SaveKey} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "$EXEDIR\Data\settings\DDGBrowserAppCompatFlagsUNICODE.reg" "/U=1 /N=${DDGBrowserAppCompatFlags}" $SACFU
		Pop $SACFU
		${If} $SACFU == 0
			;only after success second SaveKey of registry key value to file does DeleteValue occurs
			;MessageBox MB_OK "PrePrimary Registry key value saved/export to file in UNICODE NSIS successfully"
			${registry::DeleteValue} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "${DDGBrowserAppCompatFlags}" $DVDRV
			Pop $DVDRV
			${If} $DVDRV == 0
			;MessageBox MB_OK "PrePrimary Registry key value deleted successfully"
			${EndIf}
			${If} $DVDRV == -1
			;MessageBox MB_OK "PrePrimary fails to delete Registry key value"
			${EndIf}
		${EndIf}
		${If} $SACFU == -1
			;MessageBox MB_OK "PrePrimary Registry key value saved/export to file in UNICODE NSIS fails; this is more than likely registry key value does not exist"
		${EndIf}
		
	${EndIf}

!macroend

;SegmentPostPrimary is used to confirm registry key value is not available as expected
${SegmentPostPrimary}

	${registry::KeyExists} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" $RACF
	Pop $RACF
;to keep things easier to read only If statements and nested If statements are used it is just for readabilities as there are many other advanced methods
	;logic is KeyExists before any Read
	${If} $RACF == 0
		;keeping MessageBoxes for debugging purposes if need be
		;MessageBox MB_OK "PostPrimary Registry key name/registry key exists"
		${registry::Read} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "${DDGBrowserAppCompatFlags}" $RRVST $RRVTY
		Pop $RRVST
		Pop $RRVTY
		;MessageBox MB_OK $RRVST
		;MessageBox MB_OK $RRVTY
	${EndIf}
	${If} $RACF == -1
		;MessageBox MB_OK "PostPrimary Registry key name/registry key does not exists"
	${EndIf}
	${If} $RRVTY != ""
		;MessageBox MB_OK "PostPrimary Registry key value/registry key name plus value associated with it exists"
		${registry::SaveKey} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "$EXEDIR\Data\settings\DDGBrowserAppCompatFlagsANSI.reg" "/U=0 /N=${DDGBrowserAppCompatFlags}" $SACFA
		Pop $SACFA
		${If} $SACFA == 0
			;MessageBox MB_OK "PostPrimary Registry key value saved/export to file in ANSI NSIS successfully"
		${EndIf}
		${If} $SACFA == -1
			;MessageBox MB_OK "PostPrimary Registry key value saved/export to file in ANSI NSIS fails; this is more than likely registry key value does not exist"
		${EndIf}
		${registry::SaveKey} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "$EXEDIR\Data\settings\DDGBrowserAppCompatFlagsUNICODE.reg" "/U=1 /N=${DDGBrowserAppCompatFlags}" $SACFU
		Pop $SACFU
		${If} $SACFU == 0
			;only after success second SaveKey of registry key value to file does DeleteValue occurs
			;MessageBox MB_OK "PostPrimary Registry key value saved/export to file in UNICODE NSIS successfully"
			${registry::DeleteValue} "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "${DDGBrowserAppCompatFlags}" $DVDRV
			Pop $DVDRV
			${If} $DVDRV == 0
			;MessageBox MB_OK "PostPrimary Registry key value deleted successfully"
			${EndIf}
			${If} $DVDRV == -1
			;MessageBox MB_OK "PostPrimary fails to delete Registry key value"
			${EndIf}
		${EndIf}
		${If} $SACFU == -1
			;MessageBox MB_OK "PostPrimary Registry key value saved/export to file in UNICODE NSIS fails; this is more than likely registry key value does not exist"
		${EndIf}
	${EndIf}

!macroend