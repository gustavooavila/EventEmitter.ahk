#Include ../EventEmitter.ahk
#Include libs/Yunit/Yunit.ahk
#Include libs/Yunit/JUnit.ahk
#Include Helper.ahk
#Include EventEmitter.ahk
#Include Event.ahk

Tester := Yunit.Use(YunitJUnit)
Tester.Test(EventEmitter_Test_Suite, Event_Test_Suite)