import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('App without bug'),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.search)),
          ]),
        ),
        body: TabBarView(children: [
          ListView(
            key: const PageStorageKey<String>('first_page'),
            children: List<Widget>.generate(
                300,
                    (i) => ListTile(
                  title: Text('Item $i'),
                )),
          ),
          ListView(
            key: const PageStorageKey<String>('second_page'),
            children: List<Widget>.generate(
                300,
                    (i) => ListTile(
                  title: Text('Item ${i * i}'),
                )),
          ),
        ]),
      ),
    );
  }
}