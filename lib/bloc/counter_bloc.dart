import 'dart:async';
import 'counter_event.dart';

///A Business Logic Component is basically
///a box where events come in from one side
///and the state comes out from the other side.
///
///The basic concept is that events go in and
///state goes out and the block just operates
///on these events to figure out which state
///it should output.
///
///
/// Events    +--------------+    State
///---------> |     BLOC     | ---------->
///           +--------------+
///
///
///We have two different events: one for incrementing
///the counter and the inner one for decrementing the
///counter.
class CounterBloc {
  int _counter = 0;

  ///We can think of the streamController as a
  ///box which has two holes:
  /// - One for input data -> Also called sink
  /// - Another for output data -> Also called stream.
  ///
  /// Whenever there is some input to the sink it's
  /// going to be automatically output it through
  /// the stream.
  final _counterStateController = StreamController<int>();

  ///We want to put numbers in this counter sink and
  ///those same numbers are going to come out from
  ///the stream.
  StreamSink<int> get _inCounter => _counterStateController.sink;

  ///So we are making only the stream which outputs
  ///data public because we only want our widgets to
  ///be listening to the output of the counter state
  ///controller
  Stream<int> get counter => _counterStateController.stream;

  ///At this point we are already listen to the
  ///value of the counter through this counter
  ///stream but we also need to have a way for
  ///our UI to input the events for decrementing
  ///or incrementing the counter so we are going to
  ///create another stream controller but this
  ///one will only expose a sink.
  final _counterEventController = StreamController<CounterEvent>();

  ///Our UI will put increment event or decrement event
  ///into this sink.
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  ///The next step is tho listen to the counter
  ///EVENT controller expecting to new incoming
  ///changes, then notify to our counter STATE
  ///controller to expose those changes through
  ///our stream.

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;
    //counter.listen(onData)
    _inCounter.add(_counter);
  }

  ///This dispose function is truly important
  ///because it close the streams. which helps
  ///to control memory leaks
  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
