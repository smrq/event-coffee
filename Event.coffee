#------------------------------------------------------------------------------
# Event
#------------------------------------------------------------------------------
# Defines an event which can be registered to.
# The event object is a function that notifies all of its listeners
# when it is called.
#
# The event object may optionally be constructed with a function that defines
# how to combine results from multiple listeners into a single result.
#
# Examples:
#
# event = new Event()
# callback = (x) -> x-5
# anotherCallback = (x) -> x+5
#
# event.register callback
# event(5)
#	---> Returns [0]
# event.register anotherCallback
# event(5)
#	---> Returns [0, 10]
# event.unregister callback
# event(5)
#	---> Returns [10]
#
# sum = (array) -> _.reduce array, ((total, x) -> total+x, 0
# event2 = new Event(sum)
#
# event2(100)
#	---> Returns 0
# event2.register callback
# event2(100)
#	---> Returns 95
# event2.register anotherCallback
# event2(100)
#	---> Returns 200

define ->
	Event = (fn = ((x) -> x)) ->
		listeners = []
		Event = -> fn(listener(arguments...) for listener in listeners)
		Event.register = (listener) ->
			listeners.push(listener)
			return
		Event.unregister = (listener) ->
			listeners.splice(listeners.indexOf(listener), 1) if listener in listeners
			return
		Event