import 'package:flutter/material.dart';

import 'details_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _appText = 'This is time to check my memes collection';

  final imageUrls =
  [
      'https://pbs.twimg.com/media/EIC15VJWwAAl7FN.jpg',
      'https://pbs.twimg.com/media/EHemudoXYAEt395.jpg',
      'https://pbs.twimg.com/media/EHE04ijX4AAL2r-.jpg',
      'https://pbs.twimg.com/media/EG6h_DIX4AEdECd.jpg',
      'https://pbs.twimg.com/media/EGl5Nt8WsAAvJVQ.jpg',
      'https://pbs.twimg.com/media/EF3mHcpWkAI4NQl.jpg',
      'https://pbs.twimg.com/media/EFeviScU4AEp8a7.jpg',
      'https://cdn57.androidauthority.net/wp-content/uploads/2016/05/other-meme.jpg',
      'https://i.imgur.com/JU32rCy.png',
      'https://img.devrant.com/devrant/rant/r_1101213_ygP3V.jpg',
      'https://pics.me.me/when-you-have-to-download-the-latest-android-sdk-atwodudessinapool-18650401.png',
      'https://66.media.tumblr.com/tumblr_mdt31qPEjp1qkr5g0.jpg',
      'https://pics.me.me/decided-toteachmyself-cross-platformlapp-development-aannndddidont-have-amac-imgflip-com-xcode-21756363.png',

  ];
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_appText),
        ),
        body: _buidGridView());
  }

  GridView _buidGridView()
  {
    return GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(8),
            children: List.generate(imageUrls.length, (index) {
              return 
              Container(
                padding: const EdgeInsets.all(8),
                child:Ink.image(
                  image: Image.network(
                    imageUrls[index],
                  ).image,
                  fit: BoxFit.cover,
                  child: InkWell(onTap: () {
                    _navigateDetailsPage(imageUrls[index]);
                  })));
            }));
  }

  void _navigateDetailsPage(String url) {
    Navigator.push<DetailsPage>(
        context, MaterialPageRoute(builder: (context) => DetailsPage(url)));
  }
}
