import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/pages/details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage(this.currentUser);
  final FirebaseUser currentUser;
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<User>>(
            future: _fetchFavorites(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = snapshot.data[index];
                    return InkWell(
                        child: Center(
                          child: GridTile(
                            child: Column(
                              children: <Widget>[
                                Image.network(user.image),
                                Text(user.name)
                              ],
                            ),
                          ),
                        ),
                        onTap: () =>
                            _showUserDetails(context, user, currentUser));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                );
              }
              return const CircularProgressIndicator();
            }));
  }

  Future<List<User>> _fetchFavorites() async {
    final favoriteQuery = await databaseReference
        .collection('users')
        .document(currentUser.uid)
        .collection('favorites')
        .getDocuments();
    final users = <User>{};

    for (var item in favoriteQuery.documents) {
      users.add(User.fromCloudStorage(item.data));
    }

    return users.toList();
  }

  void _showUserDetails(
      BuildContext context, User selectedUser, FirebaseUser currentUser) {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          tinderUser: selectedUser,
          myUser: currentUser,
        ),
      ),
    );
  }
}
