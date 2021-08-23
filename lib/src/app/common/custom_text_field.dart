import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final String? labelText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isPasswordVisiblityEnable;
  final int maxLength;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final Function(String? string)? onChanged;
  final String? Function(String? string)? validator;
  final TextStyle? textStyle;
  final bool? isDense;
  final TextAlign textAlign;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? filled;
  final Color? fillColor;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const CustomTextField({
    Key? key,
    this.keyboardType,
    this.labelText,
    this.suffixIcon,
    this.isPasswordVisiblityEnable = false,
    this.obscureText = false,
    this.maxLength = 10,
    this.onChanged,
    this.textStyle = const TextStyle(color: Colors.black, fontSize: 16),
    this.onFieldSubmitted,
    this.decoration,
    this.focusNode,
    this.validator,
    this.controller,
    this.isDense,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.filled = false,
    this.fillColor = Colors.transparent,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? obscureText;
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
        textAlign: widget.textAlign,
        style: widget.textStyle,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: widget.focusNode,
        controller: widget.controller,
        maxLength: widget.maxLength,
        obscureText: obscureText!,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        decoration: widget.decoration ??
            InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              filled: widget.filled,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              fillColor: widget.fillColor,
              counterText: '',
              isDense: widget.isDense,
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 0, color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 1, color: Colors.black),
              ),
              suffixIcon: widget.suffixIcon == null
                  ? Visibility(
                      visible: widget.isPasswordVisiblityEnable,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.visibility_sharp,
                          color: Colors.grey,
                          size: 24,
                        ),
                        onPressed: () {
                          obscureText = !obscureText!;
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

class CustomPasswordField extends StatefulWidget {
  final TextInputType? keyboardType;
  final String? labelText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isPasswordVisiblityEnable;
  final int maxLength;
  final FocusNode? focusNode;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedErrorBorder;
  final TextEditingController? controller;
  final Function(String? string)? onChanged;
  final String? Function(String? string)? validator;
  final TextStyle? style;
  final bool? isDense;
  final String? hintText;
  final TextAlign textAlign;
  final TextStyle? labelStyle;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomPasswordField({
    Key? key,
    this.keyboardType,
    this.labelText,
    this.suffixIcon,
    this.isPasswordVisiblityEnable = false,
    this.obscureText = false,
    this.maxLength = 10,
    this.onChanged,
    this.style,
    this.onFieldSubmitted,
    this.focusNode,
    this.validator,
    this.controller,
    this.isDense,
    this.textAlign = TextAlign.start,
    this.border,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.focusedErrorBorder,
    this.hintText,
    this.labelStyle,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool? obscureText;
  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      style: widget.style,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      controller: widget.controller,
      maxLength: widget.maxLength,
      obscureText: obscureText!,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        counterText: '',
        hintText: widget.hintText,
        labelStyle: widget.labelStyle,
        isDense: widget.isDense,
        labelText: widget.labelText,
        border: widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(),
            ),
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1),
            ),
        errorBorder: widget.errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1),
            ),
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1),
            ),
        disabledBorder: widget.disabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1),
            ),
        focusedErrorBorder: widget.focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1),
            ),
        suffixIcon: widget.suffixIcon ??
            Visibility(
              visible: widget.isPasswordVisiblityEnable,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.visibility_sharp,
                  color: Colors.grey,
                  size: 24,
                ),
                onPressed: () {
                  obscureText = !obscureText!;
                  setState(() {});
                },
              ),
            ),
      ),
      keyboardType: widget.keyboardType,
    );
  }
}
