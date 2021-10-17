# Introduction

Instances of the EventEmitter class expose an `eventEmitter.on()` function that allows one or more functions to be attached to named events emitted by the object.

When the `EventEmitter` object emits an event, all of the functions attached to that specific event are called synchronously. Any values returned by the called listeners are ignored and discarded.

The following example shows a simple EventEmitter instance with a single listener. The `eventEmitter.on()` method is used to register listeners, while the `eventEmitter.emit()` method is used to trigger the event.
```
#Include EventEmitter.ahk

class MyEmitter extends EventEmitter
{}

myEmitter := new MyEmitter()
myEmitter.on("event", Func("MyListener"))
myEmitter.emit("event")

MyListener()
{
    MsgBox, an event occurred!
}
```

## Passing data to listeners

The `eventEmitter.emit()` method allows `anything` to be passed to the listener functions.

Objects:
```
#Include EventEmitter.ahk

class MyEmitter extends EventEmitter
{}

myEmitter := new MyEmitter()
myEmitter.on("greet", Func("MyListener"))
myEmitter.emit("greet", {name: "User0123"})

MyListener(event)
{
    name := event.data.name
    MsgBox, welcome %name%
}
```
Arrays:
```
#Include EventEmitter.ahk

class MyEmitter extends EventEmitter
{}

myEmitter := new MyEmitter()
myEmitter.on("event", Func("MyListener"))
myEmitter.emit("event", ["a", "b"])

MyListener(event)
{
    MsgBox % "event passed: " . event.data[1] . " , " . event.data[2]
}
```
Class instances:
```
#Include EventEmitter.ahk

class MyEmitter extends EventEmitter
{}

class Person
{
    __new(name)
    {
        this.name := name
    }
}

myEmitter := new MyEmitter()
myEmitter.on("event", Func("MyListener"))
myEmitter.emit("event", new Person("User0123"))

MyListener(event)
{
    person := event.data
    MsgBox % "welcome " . person.name 
}
```
You name it ...

## Handling events only once
When a listener is registered using the `eventEmitter.on()` method, that listener is invoked every time the named event is emitted.
```
#Include EventEmitter.ahk

class MyEmitter extends EventEmitter
{}

myEmitter := new MyEmitter()
myEmitter.on("event", Func("MyListener"))
myEmitter.emit("event", "test1")
myEmitter.emit("event", "test2")

MyListener(event)
{
    MsgBox % event.data
}
```
Using the `eventEmitter.once()` method, it is possible to register a listener that is called at most once for a particular event. Once the event is emitted, the listener is unregistered and then called.
```
#Include EventEmitter.ahk

class MyEmitter extends EventEmitter
{}

myEmitter := new MyEmitter()
myEmitter.once("event", Func("MyListener"))
myEmitter.emit("event", "test1")
myEmitter.emit("event", "test2")

MyListener(event)
{
    MsgBox % event.data
}
```

## Error events
When an error occurs within an `EventEmitter` instance, the typical action is for an `'error'` event to be emitted. These are treated as special cases.

If an `EventEmitter` does not have at least one listener registered for the `'error'` event, and an `'error'` event is emitted, the error is thrown, and the process exits.
```
#Include EventEmitter.ahk

class MyEmitter extends EventEmitter
{}

myEmitter := new MyEmitter()
myEmitter.emit("error", "whoops!")
; Throws and crashes
```