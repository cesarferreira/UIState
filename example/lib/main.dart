import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uistate/uistate.dart';
import 'package:uistate_example/username_repository.dart';
import 'package:uistate_example/viewmodel.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ViewModel>.value(value: ViewModel(UsernameRepository())),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI State example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    UIState<String> state = Provider.of<ViewModel>(context).state;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: state.when(
            success: (event) => successWidget(event.value),
            failure: (event) => failureWidget(event.errorMessage),
            loading: (event) => CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ViewModel>(context, listen: false).fetchUser();
        },
        tooltip: 'Increment',
        child: Icon(Icons.adjust_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  final style = const TextStyle(fontSize: 30, color: Colors.white);

  successWidget(String string) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.green,
      child: Text(string, style: style),
    );
  }

  failureWidget(String string) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.red,
      child: Text(string, style: style),
    );
  }
}
