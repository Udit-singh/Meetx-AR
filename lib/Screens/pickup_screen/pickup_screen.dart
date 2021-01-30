import 'package:flutter/material.dart';
import 'package:meetx/Model/call.dart';
import 'package:meetx/Model/call_methods.dart';
import 'package:meetx/Model/user.dart';
import 'package:meetx/Screens/pickup_screen/call_screen.dart';
import 'package:meetx/Widgets/cached_image.dart';
import 'package:meetx/provider/user_provider.dart';
import 'package:meetx/utils/permissions.dart';
import 'package:provider/provider.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  final CallMethods callMethods = CallMethods();

  PickupScreen({
    this.call,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
            CachedImage(
              user.profilePhoto,
              isRound: true,
              radius: 180,
            ),
            SizedBox(height: 15),
            Text(
              "Udit Singh.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end, size: 30),
                  color: Colors.redAccent,
                  onPressed: () async {
                    await callMethods.endCall(call: call);
                  },
                ),
                SizedBox(width: 25),
                IconButton(
                    icon: Icon(Icons.call, size: 30),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallScreen(call: call),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
