import 'package:flutter/material.dart';
import 'package:meetx/Screens/Ar_classroom/detail_page.dart';
import 'package:meetx/Widgets/customAppBar.dart';
import 'package:meetx/utils/Constants.dart';
import 'constants.dart';
import 'data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';
import 'package:echoar_package/echoar_package.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  _launchURL() async {
    const url = 'https://go.echoar.xyz/1FQ1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    print(planets[1].name);
  }

  void _incre() {
    Wiredash.of(context).show();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customAppBar(context),
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
      backgroundColor: gradientEndColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            stops: [0.3, 0.7],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Ch 1: Solar System',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        DropdownMenuItem(
                          child: Text(
                            ' Ch 2: Physics Model',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        DropdownMenuItem(
                          child: Text(
                            ' Ch 3: Mathematical Objects',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        DropdownMenuItem(
                          child: Text(
                            ' Ch 4: Soil and Plants',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        DropdownMenuItem(
                          child: Text(
                            ' Ch 5: Motion and Time',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                      icon: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      underline: SizedBox(
                        height: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.60,
                width: width,
                padding: const EdgeInsets.only(left: 0),
                child: ListView.builder(
                  itemCount: planets.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, a, b) => DetailPage(
                              planetInfo: planets[index],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: height * 0.60,
                                width: width * 0.90,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        35.0, 95.0, 25.0, 0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          planets[index].name,
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: const Color(0xff47455f),
                                            fontWeight: FontWeight.w900,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          'Solar System',
                                          style: TextStyle(
                                            fontSize: 23,
                                            color: primaryTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 32),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Know more',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: secondaryTextColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: secondaryTextColor,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            FlatButton(
                                              onPressed: _launchURL,
                                              child: Text(
                                                'See in AR',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 15,
                            top: 20,
                            child: Hero(
                              tag: planets[index].position,
                              child: Image.asset(
                                planets[index].iconImage,
                                width: 150,
                                alignment: Alignment.topLeft,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 15,
                            bottom: 50,
                            child: Text(
                              planets[index].position.toString(),
                              style: TextStyle(
                                fontSize: 120,
                                color: primaryTextColor.withOpacity(0.08),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomAppBar customAppBar(context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        "Virtual AR Learning",
      ),
      actions: <Widget>[
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

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      print('Settings');
    } else if (choice == Constants.Report) {
      print('Send Feedback');
    }
  }
}
