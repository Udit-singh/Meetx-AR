import 'package:flutter/material.dart';
import 'package:meetx/Screens/search_screen.dart';

class QuietBox extends StatelessWidget {
  final String heading;
  final String subtitle;

  QuietBox({
    @required this.heading,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                stops: [0.5, 0.9],
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 25),
                FlatButton(
                  color: Colors.blue,
                  splashColor: Colors.blueAccent,
                  child: Text(
                    "START SEARCHING",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
