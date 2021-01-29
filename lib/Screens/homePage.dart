import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meetx/Model/user.dart';

import 'package:meetx/Screens/signIn.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int _page = 0;
  bool repo = false;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getUser();
  }

  User user;

  void getUser() async {
    DocumentSnapshot doc =
        await usersRef.doc(googleSignIn.currentUser.id).get();
    user = User.fromJson(doc.data());
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    double _labelS = 11;
    return Scaffold(
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
            icon: Icon(
              Icons.feedback_outlined,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.blue,
        ),
      ),
      body: PageView(
        children: [
          Center(child: Index()),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: CupertinoTabBar(
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,
                      color:
                          (_page == 0) ? Colors.lightBlue : Colors.grey[600]),
                  // ignore: deprecated_member_use
                  title: Text(
                    "Home",
                    style: TextStyle(
                        fontSize: _labelS,
                        color:
                            (_page == 0) ? Colors.lightBlue : Colors.grey[600]),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined,
                      color:
                          (_page == 1) ? Colors.lightBlue : Colors.grey[600]),
                  // ignore: deprecated_member_use
                  title: Text(
                    "Calender",
                    style: TextStyle(
                        fontSize: _labelS,
                        color:
                            (_page == 1) ? Colors.lightBlue : Colors.grey[600]),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.connect_without_contact,
                      color:
                          (_page == 2) ? Colors.lightBlue : Colors.grey[600]),
                  // ignore: deprecated_member_use
                  title: Text(
                    "Connect",
                    style: TextStyle(
                        fontSize: _labelS,
                        color:
                            (_page == 2) ? Colors.lightBlue : Colors.grey[600]),
                  )),
            ],
            onTap: navigationTap,
            currentIndex: _page,
          ),
        ),
      ),
    );
  }
}

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                height: height * 0.74,
                width: width * 0.9,
                child: ListView(
                  children: [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
