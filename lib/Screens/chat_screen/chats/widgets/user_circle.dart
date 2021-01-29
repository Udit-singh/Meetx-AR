import 'package:flutter/material.dart';
import 'package:meetx/provider/user_provider.dart';
import 'package:meetx/utils/utilities.dart';
import 'package:provider/provider.dart';

import 'user_details_container.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => UserDetailsContainer(),
      ),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white, width: 0.5),
          color: Colors.blueAccent[800],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                Utils.getInitials(userProvider.getUser.username),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: UniversalVariables.lightBlueColor,
                  fontSize: 14,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 9,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  color: Colors.lightGreen,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
