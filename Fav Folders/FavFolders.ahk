explorerEXE = F:\Windows\winsxs\amd64_microsoft-windows-explorer_31bf3856ad364e35_6.1.7601.17514_none_afdaac81905bf900\explorer.exe
Loop, Read, %a_scriptdir%\favorites.ini
{
    StringSplit, line, A_LoopReadLine, `;
    paths%a_index% = %line2%
    IfNotEqual, line2, SEP
    {
        Menu, Favorites, Add, %a_index% %line1%, OpenFavorite
    }
    else
    {
     Menu, Favorites, Add, %line1%, OpenFavorite
    }
}
Return
;----Open the favorite
OpenFavorite:
        StringSplit, item, A_ThisMenuItem, %A_Space%
        StringTrimLeft, path, paths%item1%, 0
        Run, %explorerEXE% %path%
return

;----Raise the menu
^Rbutton::
    Loop, Read, %a_scriptdir%\favorites.ini
    {
        StringSplit, line, A_LoopReadLine, `;
        paths%a_index% = %line2%
        IfNotEqual, line2, SEP
        {
            Menu, Favorites, Add, %a_index% %line1%, OpenFavorite
        }
        else
        {
         Menu, Favorites, Add, %line1%, OpenFavorite
        }
    }
    Menu, Favorites, show
return
;----Open the favorite
OpenFavorite:
        StringSplit, item, A_ThisMenuItem, %A_Space%
        StringTrimLeft, path, paths%item1%, 0
        Run, %explorerEXE% %path%
return