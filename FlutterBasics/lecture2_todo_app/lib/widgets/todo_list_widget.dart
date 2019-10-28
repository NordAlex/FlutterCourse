import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey =  GlobalKey<ScaffoldState>();

  final _appName = 'TO DO APP';
  final _itemRemovedText = 'Item is completed. Well done!';
  final _addItemText ='Write new action todo';
  final _cancelText = 'Cancel';
  final _okText = 'Ok';

  List<String> items = [
    'Complete flutter homework',
    'Fix all bugs',
    'Enslave the world',
    'Date with a girl',
    'Eat helthy food'
  ];

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Column(children: <Widget>[
            ListTile(
              title: Text(items[index]),
              trailing: IconButton(
                icon: const Icon(Icons.done),
                onPressed: () => _removeItex(index),
              ),
            ),
            Divider()
          ]);
        });
  }

  void _removeItex(int index) {
    setState(() {
      items.removeAt(index);
    });
    _showSnackBar();
  }

void _showSnackBar() {
    final snackBarContent = SnackBar(
      content: Text(_itemRemovedText),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  void _addNewItem(BuildContext context) {
    showDialog<AlertDialog>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(_addItemText),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: 'Todo action'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(_cancelText),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(_okText),
                onPressed: () {
                  setState(() {
                    if (_textFieldController.text.isNotEmpty) {
                      items.add(_textFieldController.text);
                      _textFieldController.clear();
                    }
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
        appBar: AppBar(title: Text(_appName)),
        body: _buildList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addNewItem(context),
          tooltip: _okText,
          child: const Icon(Icons.add),
        ));
  }
}
