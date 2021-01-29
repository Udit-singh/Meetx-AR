import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meetx/Model/user.dart';
import 'package:meetx/Screens/calendar_screen/calender_screen.dart';
import 'package:meetx/Screens/chat_screen/chats/chat_list_screen.dart';
import 'package:meetx/Screens/pickup_screen/pickup_screen.dart';
import 'package:meetx/Screens/signIn.dart';
import 'package:meetx/Widgets/customAppBar.dart';
import 'package:meetx/Widgets/custom_card.dart';
import 'package:meetx/Widgets/custom_card1.dart';
import 'package:meetx/provider/user_provider.dart';
import 'package:meetx/utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:wiredash/wiredash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int _page = 0;
  UserProvider userProvider;
  bool repo = false;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getUser();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
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
          onPressed: Wiredash.of(context).show,
          child: IconButton(
            icon: Icon(
              Icons.feedback_outlined,
            ),
            onPressed: Wiredash.of(context).show,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
      body: PageView(
        children: [
          Center(child: Index()),
          Center(child: Calender()),
          Center(child: ChatListScreen()),
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
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                height: height * 0.74,
                width: width * 0.9,
                child: ListView(
                  children: [
                    CustomCard1(height: height, width: width),
                    CustomCard(height: height, width: width),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomAppBar customAppBar(context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.account_box_outlined,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PickupScreen(),
            ),
          );
        },
      ),
      centerTitle: true,
      title: Text(
        "MeetX Home",
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
          ),
          onPressed: () {
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          },
        ),
      ],
    );
  }

  // void choiceAction(String choice) {
  //   if (choice == Constants.Settings) {
  //     print('Settings');
  //   } else if (choice == Constants.Report) {
  //     print('Send Feedback');
  //   }
  // }
}
