import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget
{

  const DetailsPage({
    Key key, @required this.imageUrl
    }) : assert(imageUrl != null),
    super(key: key);

final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(title: const Text('Details page'),),
          body: Image.network(imageUrl, fit: BoxFit.fill,)
    );
  }
  
}