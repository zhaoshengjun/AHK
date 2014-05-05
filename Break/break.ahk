#Persistent

RelaxTimer := 0
Interval := 45
MinsToNextAlert := Interval
SetTimer, RelaxEyeAlert, 60000
Gosub, ShowToolTip
return

!L::
Reload
Return

RelaxEyeAlert:
RelaxTimer := RelaxTimer + 1
MinsToNextAlert := MinsToNextAlert - 1
Gosub, ShowToolTip

if (RelaxTimer = Interval) {
SetTimer, RelaxEyeAlert, Off
Gui, Margin, 0, 0
Gui, Font, s14 cBlue, Verdana
Gui, Add, Text, w300 Center, Stand UP and STRETCH
Gui, Font, ,
Gui, Font, , Verdana
Gui, Add, Button, x120 y30 w60 Default gCloseAlert, Close
Gui, Show, w300 h70 xCenter yCenter, Relax Alert
}
return

CloseAlert:
RelaxTimer := 0
MinsToNextAlert := Interval
Gosub, ShowToolTip
SetTimer, RelaxEyeAlert, On
Gui, Destroy
return

ShowToolTip:
if (MinsToNextAlert > 1)
{
	Menu, Tray, Tip, %MinsToNextAlert% minutes to next stretch
}
else
{
	Menu, Tray, Tip, %MinsToNextAlert% minute to next stretch
}
return