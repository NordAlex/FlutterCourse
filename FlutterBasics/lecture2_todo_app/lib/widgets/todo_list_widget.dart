import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final _appName = 'TO DO APP';
  final _itemRemovedText = 'Item is completed. Well done!';
  final _addItemText = 'Write new action todo';
  final _addItemHintText = 'Todo action';
  final _cancelText = 'Cancel';
  final _okText = 'Ok';

  final items = [
    'Complete flutter homework',
    'Fix all bugs',
    'Enslave the world',
    'Date with a girl',
    'Eat helthy food'
  ];

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

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return _buildRow(index);
        });
  }

  Widget _buildRow(int index) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(
          items[index],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.done,
            color: Colors.blue,
            size: 35,
          ),
          onPressed: () => _removeItem(index),
        ),
      ),
      Divider()
    ]);
  }

  void _removeItem(int index) {
    setState(() => items.removeAt(index));
    _showSnackBar();
  }

  void _addNewItem(BuildContext context) {
    showDialog<AlertDialog>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(_addItemText),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: _addItemHintText),
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

  void _showSnackBar() {
    final snackBarContent = SnackBar(
      content: Text(_itemRemovedText),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }
}
