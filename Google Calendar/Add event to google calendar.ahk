; ===Begin of operations===
settitlematchmode, 2
g_chrome_wintitle:="Google Chrome"


gchrome_addr(text){
  global g_chrome_wintitle
  sendmessage,0xC,,% "" text "",Chrome_OmniboxView1,%g_chrome_wintitle%
  if errorlevel=1
    return 0
}

gchrome_go(text){
  critical
  global g_chrome_wintitle
  a:=gchrome_addr(text)
  if a!=0
    return
  else
    sendmessage,0x100,0xD,0x1C0001,Chrome_OmniboxView1,%g_chrome_wintitle%
    sleep 1
}

gchrome_getaddr(){
  global g_chrome_wintitle
  controlgettext,addr,Chrome_OmniboxView1,%g_chrome_wintitle%
  if errorlevel=0
    return addr
  else
    return
}

gchrome_gettitle(){
  global g_chrome_wintitle
  wingettitle,gchrome_title,%g_chrome_wintitle%
  stringreplace,gchrome_title,gchrome_title,% "- " g_chrome_wintitle
  if errorlevel=0
    return gchrome_title
  else
    return
}

gchrome_close(){
  global g_chrome_wintitle
  setcontroldelay,100
  setkeydelay,20,10
  controlsend,Chrome_RenderWidgetHostHWND1,{ctrl down}w{ctrl up},%g_chrome_wintitle%
  if errorlevel=1
    return
}

gchrome_newtab(){
  global g_chrome_wintitle
  setcontroldelay,100
  setkeydelay,20,10
  controlsend,Chrome_RenderWidgetHostHWND1,{ctrl down}t{ctrl up},%g_chrome_wintitle%
  if errorlevel=1
    return
}
; ===end of chrome operations===
;---------------------------------------------------------------------------
; Alt+L: Log file
;---------------------------------------------------------------------------
!L::
CustomColor = 000000
Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, color, %CustomColor%
Gui, Font, S20 cBlack,Arial Bold
Gui, Add, Edit, -WantReturn w500 vMyLog
Gui, font, s16 cBlue, Verdana
Gui, Add, Button, default x530 y15, Add
;Gui, font, s10 cWhite, Verdana
Gui, Add, Link, x30, <a href="%todoFileName%">Todo List</a>
;Gui, Add, Picture, x530 y15 W32 h-1, todo.jpg
;WinSet, TransColor, %CustomColor% 200
Gui, Show
Return

ButtonAdd:
MyLog:
    GuiControlGet, MyLog
    FileAppend, `n%MyLog% //Added@%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%, %todoFileName%
    Gui, Destroy
    if InStr(MyLog,"search:")
      Goto, searchChrome
    Else {
      if InStr(MyLog, "todo:")
        Goto, todoInGoogleCalendar
    }
Return

searchChrome:
    webAddress := substr(MyLog,8)
    gchrome_newtab()
    gchrome_go(webAddress)
Return

todoInGoogleCalendar:
    tmpAddress := SubStr(MyLog,6)
    webAddress = cal %tmpAddress%
    gchrome_newtab()
    gchrome_go(webAddress)
    WinWaitActive, Google Calendar - Google Chrome, , 5
    IfWinExist, Google Calendar - Google Chrome
    {
        WinActivate, Google Calendar - Google Chrome
    }
    IfWinActive, Google Calendar - Google Chrome
    {
      Click 316, 652
      Sleep, 500
      click 151, 173
    }
    SendInput,{alt}{tab}
    gchrome_close()
Return