import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meetx/Model/user.dart';
import 'package:meetx/Screens/signIn.dart';
import 'package:meetx/enum/user_state.dart';
import 'package:meetx/utils/utilities.dart';

class OnlineDotIndicator extends StatelessWidget {
  final String uid;

  OnlineDotIndicator({
    @required this.uid,
  });

  Future<User> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot = await usersRef.doc(id).get();
      return User.fromMap(documentSnapshot.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    getColor(int state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        default:
          return Colors.orange;
      }
    }

    Stream<DocumentSnapshot> getUserStream({@required String id}) =>
        usersRef.doc(id).snapshots();

    return Align(
      alignment: Alignment.topRight,
      child: StreamBuilder<DocumentSnapshot>(
        stream: getUserStream(
          id: uid,
        ),
        builder: (context, snapshot) {
          User user;

          if (snapshot.hasData && snapshot.data.data != null) {
            user = User.fromMap(snapshot.data.data());
          }

          return Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.only(right: 5, top: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColor(user?.state),
            ),
          );
        },
      ),
    );
  }
}
