import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:meetx/Model/user.dart';
import 'package:meetx/Screens/signIn.dart';

class UserProvider with ChangeNotifier {
  User _user;

  User get getUser => _user;

  User user;

  Future<User> getCurrentUser() async {
    DocumentSnapshot doc =
        await usersRef.doc(googleSignIn.currentUser.id).get();
    user = User.fromJson(doc.data());
    return user;
  }

  void refreshUser() async {
    User user = await getCurrentUser();
    _user = user;
    notifyListeners();
  }
}
