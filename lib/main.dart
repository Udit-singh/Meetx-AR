import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetx/Screens/homePage.dart';
import 'package:meetx/Screens/signIn.dart';

import 'Model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<User> getCurrentUser() async {
    User user;
    DocumentSnapshot doc =
        await usersRef.doc(googleSignIn.currentUser.id).get();
    user = User.fromJson(doc.data());
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          buttonColor: Colors.white, backgroundColor: Colors.grey[100]),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getCurrentUser(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}
