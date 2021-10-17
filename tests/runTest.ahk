#Include %A_ScriptDir%

#Include ../EventEmitter.ahk

#Include ./Helper.ahk
#Include ./EventEmitter.ahk
#Include ./Event.ahk

#Include ./lib/Yunit/Yunit.ahk
#Include ./lib/Yunit/Window.ahk


Tester := Yunit.Use(YunitWindow)
Tester.Test(EventEmitter_Test_Suite, Event_Test_Suite)