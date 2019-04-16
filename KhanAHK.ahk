;global coordMode
coordMode,pixel
;Translatebox coords
XstartTranslatebox=1500
XendTranslatebox=2160
YstartTranslatebox=200
YendTranslatebox=2000
;Faster clicks
setmousedelay -1 ;This is gold :DD
;Stringbox coords
XstartTranslateboxStringbox=0
XendTranslateboxStringbox=1000
YstartTranslateboxStringbox=200
YendTranslateboxStringbox=2200
;when to scroll
YscrolldownTreshold = 1000
YscrollupTreshold = 620
;how much to scroll
scrollValue = 2

 
  
;TODO
;include corner finding script here to find perfect search boxes
;fix all searchboxes and click offsets manually
;functionalize

!t::
coordMode,pixel
MouseMove, XstartTranslatebox, YstartTranslatebox
sleep, 2000 ;(wait 2 seconds)
MouseMove, XendTranslatebox, YstartTranslatebox
sleep, 2000 ;(wait 2 seconds)
MouseMove, XendTranslatebox, YendTranslatebox
sleep, 2000 ;(wait 2 seconds)
MouseMove, XstartTranslatebox, YendTranslatebox
sleep, 2000 ;(wait 2 seconds)

;Upvote top string
Alt::
MouseGetPos, XposStart, YposStart
ImageSearch,ix,iy,XstartTranslatebox,YstartTranslatebox,XendTranslatebox,YendTranslatebox,%A_ScriptDir%\pictures\alreadyliked.bmp
if ErrorLevel = 2 ; If already upvoted, do not upvote next string
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
{
	ImageSearch,ix,iy,XstartTranslatebox,YstartTranslatebox,XendTranslatebox,YendTranslatebox,%A_ScriptDir%\pictures\upvote.bmp
	MouseClick, left,  ix+20, iy+20
	MouseMove, XposStart, YposStart
}
return


;Save string
!s::
MouseGetPos, XposStart, YposStart
ImageSearch,ix2,iy2,XstartTranslatebox,YstartTranslatebox,XendTranslatebox,YendTranslatebox,%A_ScriptDir%\pictures\saveShortstring.bmp
If !ix2 ; == Failed search
{
	;MsgBox could not find short string, looking for long instead
	ImageSearch,ix2,iy2,XstartTranslatebox,YstartTranslatebox,XendTranslatebox,YendTranslatebox,%A_ScriptDir%\pictures\saveLongstring.bmp
} ;For some reason the save button image looks different for long strings, do in case the first search fails
MsgBox %ix2% and %iy2%
MouseClick, left,  ix2+40, iy2+40
MouseMove, XposStart, YposStart
return


