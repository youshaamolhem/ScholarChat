import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    this.hintText,
    this.label,
    this.onChanged,
    this.obscure = false,
  });

  String? hintText, label;
  bool? obscure;
  Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    if (widget.obscure == true) {
      suffixIcon = GestureDetector(
          onTap: () {
            setState(() {
              widget.obscure = false;
              suffixIcon == Icon(Icons.remove_red_eye);
            });
          },
          child: Icon(Icons.remove_red_eye));
    } else if (widget.obscure == true) {
      suffixIcon = Icon(Icons.email);
    }

    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'data is Empty';
        }
      },
      obscureText: widget.obscure!,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,

        // obscure = true? GestureDetector(
        //     onTap: () {
        //       obscure = false;
        //     },
        //     child: Icon(Icons.remove_red_eye)): Icon(icon),
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        label: Text(
          '${widget.label}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomChatTextField extends StatelessWidget {
  CustomChatTextField({this.onSubmitted, this.controller});
  Function(String)? onSubmitted;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.send),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(16.0)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(16.0))),
    );
  }
}
