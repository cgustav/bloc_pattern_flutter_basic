///About RxDart
///
///Dart Programming Language already have stream
///functionality and RxDart just extends that
///concept and provides new abstractions which
///slightly improve whats already available in
///the language
///
///RxDart Provides two essential abstractions:
/// - Observable
/// - Subjects
///
///
/// Observable is like a stream. Except it adds
/// methods and a few other features. So whenever
/// we are talking about streams we can replace this
/// notion with observable and it mean basically the
/// same thing.
///
/// Subjects are the StreamController of Rx and as you
/// can imagine RxDart implements them using a StreamController
/// under the hood.
///
/// - You can listen() directly on a Subject without accessing
///   a Stream property.
///
/// - More than just one subscription is possible and all
///   listening parties will get the same data at the same time.
///
/// - There are three flavours of Subjects that are best explained
///   with examples:
///     - PublishSubjects: They behave like StreamControllers besides
///       that multiple listeners are allowed:
///

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

  ///Instead of publishing the whole StreamController, we just publish
  ///its Stream property.
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
