///This counter event is the base class
///from which all of the subsequent
///increment events and decrement events
///will inherit.
///
///That takes us to the increment
///event which would look basically like a class
///that just extends the counter event and then
///we also want to have decrement event.
///
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}
