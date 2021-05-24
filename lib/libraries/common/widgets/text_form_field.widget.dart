import 'package:desafio_toro/libraries/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String Function(String)? onSaved;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final String Function(String)? onChanged;
  final int? maxLength;
  final bool? readOnly;
  final GlobalKey<FormFieldState>? keyField;

  final List<TextInputFormatter>? inputFormatters;

  TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
    this.onSaved,
    this.onEditingComplete,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.inputFormatters,
    this.keyField,
    this.suffixIcon,
    this.maxLength,
  }) : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late FocusNode _focusNode;
  late bool _obscureText;

  void _nodeListener() {
    setState(() {});
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    _obscureText = widget.obscureText!;
    _focusNode.addListener(_nodeListener);

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_nodeListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.keyField,
      inputFormatters: widget.inputFormatters,
      focusNode: _focusNode,
      controller: widget.controller,
      validator: widget.validator,
      onEditingComplete: widget.onEditingComplete,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly!,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      cursorColor: purple,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: red[200]),
        prefixStyle: TextStyle(
          color: purple,
        ),
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(
                widget.prefixIcon,
                color: _focusNode.hasFocus ? purple[200] : gray[200],
              ),
        suffixIcon: widget.suffixIcon ??
            (widget.obscureText == false
                ? null
                : GestureDetector(
                    onTap: () => setState(() => _obscureText = !_obscureText),
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: _focusNode.hasFocus ? purple[200] : gray[300],
                    ),
                  )),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: purple,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: purple,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