;Next string
!n::
MouseGetPos, XposStart, YposStart
; If at approved
ImageSearch,ix,iy,XstartTranslateboxStringbox,YstartTranslateboxStringbox,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\greenbottomcorner.bmp ; green corner
if ErrorLevel = 2 ; Green corner not found
{
	MsgBox Other error (probably filepath)
}
If ErrorLevel = 1
{
	;MsgBox Could not find green corner
}
if ErrorLevel = 0
{
	;MsgBox found green corner
	ImageSearch,ixgreen,iygreen,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\greencolor.bmp ; next green
	If ErrorLevel = 1
	{
		;MsgBox could not find green color
		iygreen = 10000
	}
	ImageSearch,ixblue,iyblue,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\bluecolor.bmp ; next blue
	If ErrorLevel = 1
	{
		;MsgBox could not find blue color
		iyblue = 10000
	}
	ImageSearch,ixred,iyred,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\redcolor.bmp ; next red
	If ErrorLevel = 1
	{
		;MsgBox could not find red color
		iyred = 10000
	}

	if (iygreen < iyblue) and (iygreen < iyred)
	{
		;MsgBox green first
		MouseClick, left,  ixgreen+20, iygreen+20
		if (iygreen > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyblue < iygreen) and (iyblue < iyred)
	{
		;MsgBox blue first
		MouseClick, left,  ixblue+20, iyblue+20
		if (iyblue > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyred < iyblue) and (iyred < iygreen)
	{
		;MsgBox red first
		MouseClick, left,  ixred+20, iyred+20
		if (iyred > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	MsgBox Found none, quitting
	return
}
; If at translated
ImageSearch,ix,iy,XstartTranslateboxStringbox,YstartTranslateboxStringbox,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\bluebottomcorner.bmp ; blue corner
if ErrorLevel = 2 ; Blue corner not found
{
	MsgBox Other error (probably filepath)
}
If ErrorLevel = 1
{
	;MsgBox could not find blue corner
}
if ErrorLevel = 0
{
	;MsgBox found blue corner
	ImageSearch,ixgreen,iygreen,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\greencolor.bmp ; next green
	If ErrorLevel = 1
	{
		;MsgBox could not find green color
		iygreen = 10000
	}
	ImageSearch,ixblue,iyblue,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\bluecolor.bmp ; next blue
	If ErrorLevel = 1
	{
		;MsgBox could not find blue color
		iyblue = 10000
	}
	ImageSearch,ixred,iyred,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\redcolor.bmp ; next red
	If ErrorLevel = 1
	{
		;MsgBox could not find red color
		iyred = 10000
	}

	if (iygreen < iyblue) and (iygreen < iyred)
	{
		;MsgBox green first
		MouseClick, left,  ixgreen+20, iygreen+20
		if (iygreen > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyblue < iygreen) and (iyblue < iyred)
	{
		;MsgBox blue first
		MouseClick, left,  ixblue+20, iyblue+20
		if (iyblue > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyred < iyblue) and (iyred < iygreen)
	{
		;MsgBox red first
		MouseClick, left,  ixred+20, iyred+20
		if (iyred > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	MsgBox Found none, quitting
	return
}
; If at untranslated
ImageSearch,ix,iy,XstartTranslateboxStringbox,YstartTranslateboxStringbox,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\redbottomcorner.bmp ; red corner
if ErrorLevel = 2 ; Red corner not found
{
	MsgBox Other error (probably filepath)
	return
}
If ErrorLevel = 1
{
	MsgBox could not find active string, exiting
	return
}
if ErrorLevel = 0
{
	;MsgBox found red corner
	ImageSearch,ixgreen,iygreen,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\greencolor.bmp ; next green
	If ErrorLevel = 1
	{
		;MsgBox could not find green color
		iygreen = 10000
	}
	ImageSearch,ixblue,iyblue,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\bluecolor.bmp ; next blue
	If ErrorLevel = 1
	{
		;MsgBox could not find blue color
		iyblue = 10000
	}
	ImageSearch,ixred,iyred,XstartTranslateboxStringbox,iy+20,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\redcolor.bmp ; next red
	If ErrorLevel = 1
	{
		;MsgBox could not find red color
		iyred = 10000
	}

	if (iygreen < iyblue) and (iygreen < iyred)
	{
		;MsgBox green first
		MouseClick, left,  ixgreen+20, iygreen+20
		if (iygreen > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyblue < iygreen) and (iyblue < iyred)
	{
		;MsgBox blue first
		MouseClick, left,  ixblue+20, iyblue+20
		if (iyblue > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyred < iyblue) and (iyred < iygreen)
	{
		;MsgBox red first
		MouseClick, left,  ixred+20, iyred+20
		if (iyred > YscrolldownTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelDown,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	MsgBox Found none, quitting
	return
}
return


;Previous string
!b::
MouseGetPos, XposStart, YposStart
; If at approved
ImageSearch,ix,iy,XstartTranslateboxStringbox,YstartTranslateboxStringbox,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\greentopcorner.bmp ; green corner
if ErrorLevel = 2 ; Green corner not found
{
	MsgBox Other error (probably filepath)
}
If ErrorLevel = 1
{
	;MsgBox Could not find green corner
}
if ErrorLevel = 0
{
	;MsgBox found green corner
	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iygreen = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixgreen,iygreen,XstartTranslateboxStringbox,iygreen+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\greencolorcorner.bmp ; previous green
		;MsgBox %iygreen%
		If !iygreen
		{
			;MsgBox could not find green color corner
			iygreen=%tempy%
			ixgreen=%tempx%
		}
		if (iygreen > tempy)
		{
			tempy = %iygreen%
			tempx = %ixgreen%
		}
	}
	iygreen = %tempy%
	ixgreen = %tempx%

	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iyblue = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixblue,iyblue,XstartTranslateboxStringbox,iyblue+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\bluecolorcorner.bmp ; previous blue
		;MsgBox %iyblue%
		If !iyblue
		{
			;MsgBox could not find blue color corner
			iyblue=%tempy%
			ixblue=%tempx%
		}
		if (iyblue > tempy)
		{
			tempy = %iyblue%
			tempx = %ixblue%
		}
	}
	iyblue = %tempy%
	ixblue = %tempx%

	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iyred = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixred,iyred,XstartTranslateboxStringbox,iyred+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\redcolorcorner.bmp ; previous red
		;MsgBox %iyred%
		If !iyred
		{
			;MsgBox could not find red color corner
			iyred=%tempy%
			ixred=%tempx%
		}
		if (iyred > tempy)
		{
			tempy = %iyred%
			tempx = %ixred%
		}
	}
	iyred = %tempy%
	ixred = %tempx%

	;MsgBox green %iygreen% blue %iyblue% red %iyred%
	
	if (iygreen > iyblue) and (iygreen > iyred)
	{
		;MsgBox green first
		MouseClick, left,  ixgreen+20, iygreen-20
		if (iygreen < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyblue > iygreen) and (iyblue > iyred)
	{
		;MsgBox blue first
		MouseClick, left,  ixblue+20, iyblue-20
		if (iyblue < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyred > iyblue) and (iyred > iygreen)
	{
		;MsgBox red first
		MouseClick, left,  ixred+20, iyred-20
		if (iyred < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	MsgBox Found none, quitting
	return
}
; If at translated
ImageSearch,ix,iy,XstartTranslateboxStringbox,YstartTranslateboxStringbox,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\bluebottomcorner.bmp ; blue corner
if ErrorLevel = 2 ; Blue corner not found
{
	MsgBox Other error (probably filepath)
}
If ErrorLevel = 1
{
	;MsgBox could not find blue corner
}
if ErrorLevel = 0
{
	;MsgBox found blue corner
	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iygreen = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixgreen,iygreen,XstartTranslateboxStringbox,iygreen+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\greencolorcorner.bmp ; previous green
		;MsgBox %iygreen%
		If !iygreen
		{
			;MsgBox could not find green color corner
			iygreen=%tempy%
			ixgreen=%tempx%
		}
		if (iygreen > tempy)
		{
			tempy = %iygreen%
			tempx = %ixgreen%
		}
	}
	iygreen = %tempy%
	ixgreen = %tempx%

	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iyblue = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixblue,iyblue,XstartTranslateboxStringbox,iyblue+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\bluecolorcorner.bmp ; previous blue
		;MsgBox %iyblue%
		If !iyblue
		{
			;MsgBox could not find blue color corner
			iyblue=%tempy%
			ixblue=%tempx%
		}
		if (iyblue > tempy)
		{
			tempy = %iyblue%
			tempx = %ixblue%
		}
	}
	iyblue = %tempy%
	ixblue = %tempx%

	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iyred = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixred,iyred,XstartTranslateboxStringbox,iyred+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\redcolorcorner.bmp ; previous red
		;MsgBox %iyred%
		If !iyred
		{
			;MsgBox could not find red color corner
			iyred=%tempy%
			ixred=%tempx%
		}
		if (iyred > tempy)
		{
			tempy = %iyred%
			tempx = %ixred%
		}
	}
	iyred = %tempy%
	ixred = %tempx%

	;MsgBox green %iygreen% blue %iyblue% red %iyred%
	
	if (iygreen > iyblue) and (iygreen > iyred)
	{
		;MsgBox green first
		MouseClick, left,  ixgreen+20, iygreen-20
		if (iygreen < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyblue > iygreen) and (iyblue > iyred)
	{
		;MsgBox blue first
		MouseClick, left,  ixblue+20, iyblue-20
		if (iyblue < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyred > iyblue) and (iyred > iygreen)
	{
		;MsgBox red first
		MouseClick, left,  ixred+20, iyred-20
		if (iyred < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	MsgBox Found none, quitting
	return
}
; If at untranslated
ImageSearch,ix,iy,XstartTranslateboxStringbox,YstartTranslateboxStringbox,XendTranslateboxStringbox,YendTranslateboxStringbox,%A_ScriptDir%\pictures\redbottomcorner.bmp ; red corner
if ErrorLevel = 2 ; Red corner not found
{
	MsgBox Other error (probably filepath)
	return
}
If ErrorLevel = 1
{
	MsgBox could not find active string, exiting
	return
}
if ErrorLevel = 0
{
	;MsgBox found red corner
	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iygreen = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixgreen,iygreen,XstartTranslateboxStringbox,iygreen+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\greencolorcorner.bmp ; previous green
		;MsgBox %iygreen%
		If !iygreen
		{
			;MsgBox could not find green color corner
			iygreen=%tempy%
			ixgreen=%tempx%
		}
		if (iygreen > tempy)
		{
			tempy = %iygreen%
			tempx = %ixgreen%
		}
	}
	iygreen = %tempy%
	ixgreen = %tempx%

	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iyblue = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixblue,iyblue,XstartTranslateboxStringbox,iyblue+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\bluecolorcorner.bmp ; previous blue
		;MsgBox %iyblue%
		If !iyblue
		{
			;MsgBox could not find blue color corner
			iyblue=%tempy%
			ixblue=%tempx%
		}
		if (iyblue > tempy)
		{
			tempy = %iyblue%
			tempx = %ixblue%
		}
	}
	iyblue = %tempy%
	ixblue = %tempx%

	ErrorLevel = 0
	tempx = 0 ;store respective x
	tempy = 0 ;store largest found y
	iyred = %YstartTranslateboxStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixred,iyred,XstartTranslateboxStringbox,iyred+30,XendTranslateboxStringbox,iy-20,%A_ScriptDir%\pictures\redcolorcorner.bmp ; previous red
		;MsgBox %iyred%
		If !iyred
		{
			;MsgBox could not find red color corner
			iyred=%tempy%
			ixred=%tempx%
		}
		if (iyred > tempy)
		{
			tempy = %iyred%
			tempx = %ixred%
		}
	}
	iyred = %tempy%
	ixred = %tempx%

	;MsgBox green %iygreen% blue %iyblue% red %iyred%
	
	if (iygreen > iyblue) and (iygreen > iyred)
	{
		;MsgBox green first
		MouseClick, left,  ixgreen+20, iygreen-20
		if (iygreen < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyblue > iygreen) and (iyblue > iyred)
	{
		;MsgBox blue first
		MouseClick, left,  ixblue+20, iyblue-20
		if (iyblue < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	if (iyred > iyblue) and (iyred > iygreen)
	{
		;MsgBox red first
		MouseClick, left,  ixred+20, iyred-20
		if (iyred < YscrollupTreshold)
		{
			;MsgBox scroll
			MouseClick,WheelUp,,,scrollValue,0,D,R
		}
		MouseMove, XposStart, YposStart
		return
	}
	MsgBox Found none, quitting
	return
	return
}
return



