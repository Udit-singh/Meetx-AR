import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meetx/Model/user.dart';
import 'package:meetx/Screens/chat_screen/chat_screen.dart';
import 'package:meetx/Screens/signIn.dart';
import 'package:meetx/Widgets/custom_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<User> userList = <User>[];
  String query = "";
  TextEditingController searchController = TextEditingController();
  User user;

  void getUser() async {
    DocumentSnapshot doc =
        await usersRef.doc(googleSignIn.currentUser.id).get();
    user = User.fromJson(doc.data());
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    snapshot.docs.forEach((doc) {
      setState(() {
        if (doc.id != user.id) userList.add(User.fromMap(doc.data()));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  searchAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: Colors.black,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => searchController.clear());
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0x88ffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSuggestions(String query, User user) {
    final List<User> suggestionList = query.isEmpty
        ? []
        : userList.where((User user) {
            String _getUsername = user.username.toLowerCase();
            String _query = query.toLowerCase();
            bool matchesUsername = _getUsername.contains(_query);

            return (matchesUsername);

            // (User user) => (user.username.toLowerCase().contains(query.toLowerCase()) ||
            //     (user.name.toLowerCase().contains(query.toLowerCase()))),
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: ((context, index) {
        User searchedUser = User(
            id: suggestionList[index].id,
            profilePhoto: suggestionList[index].profilePhoto,
            username: suggestionList[index].username,
            status: suggestionList[index].status);

        return CustomTile(
          mini: false,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          receiver: searchedUser,
                        )));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(searchedUser.profilePhoto),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            searchedUser.username,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            searchedUser.status.toString(),
            style: TextStyle(color: Colors.grey),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query, user),
      ),
    );
  }
}
