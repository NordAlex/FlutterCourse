import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage(this.currentUser);
  FirebaseUser currentUser;
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<User>>(
            future: _likeUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(
                      child: Image.network(snapshot.data[index].image),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                );
              }
              return const CircularProgressIndicator();
            }));
  }

  Future<List<User>> _likeUser() async {
    var favoriteQuery = await databaseReference
        .collection('users')
        .document(currentUser.uid)
        .collection('favorites')
        .getDocuments();
    List<User> users = List<User>();

    for (var item in favoriteQuery.documents) {
      users.add(User.fromCloudStorage(item.data));
    }

    return users;
  }
}
