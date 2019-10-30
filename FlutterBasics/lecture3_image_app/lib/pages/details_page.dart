import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget
{
const DetailsPage(this.url);

final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(title: const Text('Oh shit here we go again'),),
          body: Image.network(url, fit: BoxFit.fill,)
    );
  }
  
}