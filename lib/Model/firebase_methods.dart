// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:meetx/Model/user.dart';

// class FirebaseMethods {
//   Future<List<User>> fetchAllUsers(FirebaseUser currentUser) async {
//     List<User> userList = List<User>();

//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection("users").get();
//     for (var i = 0; i < querySnapshot.docs.length; i++) {
//       if (querySnapshot.docs[i].id != currentUser.uid) {
//         userList.add(User.fromMap(querySnapshot.docs[i].data));
//       }
//     }
//     return userList;
//   }
// }
