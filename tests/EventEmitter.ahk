#Include ../EventEmitter.ahk
#Include libs/Yunit/Yunit.ahk
#Include libs/Yunit/Window.ahk

class TestSuite
{
    class initialization
    {
        __new()
        {
            this.emitter := new EventEmitter()
        }
        
        emitter_has_events_property()
        {
            Yunit.Assert(this.emitter.events, "EventEmitter 'events' doesn't exist")
            Yunit.Assert(IsObject(this.emitter.events), "EventEmitter 'events' isn't object")
        }
        
        emitter_has_propagate_property()
        {
            Yunit.Assert(this.emitter.propagate == True or this.emitter.propagate == False, "EventEmitter 'propagate' doesn't exist")
            Yunit.Assert(this.emitter.propagate == True, "EventEmitter 'propagate' doesn't starts as True")
        }
    }
    
    class event_register
    {
        __new()
        {
            this.emitter := new EventEmitter()
        }
        
        addListener()
        {
            this.emitter.addListener("event001", ObjBindMethod(Helper, "noop"))
            Yunit.Assert(Helper.IsArray(this.emitter.events["event001"]), "Event didn't get registered, has no Array")
            Yunit.Assert(IsObject(this.emitter.events["event001"][1]), "Event didn't get registered, is not an Object")
        }
        
        on()
        {
            this.emitter.on("event002", ObjBindMethod(Helper, "noop"))
            Yunit.Assert(Helper.IsArray(this.emitter.events["event002"]), "Event didn't get registered, has no Array")
            Yunit.Assert(IsObject(this.emitter.events["event002"][1]), "Event didn't get registered, is not an Object")
        }
        
        once()
        {
            this.emitter.once("event003", ObjBindMethod(Helper, "noop"))
            Yunit.Assert(Helper.IsArray(this.emitter.events["event003"]), "Event didn't get registered, has no Array")
            Yunit.Assert(IsObject(this.emitter.events["event003"][1]), "Event didn't get registered, is not an Object")
        }
        
        prependListener()
        {
            prependListener_noop := ObjBindMethod(Helper, "prependListener_noop")
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.prependListener("event004", prependListener_noop)
            
            Yunit.Assert(Helper.IsArray(this.emitter.events["event004"]), "Event didn't get registered, has no Array")
            Yunit.Assert(IsObject(this.emitter.events["event004"][1]), "Event didn't get registered, is not an Object")
            Yunit.Assert(this.emitter.events["event004"][1].listener == prependListener_noop, "First event is not the one registered with prepend, listener mismatch")
        }
        
        prependOnceListener()
        {
            prependListener_noop := ObjBindMethod(Helper, "prependListener_noop")
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.prependOnceListener("event004", prependListener_noop)
            
            Yunit.Assert(Helper.IsArray(this.emitter.events["event004"]), "Event didn't get registered, has no Array")
            Yunit.Assert(IsObject(this.emitter.events["event004"][1]), "Event didn't get registered, is not an Object")
            Yunit.Assert(this.emitter.events["event004"][1].listener == prependListener_noop, "First event is not the one registered with prepend, listener mismatch")
        }
    }
    
    class emit_events {
        __new()
        {
            this.emitter := new EventEmitter()
        }
        
        event_was_emitted_without_data()
        {
            this.helper := new Helper()
            this.emitter.on("event001", objBindMethod(this.helper, "event_listener_without_data"))
            this.emitter.emit("event001")
            Yunit.Assert(this.helper.event_was_emitted_without_data, "event was not emitted / listener was not called")
        }
        
        event_was_emitted_with_data()
        {
            this.helper := new Helper()
            this.emitter.on("event002", objBindMethod(this.helper, "event_listener_with_data"))
            this.emitter.emit("event002", "test")
            Yunit.Assert(this.helper.event_was_emitted_with_data, "event was not emitted / listener was not called / no data was sent with event")
        }
        
        once_listener()
        {
            this.helper := new Helper()
            this.emitter.once("event001", objBindMethod(this.helper, "once_listener"))
            this.emitter.emit("event001")
            this.emitter.emit("event001")
            this.emitter.emit("event001")
            Yunit.Assert(this.helper.once_event_listener_call_count, "event was not emitted / listener was not called")
            Yunit.Assert(this.helper.once_event_listener_call_count == 1, "listener was called more than once")
        }
    }
    
    class event_remove
    {
        __new()
        {
            this.emitter := new EventEmitter()
            this.noop := ObjBindMethod(Helper, "noop")
        }
        
        remove_event_with_listener()
        {
            this.emitter.addListener("event001", this.noop)
            this.emitter.removeListener("event001", this.noop)
            
            Yunit.Assert(!this.emitter.events["event001"], "Event still has Array")
        }
        
