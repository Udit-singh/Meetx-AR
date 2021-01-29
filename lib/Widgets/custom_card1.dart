import 'package:flutter/material.dart';

class CustomCard1 extends StatelessWidget {
  const CustomCard1({@required this.height, @required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              height: height * .44,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    height: height * 0.30,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(fit: StackFit.expand, children: [
                      Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        child: Image.asset(
                          "Assets/Images/dots.png",
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Virtual AR Learning",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width * 0.06,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      '"A Augmented Reality learning experience"',
                                      style: TextStyle(
                                        fontSize: width * 0.05,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: height * 0.02)
      ],
    );
  }
}
