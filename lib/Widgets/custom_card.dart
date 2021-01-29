import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetx/Screens/meet_screen/pages/video_call.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({@required this.height, @required this.width});

  final double height;
  final double width;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final _channelController = TextEditingController();
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCall(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              height: widget.height * .78,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        child: Image.asset("Assets/Images/meet.jpg",
                            alignment: Alignment.center, fit: BoxFit.fill),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: widget.height * .50,
                        child: Column(
                          children: [
                            SizedBox(
                              height: widget.height * 0.03,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                  controller: _channelController,
                                  decoration: InputDecoration(
                                    errorText: _validateError
                                        ? 'Channel name is mandatory'
                                        : null,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                    ),
                                    hintText: 'Enter Meeting Code / Name',
                                  ),
                                ))
                              ],
                            ),
                            Column(
                              children: [
                                ListTile(
                                  title: Text("Broadcaster Channel"),
                                  leading: Radio(
                                    value: ClientRole.Broadcaster,
                                    groupValue: _role,
                                    onChanged: (ClientRole value) {
                                      setState(() {
                                        _role = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text("Audience Channel"),
                                  leading: Radio(
                                    value: ClientRole.Audience,
                                    groupValue: _role,
                                    onChanged: (ClientRole value) {
                                      setState(() {
                                        _role = value;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      onPressed: onJoin,
                                      child: Text('Join Meet'),
                                      color: Colors.blueAccent,
                                      textColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.02)
        ],
      ),
    );
  }
}
