#Include %A_ScriptDir%
#Include ../EventEmitter.ahk
#Include ./lib/Yunit/Yunit.ahk
#Include ./lib/Yunit/JUnit.ahk
#Include ./Helper.ahk
#Include ./EventEmitter.ahk
#Include ./Event.ahk

Tester := Yunit.Use(YunitJUnit)
Tester.Test(EventEmitter_Test_Suite, Event_Test_Suite)
