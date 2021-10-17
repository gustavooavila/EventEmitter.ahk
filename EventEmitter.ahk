class Event
{
    keepPropagation := True
    __new(ByRef emitter, ByRef data)
    {
        this.target := emitter
        this.data := data
    }
    
    stopPropagation()
    {
        this.keepPropagation := False
    }
}

class EventEmitter
{
    events := {}
    propagate := True
    _addListener(eventName, ByRef listener, atStart := 0, once := 0)
    {
        this.emit("newListener", {eventName: eventName, listener: listener})
        
        if(!this.events[eventName])
        {
            this.events[eventName] := []
        }
        
        if(atStart)
        {
            this.events[eventName].InsertAt(1, {listener: listener, once: once})
        }
        else
        {
            this.events[eventName].Push({listener: listener, once: once})
        }
        return this
    }
    
    removeListener(eventName, ByRef listener := "")
    {
        if(this.events[eventName])
        {
            if(listener)
            {
                For i, eventListener in this.events[eventName]
                {
                    if(eventListener.listener == listener)
                    {
                        this.events[eventName].RemoveAt(i)
                    }
                }
            }
            else
            {
                ; if no listener was especified, delete all listeners for 'eventName' event
                iListeners := this.events[eventName].Length()
                removed := this.events[eventName].RemoveAt(1, iListeners)
            }
            
            
            ; if there's no listener for 'eventName' event, delete 'eventName' events property/key
            iListeners := this.events[eventName].Length()
            if(iListeners = 0)
            {
                this.events.Delete(eventName)
            }
            
            this.emit("removeListener", {eventName: eventName, listener: listener})
        }
    }
    
    emit(eventName, ByRef data := "")
    {
        if(this.events[eventName])
        {
            iListeners := this.events[eventName].Length()
            if(iListeners)
            {
                e := new Event(this, data)
                For i, eventListener in this.events[eventName]
                {
                    eventListener.listener.Call(e)
                    if(eventListener.once)
                    {
                        this.events[eventName].RemoveAt(i)
                    }
                    this.propagate := e.keepPropagation
                    if(!this.propagate)
                    {
                        this.propagate := True
                        break
                    }
                }
                return iListeners
            }
        }
        if(eventName == "error"){
            Throw data
        }
        return 0
    }
    
    
    prependOnceListener(event, ByRef listener)
    {
        return this._addListener(event, listener, 1, 1)
    }
    
    prependListener(event, ByRef listener)
    {
        return this._addListener(event, listener, 1, 0)
    }
    
    addListener(event, ByRef listener)
    {
        return this._addListener(event, listener, 0, 0)
    }
    
    once(event, ByRef listener)
    {
        return this._addListener(event, listener, 0, 1)
    }
    
    listenerCount(eventName)
    {
        return this.events[eventName].Length()
    }
    
    eventNames()
    {
        eventNames := []
        For eventName, _ in this.events
        {
            eventNames.Push(eventName)
        }
        return eventNames
    }
    
    on(event, ByRef listener)
    {
        return this._addListener(event, listener, 0 ,0)
    }
    
    off(event, ByRef listener := "")
    {
        this.removeListener(event, listener)
        
    }
}