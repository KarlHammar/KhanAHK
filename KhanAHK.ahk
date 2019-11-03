;global coordMode
coordMode,pixel
;Faster clicks
setmousedelay -1 ;This is gold :DD
;Translatebox (right window) coords
XstartTranslatebox=1800
XendTranslatebox=2160
YstartTranslatebox=300
YendTranslatebox=1400
;Stringbox (Left window) coords
XstartStringbox=0
XendStringbox=1000
YstartStringbox=200
YendStringbox=1400
;when to scroll
YscrolldownTreshold = 1000
YscrollupTreshold = 620
;how much to scroll
scrollValue = 3

;TODO
;functionalize

/* (for testing search boxes)
!t::
coordMode,pixel
MouseMove, XstartStringbox, YstartStringbox
sleep, 2000 ;(wait 2 seconds)
MouseMove, XendStringbox, YstartStringbox
sleep, 2000 ;(wait 2 seconds)
MouseMove, XendStringbox, YendStringbox
sleep, 2000 ;(wait 2 seconds)
MouseMove, XstartStringbox, YendStringbox
sleep, 2000 ;(wait 2 seconds)
*/

;Upvote top string
Alt::
MouseGetPos, XposStart, YposStart
ImageSearch,ix,iy,XstartTranslatebox,YstartTranslatebox,XendTranslatebox,YendTranslatebox,%A_ScriptDir%\pictures\alreadyliked.bmp
if ErrorLevel = 2 ; If already upvoted, do not upvote next string
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
{
	ImageSearch,ix,iy,XstartTranslatebox,YstartTranslatebox,XendTranslatebox,YendTranslatebox,%A_ScriptDir%\pictures\upvote.bmp
	MsgBox %ErrorLevel%
	MouseClick, left,  ix+20, iy+20
	MouseMove, XposStart, YposStart
}
return

;Downvote top string
!-::
MouseGetPos, XposStart, YposStart
ImageSearch,ix,iy,XstartTranslatebox,YstartTranslatebox,XendTranslatebox,YendTranslatebox,%A_ScriptDir%\pictures\alreadydisliked.bmp
if ErrorLevel = 2 ; If already upvoted, do not upvote next string
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
{
	ImageSearch,ix,iy,XstartTranslatebox,YstartTranslatebox,XendTranslatebox,YendTranslatebox,%A_ScriptDir%\pictures\downvote.bmp
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
;MsgBox %ix2% and %iy2%
MouseClick, left,  ix2+40, iy2+40
MouseMove, XposStart, YposStart
return


;Next string
!n::
MouseGetPos, XposStart, YposStart
; If at approved
ImageSearch,ix,iy,XstartStringbox,YstartStringbox,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\greenbottomcorner.bmp ; green corner
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
	ImageSearch,ixgreen,iygreen,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\greencolor.bmp ; next green
	If ErrorLevel = 1
	{
		;MsgBox could not find green color
		iygreen = 10000
	}
	ImageSearch,ixblue,iyblue,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\bluecolor.bmp ; next blue
	If ErrorLevel = 1
	{
		;MsgBox could not find blue color
		iyblue = 10000
	}
	ImageSearch,ixred,iyred,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\redcolor.bmp ; next red
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
ImageSearch,ix,iy,XstartStringbox,YstartStringbox,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\bluebottomcorner.bmp ; blue corner
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
	ImageSearch,ixgreen,iygreen,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\greencolor.bmp ; next green
	If ErrorLevel = 1
	{
		;MsgBox could not find green color
		iygreen = 10000
	}
	ImageSearch,ixblue,iyblue,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\bluecolor.bmp ; next blue
	If ErrorLevel = 1
	{
		;MsgBox could not find blue color
		iyblue = 10000
	}
	ImageSearch,ixred,iyred,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\redcolor.bmp ; next red
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
ImageSearch,ix,iy,XstartStringbox,YstartStringbox,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\redbottomcorner.bmp ; red corner
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
	ImageSearch,ixgreen,iygreen,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\greencolor.bmp ; next green
	If ErrorLevel = 1
	{
		;MsgBox could not find green color
		iygreen = 10000
	}
	ImageSearch,ixblue,iyblue,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\bluecolor.bmp ; next blue
	If ErrorLevel = 1
	{
		;MsgBox could not find blue color
		iyblue = 10000
	}
	ImageSearch,ixred,iyred,XstartStringbox,iy+20,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\redcolor.bmp ; next red
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
ImageSearch,ix,iy,XstartStringbox,YstartStringbox,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\greentopcorner.bmp ; green corner
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
	iygreen = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixgreen,iygreen,XstartStringbox,iygreen+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\greencolorcorner.bmp ; previous green
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
	iyblue = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixblue,iyblue,XstartStringbox,iyblue+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\bluecolorcorner.bmp ; previous blue
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
	iyred = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixred,iyred,XstartStringbox,iyred+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\redcolorcorner.bmp ; previous red
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
ImageSearch,ix,iy,XstartStringbox,YstartStringbox,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\bluebottomcorner.bmp ; blue corner
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
	iygreen = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixgreen,iygreen,XstartStringbox,iygreen+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\greencolorcorner.bmp ; previous green
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
	iyblue = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixblue,iyblue,XstartStringbox,iyblue+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\bluecolorcorner.bmp ; previous blue
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
	iyred = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixred,iyred,XstartStringbox,iyred+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\redcolorcorner.bmp ; previous red
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
ImageSearch,ix,iy,XstartStringbox,YstartStringbox,XendStringbox,YendStringbox,%A_ScriptDir%\pictures\redbottomcorner.bmp ; red corner
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
	iygreen = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixgreen,iygreen,XstartStringbox,iygreen+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\greencolorcorner.bmp ; previous green
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
	iyblue = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixblue,iyblue,XstartStringbox,iyblue+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\bluecolorcorner.bmp ; previous blue
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
	iyred = %YstartStringbox%
	while (ErrorLevel = 0)
	{
		ImageSearch,ixred,iyred,XstartStringbox,iyred+30,XendStringbox,iy-20,%A_ScriptDir%\pictures\redcolorcorner.bmp ; previous red
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



