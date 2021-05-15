import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final String labelText;
  final Widget suffixIcon;
  final bool obscureText;
  final isPasswordVisiblityEnable;
  final int maxLength;
  final TextEditingController controller;
  final Function(String string) onChanged;

  const CustomTextField(
      {Key key,
      this.keyboardType,
      this.labelText,
      this.suffixIcon,
      this.isPasswordVisiblityEnable = false,
      this.obscureText,
      this.maxLength = 10,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText;
  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: widget.controller,
        maxLength: widget.maxLength,
        obscureText: obscureText,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          counterText: '',
          isDense: false,
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(width: 1),
          ),
          suffixIcon: widget.suffixIcon == null
              ? Visibility(
                  visible: widget.isPasswordVisiblityEnable,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.visibility_sharp,
                      color: Colors.grey,
                      size: 24,
                    ),
                    onPressed: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },
                  ),
                )
              : null,
        ),
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
