import 'package:rxdart/rxdart.dart';

///This is the class which imports the rxDart library

class CounterBloc {
  ///In this case we need to receive the initialCount
  ///that allow us to know from which number our counter
  ///should begin.
  ///
  ///when the Widget become a listener of the Subject
  ///the first value passed through the stream will be the
  ///initialCount which was set in the CounterBloc constructor.
  ///
  int initialCount = 0;
  BehaviorSubject<int> _subjectCounter;

  CounterBloc({this.initialCount}) {
    ///initializes the subject with element already
    _subjectCounter = BehaviorSubject<int>.seeded(this.initialCount);
  }

  ///Return an Observable of the Subject, in other words, the object which will
  ///be used to notify the Widgets when changes happen in the Stream.
  Observable<int> get counterObservable => _subjectCounter.stream;

  /// Increment the initialCount and send to the Subject listeners
  /// by Sink the new value.
  void increment() {
    initialCount++;
    _subjectCounter.sink.add(initialCount);
  }

  /// Decrement the initialCount and send to the Subject listeners
  /// by Sink the new value.
  void decrement() {
    initialCount--;
    _subjectCounter.sink.add(initialCount);
  }

  ///close the opened subject.
  void dispose() {
    _subjectCounter.close();
  }
}
