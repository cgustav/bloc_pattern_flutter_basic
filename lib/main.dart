import 'package:flutter/material.dart';
import 'package:bloc_simple_example/bloc/counter_bloc.dart';
import 'package:bloc_simple_example/bloc/counter_event.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final _bloc = CounterBloc();
  CounterBloc _counterBloc = new CounterBloc(initialCount: 0);

  @override
  void dispose() {
    super.dispose();
    _counterBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: StreamBuilder(
                stream: _counterBloc.counterObservable,
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('You have pushed the button this many times:'),
                      Text(
                        '${snapshot.data}',
                        style: Theme.of(context).textTheme.display1,
                      )
                    ],
                  );
                })),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => _counterBloc.increment(),
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
            SizedBox(
              width: 20.0,
            ),
            FloatingActionButton(
              onPressed: () => _counterBloc.decrement(),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ],
        ));
  }
}
