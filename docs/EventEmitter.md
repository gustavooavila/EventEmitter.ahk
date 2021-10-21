### Event: `'newListener'`

* `eventName` {string} The name of the event being listened for
* `listener` {Function} The event handler function

The `EventEmitter` instance will emit its own `'newListener'` event _before_
a listener is added to its internal array of listeners.

Listeners registered for the `'newListener'` event are passed the event
name and a reference to the listener being added.

### Event: `'removeListener'`

* `eventName` {string} The event name
* `listener` {Function} The event handler function

The `'removeListener'` event is emitted _after_ the `listener` is removed.

### `emitter.addListener(eventName, listener)`

* `eventName` {string}
* `listener` {Function}

Alias for `emitter.on(eventName, listener)`.

### `emitter.emit(eventName[, data])`

* `eventName` {string}
* `data` {any}
* Returns: {Number}

Synchronously calls each of the listeners registered for the event named
`eventName`, in the order they were registered, passing the supplied data
to each.

Returns the Number of listeners the event had, 0 if none.

### `emitter.eventNames()`

* Returns: {Array}

Returns an array listing the events for which the emitter has registered
listeners. The values in the array are strings.

### `emitter.listenerCount(eventName)`

* `eventName` {string} The name of the event being listened for
* Returns: {Number}

Returns the number of listeners listening to the event named `eventName`.

### `emitter.off(eventName, listener)`

* `eventName` {string}
* `listener` {Function}
* Returns: {EventEmitter}

Alias for [`emitter.removeListener()`][].

### `emitter.on(eventName, listener)`

* `eventName` {string} The name of the event.
* `listener` {Function} The callback function
* Returns: {EventEmitter}

Adds the `listener` function to the end of the listeners array for the
event named `eventName`. No checks are made to see if the `listener` has
already been added. Multiple calls passing the same combination of `eventName`
and `listener` will result in the `listener` being added, and called, multiple
times.

```
server := new EventEmitter()
server.on('connection', Func("connectionListener"))
connectionListener(){
   MsgBox someone connected!
}
```

Returns a reference to the `EventEmitter`, so that calls can be chained.

By default, event listeners are invoked in the order they are added. The
`emitter.prependListener()` method can be used as an alternative to add the
event listener to the beginning of the listeners array.

### `emitter.once(eventName, listener)`

* `eventName` {string} The name of the event.
* `listener` {Function} The callback function
* Returns: {EventEmitter}

Adds a **one-time** `listener` function for the event named `eventName`. The
next time `eventName` is triggered, this listener is removed and then invoked.

```
server := new EventEmitter()
server.once('connection', Func("connectionListener"))
connectionListener(){
   MsgBox Ah, we have our first user!
}
```

Returns a reference to the `EventEmitter`, so that calls can be chained.

By default, event listeners are invoked in the order they are added. The
`emitter.prependOnceListener()` method can be used as an alternative to add the
event listener to the beginning of the listeners array.

### `emitter.prependListener(eventName, listener)`

* `eventName` {string} The name of the event.
* `listener` {Function} The callback function
* Returns: {EventEmitter}

Adds the `listener` function to the _beginning_ of the listeners array for the
event named `eventName`. No checks are made to see if the `listener` has
already been added. Multiple calls passing the same combination of `eventName`
and `listener` will result in the `listener` being added, and called, multiple
times.

```
server := new EventEmitter()
server.prependListener('connection', Func("connectionListener"))
connectionListener(){
   MsgBox someone connected!
}
```

Returns a reference to the `EventEmitter`, so that calls can be chained.

### `emitter.prependOnceListener(eventName, listener)`

* `eventName` {string} The name of the event.
* `listener` {Function} The callback function
* Returns: {EventEmitter}

Adds a **one-time** `listener` function for the event named `eventName` to the
_beginning_ of the listeners array. The next time `eventName` is triggered, this
listener is removed, and then invoked.


```
server := new EventEmitter()
server.prependOnceListener('connection', Func("connectionListener"))
connectionListener(){
   MsgBox Ah, we have our first user!
}
```

Returns a reference to the `EventEmitter`, so that calls can be chained.

### `emitter.removeListener(eventName[, listener])`

* `eventName` {string}
* `listener` {Function}
* Returns: {EventEmitter}

Removes the specified `listener` from the listener array for the event named
`eventName`.

```
callback(stream){
  MsgBox someone connected!
};
callback := Func("callback")
server.on('connection', callback)
// ...
server.removeListener('connection', callback)
```

`removeListener()` will remove, all instances of a listener from the
listener array.

Returns a reference to the `EventEmitter`, so that calls can be chained.