        remove_event_without_listener()
        {
            this.emitter.addListener("event002", this.noop)
            this.emitter.addListener("event002", this.noop)
            this.emitter.addListener("event002", this.noop)
            this.emitter.removeListener("event002")
            
            Yunit.Assert(!this.emitter.events["event002"], "Event still has Array")
        }
        
        off_with_listener()
        {
            this.emitter.addListener("event003", this.noop)
            this.emitter.off("event003", this.noop)
            
            Yunit.Assert(!this.emitter.events["event003"], "Event still has Array")
            
        }
        
        off_without_listener()
        {
            this.emitter.addListener("event004", this.noop)
            this.emitter.addListener("event004", this.noop)
            this.emitter.addListener("event004", this.noop)
            this.emitter.off("event004")
            
            Yunit.Assert(!this.emitter.events["event004"], "Event still has Array")
        }
    }
    
    class remove_and_new_listener_events
    {
        __new()
        {
            this.emitter := new EventEmitter()
        }
        
        newListener_event()
        {
            this.helper := new Helper()
            this.emitter.on("newListener", objBindMethod(this.helper, "newListener_event_listener"))
            this.emitter.on("event002", ObjBindMethod(Helper, "noop"))
            Yunit.Assert(this.helper.newListener_event_listener_was_called, "'newListener' event was not emitted / 'newListener' listener was not called")
        }
        
        removeListener_event()
        {
            this.helper := new Helper()
            this.emitter.addListener("event005", this.noop)
            this.emitter.on("removeListener", objBindMethod(this.helper, "removeListener_event_listener"))
            this.emitter.removeListener("event005", this.noop)
            
            Yunit.Assert(this.helper.removeListener_event_listener_was_called, "'removeListener' event was not emitted / 'removeListener' listener was not called")
        } 
    }
    
    class extras
    {
        __new()
        {
            this.emitter := new EventEmitter()
        }
        
        eventNames()
        {
            this.emitter.addListener("event003", this.noop)
            this.emitter.addListener("event002", this.noop)
            this.emitter.addListener("event006", this.noop)
            eventNames := this.emitter.eventNames()
            
            Yunit.Assert("event003" in %eventNames%, "event003 was not registered")
            Yunit.Assert("event002" in %eventNames%, "event002 was not registered")
            Yunit.Assert("event006" in %eventNames%, "event006 was not registered")
        }
        
        listenerCount()
        {
            this.emitter.addListener("event004", this.noop)
            this.emitter.addListener("event004", this.noop)
            this.emitter.addListener("event004", this.noop)
            listenerCount := this.emitter.listenerCount("event004")
            
            Yunit.Assert(listenerCount = 3, "'listenerCount' has returned the wrong number")
        }
    }
    
    class Event
    {
        __new()
        {
            this.emitter := new EventEmitter()
        }
        
        stop_propagation()
        {
            this.helper := new Helper()
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.addListener("event004", ObjBindMethod(Helper, "noop"))
            this.emitter.prependListener("event004", objBindMethod(this.helper, "stopPropagation"))
            this.emitter.addListener("event004", objBindMethod(this.helper, "checkStopPropagation"))
            this.emitter.emit("event004")
            
            Yunit.Assert(this.helper.did_stop_propagation, "propagation was not stopped")
        }
    }
}

class Helper
{
    event_was_emitted_without_data := False
    event_was_emitted_with := False
    did_stop_propagation := True
    once_event_listener_call_count := 0
    newListener_event_listener_was_called := False
    removeListener_event_listener_was_called := False
    
    noop()
    {
        return
    }
    
    prependListener_noop()
    {
    return
    }
    
    event_listener_without_data()
    {
        this.event_was_emitted_without_data := True
    }
    
    event_listener_with_data(event)
    {
        if(event.data)
        {
            this.event_was_emitted_with_data := True
        }
    }
    
    once_listener()
    {
        this.once_event_listener_call_count += 1
    }
    
    stopPropagation(ByRef event)
    {
        event.stopPropagation()
    }
    
    checkStopPropagation()
    {
        this.did_stop_propagation := False
    }
    
    newListener_event_listener()
    {
        this.newListener_event_listener_was_called := True
    }
    
    removeListener_event_listener()
    {
        this.removeListener_event_listener_was_called := True
    }
    
    IsArray(p)
    {
        if IsObject(p)
        {
            c := p.clone()
            c.Remove(c.MinIndex(),c.MaxIndex())
            return, Not c.NewEnum().Next()
        }
    }
}


Tester := Yunit.Use(YunitWindow)
Tester.Test(TestSuite)