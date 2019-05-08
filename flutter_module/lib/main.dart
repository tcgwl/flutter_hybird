import 'package:flutter/material.dart';
import 'dart:ui'; // 要使用window对象必须引入

// 拿到从Android Native项目中传入的json类型的数据后,序列化成Dart obj,就可以做任何事情了
void main() => runApp(MyApp(initParams: window.defaultRouteName));

class MyApp extends StatelessWidget {
  final String initParams;

  const MyApp({Key key, this.initParams}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 混合开发',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter 混合开发', initParams: initParams),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.initParams}) : super(key: key);

  final String title;
  final String initParams;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'dataFromNative:${widget.initParams}',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
