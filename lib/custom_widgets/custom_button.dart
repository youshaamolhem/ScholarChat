import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, @required this.label, @required this.callback})
      : super(key: key);
  VoidCallback? callback;
  String? label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          height: 30.0,
          width: 120.0,
          child: Center(
            child: Text(
              label!,
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0),
          )),
    );
  }
}
