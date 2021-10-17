#Include ../EventEmitter.ahk
#Include libs/Yunit/Yunit.ahk
#Include libs/Yunit/Window.ahk
#Include Helper.ahk
#Include EventEmitter.ahk
#Include Event.ahk

Tester := Yunit.Use(YunitWindow)
Tester.Test(EventEmitter_Test_Suite, Event_Test_Suite)