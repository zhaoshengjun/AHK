;sourceFolders := ["H:\01_Inbox\Books\1\*.pdf","H:\01_Inbox\Books\1\*.epub"]
sourceFolders := ["C:\Documents and Settings\ZhaoSX\Desktop\group\*.*"]
targetFolder = C:\Documents and Settings\ZhaoSX\Desktop\group\

Loop,% sourceFolders.MaxIndex()
{
    sourceFolder := sourceFolders[A_Index]
    Loop, %sourceFolder%, 1, 1
    {
      fileTimestamp = %A_LoopFileTimeModified%
      timeStamp := SubStr(fileTimestamp,1,8)
      FormatTime, YearWeek, %timeStamp%, YWeek
      yearNumber := SubStr(YearWeek, 1, 4)
      weekNumber := SubStr(YearWeek, 5)
      folderName = %targetFolder%%yearNumber%W%weekNumber%
      IfNotExist, %folderName%
        FileCreateDir, %folderName%
      ;newFileName = %folderName%\%A_LoopFileName%
      ;MsgBox, %fileTimestamp%`n%timeStamp%`n%YearWeek%`n%folderName%`n%newFileName%
      FileMove, %A_LoopFileFullPath%, %folderName%,1
    }
}

;WeekOfYear = %A_YDay%
;WeekOfYear /= 7
;WeekOfYear++ ; Convert from 0-base to 1-base

;MsgBox, %WeekOfYear%
;;if ( errorCount = 0 ) or ( copy_it = n )
;;{
;;    MsgBox,  Total %fileCount% files and synced %fileSyncCount% files.`n Sync completed.
;;    GUI destroy
;;}
;Return

;GuiEscape:
;GuiClose:
;Gui destroy
;YW := 201417
;MsgBox % "YWeek:`t" YW "`nFrom:`t" YWeekD( YW "1","ddd MMM d yyyy") "`nTo:`t" YWeekD(YW "7", "ddd MMM d yyyy")

;YWeekD( ywd, format="yyyyMMdd" ) {      ; returns the date from YWeek+day using specified format
;   y:= SubStr(ywd,1,4)                  ; splitting the input string into year, (yyyy)
;   w:= SubStr(ywd,5,2)                  ; week (01 - 53)
;   d:= SubStr(ywd,7)                    ; and day-of-the-week (1-7  Monday is 1)
;   dt:= y "0103000000"                  ; initializing dt as Jan 3th of the same year
;   FormatTime wd4, % dt, WDay           ; wd4 is the day-of-the-week of Jan 4th by ISO8601 (Mon - 1, Sun - 7)
;   dt+= 1 - wd4 + d + (w-1)*7, Days     ; adding the days to dt ( Jan 3th )
;   FormatTime dt, % dt, % format        ; formatting the result
;   return dt
;}