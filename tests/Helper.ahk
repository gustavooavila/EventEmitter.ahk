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
