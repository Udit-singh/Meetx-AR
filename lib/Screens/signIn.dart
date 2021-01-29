import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meetx/Model/user.dart';
import 'package:meetx/Screens/homePage.dart';
import 'package:meetx/Widgets/customSignInButton.dart';

final googleSignIn = GoogleSignIn();

final usersRef = FirebaseFirestore.instance.collection('users');

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  User tempuser = User();

  @override
  void initState() {
    super.initState();
  }

  void githubLogIn() async {
    await googleSignIn.signOut();
  }

  void logIn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final user = await googleSignIn.signIn();
      DocumentSnapshot doc = await usersRef.doc(user.id).get();
      if (doc.exists) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
      } else {
        usersRef.doc(user.id).set({
          'id': user.id,
          'username': user.displayName,
          'email': user.email,
          'photoUrl': user.photoUrl,
        });
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
      }
    } else {
      SnackBar snackbar = SnackBar(
        content: Text('Check your internet connection'),
      );
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
              child: Card(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                elevation: 0,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(30),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height * 0.30,
                        child: Image.asset(
                          '',
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        'LogIn To Meetx',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomSignInButton(
                  imageStringUrl: '',
                  label: 'Google',
                  function: logIn,
                ),
                Text(
                  "OR",
                  style: TextStyle(fontSize: 20),
                ),
                CustomSignInButton(
                  imageStringUrl: '',
                  label: 'Github',
                  function: githubLogIn,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
