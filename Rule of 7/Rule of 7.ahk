#Persistent
;Todo
; 1. Add PAUSE fucntion
; 2. Change UI to Alfred Mode and also add hot key for it

;Global variables
logFileName = %A_ScriptDir%\log.txt
;C:\Documents and Settings\ZhaoSX\Desktop\Sync\Personal\log.txt
RelaxTimer := 0
Interval := 35
remainLoop := 7
pastLoop := 0
timeString = ""

Gosub, StartGUI

return
;Showing the GUI
StartGUI:
    Gui, Margin, 0, 0
    currentWidth := 0
    Loop,  %pastLoop%
    {
        Gui, Add, Picture, w50 h50 x%currentWidth% y0, tomato2.jpg
        currentWidth := currentWidth + 55
    }
    Loop, %remainLoop%
    {
        Gui, Add, Picture, w50 h50 x%currentWidth% y0, tomato3.jpg
        currentWidth := currentWidth + 55
    }
    Gui, Font, S20 cBlue, Verdana
    Gui, Add, Text, w400 Center x0 y60, Are you ready to start?
    Gui, Font, s14 cBlue, Verdana
    Gui, Add, Button, x150 y100 Default gCloseAlert, Start
    Gui, Show, w400 h150 xCenter yCenter, Rule of 7
Return

RelaxEyeAlert:
    RelaxTimer := RelaxTimer + 1
    MinsToNextAlert := MinsToNextAlert - 1
    Gosub, ShowToolTip

    if (RelaxTimer = Interval) {
        remainLoop := remainLoop - 1
        pastLoop := 7 - remainLoop
        ;MsgBox, remainLoop is %remainLoop% and pastLoop is %pastLoop%
        SetTimer, RelaxEyeAlert, Off
        timeString = %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%
        Gui, Margin, 0, 0
        currentWidth := 5
        Loop,  %pastLoop%
        {
            Gui, Add, Picture, w50 h50 x%currentWidth% y0, tomato2.jpg
            currentWidth := currentWidth + 55
        }
        Loop, %remainLoop%
        {
            Gui, Add, Picture, w50 h50 x%currentWidth% y0, tomato3.jpg
            currentWidth := currentWidth + 55
        }
        Gui, Font, S20 cBlue, Verdana
        Gui, Add, Text, w400 Center x0 y60, Let's take a break right now
        Gui, Font, S10 cBlack, Arial
        Gui, Add, Text,x5, Please summarize what you've done in the past 35 minutes:
        Gui, Add, Edit, vMyEdit w350 x5
        Gui, Font, S18 cBlue, Verdana
        Gui, Add, Button, x150 y150 Default gSaveLog, Save
        Gui, Show, w400 h200 xCenter yCenter, Rule of 7
    }
return

SaveLog:
    GuiControlGet, MyEdit
    ;Gui, Submit
    ;MsgBox, %MyEdit%
    FileAppend, `n%pastLoop%. %MyEdit% @%timeString%, %logFileName%
    if remainLoop < 1
        Gosub, finishToday
    Else{
        Gosub, CloseAlert
    }
Return

CloseAlert:
    RelaxTimer := 0
    MinsToNextAlert := Interval
    Gosub, ShowToolTip
    if ( %pastLoop% = 0 )
    {
        SetTimer, RelaxEyeAlert, 60000
    } Else {
        SetTimer, RelaxEyeAlert, On
    }
    Gui, Destroy
return

ShowToolTip:
    if (MinsToNextAlert > 1)
    {
        if (remainLoop > 1)
        {
            Menu, Tray, Tip, %MinsToNextAlert% minutes to next relax `n%remainLoop% rounds to finish today
        }
        Else
        {
            Menu, Tray, Tip, %MinsToNextAlert% minutes to next relax `n%remainLoop% round to finish today
        }

    }
    else
    {
        if (remainLoop > 1)
        {
            Menu, Tray, Tip, %MinsToNextAlert% minute to next relax `n%remainLoop% rounds to finish today
        }
        Else
        {
            Menu, Tray, Tip, %MinsToNextAlert% minute to next relax `n%remainLoop% round to finish today
        }

    }
return

finishToday:
    Gui, Destroy
    MsgBox, You've finished today's job.
    ExitApp