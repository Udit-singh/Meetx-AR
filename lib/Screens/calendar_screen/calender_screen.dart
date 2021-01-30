import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meetx/Screens/calendar_screen/calendar_Client.dart';
import 'package:meetx/Screens/calendar_screen/calender_View.dart';
import 'package:meetx/Widgets/customAppBar.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Image.asset("Assets/Images/plan.jpg")],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      FlatButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2021, 1, 1),
                                maxTime: DateTime(2200, 6, 7),
                                onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              setState(() {
                                this.startTime = date;
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Text(
                            'Meet Start Time',
                            style: TextStyle(color: Colors.blue),
                          )),
                      Text('$startTime'),
                    ],
                  ),
                  Row(
                    children: [
                      FlatButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2019, 3, 5),
                                maxTime: DateTime(2200, 6, 7),
                                onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              setState(() {
                                this.endTime = date;
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Text(
                            'Meet End Time',
                            style: TextStyle(color: Colors.blue),
                          )),
                      Text('$endTime'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _eventName,
                      decoration: InputDecoration(hintText: 'Enter Meet Name'),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: RaisedButton(
                        child: Text(
                          'Add Meet Reminder',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        onPressed: () {
                          if (_eventName.toString().isEmpty) {
                            calendarClient.insert(
                              _eventName.text,
                              startTime,
                              endTime,
                            );
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Reminder added successfully!'),
                            ));
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Please fill all the fields!'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }),
                  ),
                ],
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
        onPressed: () {},
      ),
      centerTitle: true,
      title: Text(
        "MeetX Calendar",
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.calendar_today_rounded,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CalendarEvents()),
            );
          },
        ),
      ],
    );
  }
}
