${SegmentFile}

!define DISABLER ".disabled"

${SegmentPrePrimary}

	;Disable auto updater only
	${If} ${FileExists} "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.exe"
			Rename "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.exe" "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.exe${DISABLER}"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.dll"
			Rename "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.dll" "$EXEDIR\App\DuckDuckGoBrowser\DuckDuckGo.Updater.dll${DISABLER}"
	${EndIf}
!macroend