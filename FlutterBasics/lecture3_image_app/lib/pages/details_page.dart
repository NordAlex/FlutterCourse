import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget
{

  DetailsPage({
    Key key, @required this.imageUrl
    }) : assert(imageUrl != null),
    super(key: key);

final _title = 'Details page';
final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(title: Text(_title),),
          body: Image.network(imageUrl, fit: BoxFit.fill,)
    );
  }
  
}