import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meetx/Model/call.dart';
import 'package:meetx/Model/call_methods.dart';
import 'package:meetx/Model/user.dart';
import 'package:meetx/Screens/pickup_screen/call_screen.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context}) async {
    Call call = Call(
      callerId: from.id,
      callerName: from.username,
      callerPic: from.profilePhoto,
      receiverId: to.id,
      receiverName: to.username,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      print(call.callerName);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}
