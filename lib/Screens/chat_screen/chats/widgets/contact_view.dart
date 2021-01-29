import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meetx/Model/chat_methods.dart';
import 'package:meetx/Model/contact.dart';
import 'package:meetx/Model/user.dart';
import 'package:meetx/Screens/chat_screen/chat_screen.dart';
import 'package:meetx/Screens/signIn.dart';
import 'package:meetx/Widgets/cached_image.dart';
import 'package:meetx/Widgets/custom_tile.dart';
import 'package:meetx/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'last_message_container.dart';
import 'online_dot_indicator.dart';

class ContactView extends StatelessWidget {
  final Contact contact;

  ContactView(this.contact);

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
    return FutureBuilder<User>(
      future: getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final ChatMethods _chatMethods = ChatMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Text(
        (contact != null ? contact.username : null) != null
            ? contact.username
            : "..",
        style: TextStyle(fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.id,
          receiverId: contact.id,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(
              uid: contact.id,
            ),
          ],
        ),
      ),
    );
  }
}
