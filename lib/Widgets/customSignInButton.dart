import 'package:flutter/material.dart';

class CustomSignInButton extends StatefulWidget {
  final String imageStringUrl;
  final String label;
  final Function function;
  CustomSignInButton({Key key, this.imageStringUrl, this.label, this.function})
      : super(key: key);

  @override
  _CustomSignInButtonState createState() => _CustomSignInButtonState();
}

class _CustomSignInButtonState extends State<CustomSignInButton> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width / 2.1,
        height: height / 14,
        child: RaisedButton(
          onPressed: widget.function,
          color: Color.lerp(
              Colors.blueAccent[200], Colors.lightBlueAccent[200], 0.2),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height * 0.06,
                  child: widget.imageStringUrl != ''
                      ? Image.asset(widget.imageStringUrl)
                      : null,
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.20,
                      ),
                      textAlign: TextAlign.center,
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
