import 'dart:math';

import 'package:flutter/material.dart';

import 'details_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _title = 'Time to check my memes collection';

  final _imageUrls = [
    'https://pbs.twimg.com/media/EIC15VJWwAAl7FN.jpg',
    'https://pbs.twimg.com/media/EHemudoXYAEt395.jpg',
    'https://pbs.twimg.com/media/EHE04ijX4AAL2r-.jpg',
    'https://pbs.twimg.com/media/EG6h_DIX4AEdECd.jpg',
    'https://pbs.twimg.com/media/EGl5Nt8WsAAvJVQ.jpg',
    'https://pbs.twimg.com/media/EF3mHcpWkAI4NQl.jpg',
    'https://pbs.twimg.com/media/EFeviScU4AEp8a7.jpg',
    'https://cdn57.androidauthority.net/wp-content/uploads/2016/05/other-meme.jpg',
    'https://i.imgur.com/JU32rCy.png',
    'https://pics.me.me/me-tries-to-quickly-make-a-prototype-xamarin-designer-project-55835906.png',
    'https://img.devrant.com/devrant/rant/r_1800770_WJ4Gx.jpg',
    'https://img.devrant.com/devrant/rant/r_1101213_ygP3V.jpg',
    'https://pics.me.me/when-you-have-to-download-the-latest-android-sdk-atwodudessinapool-18650401.png',
    'https://66.media.tumblr.com/tumblr_mdt31qPEjp1qkr5g0.jpg',
    'https://pics.me.me/decided-toteachmyself-cross-platformlapp-development-aannndddidont-have-amac-imgflip-com-xcode-21756363.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: _buidGridView(),
        floatingActionButton: FloatingActionButton(child: const Icon(Icons.publish), onPressed: () {
          _addNewItem();
        }),);     
  }

  Widget _buidGridView() {
    return GridView.builder(
    
    itemCount: _imageUrls.length,
    gridDelegate:
       SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 2),
    itemBuilder: (BuildContext context, int index) => _buildGridCell(index));
  }

  Widget _buildGridCell(int index) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Ink.image(
            image: Image.network(
              _imageUrls[index],
            ).image,
            fit: BoxFit.cover,
            child:
                InkWell(onTap: () => _navigateDetailsPage(_imageUrls[index]))));
  }

  void _navigateDetailsPage(String url) {
    Navigator.push<DetailsPage>(
        context, MaterialPageRoute(builder: (context) => DetailsPage(imageUrl: url)));
  }

  void _addNewItem(){
    final itemNumber = _generateRandom(_imageUrls.length);
    final newImage = _imageUrls[itemNumber];
    setState(() => _imageUrls.add(newImage));
  }

 int _generateRandom(int maxNumber) {
  final generator = Random();
  return generator.nextInt(maxNumber);
}
}
