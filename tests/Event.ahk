class Event_Test_Suite
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
