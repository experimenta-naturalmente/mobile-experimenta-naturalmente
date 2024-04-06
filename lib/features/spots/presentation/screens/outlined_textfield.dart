import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OutlinedTextField extends StatefulWidget {
  const OutlinedTextField({
    super.key,
    required this.outlined,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.keyboardType,
    this.mask,
    this.controller,
    this.focusNode,
    this.validator,
  });

  final String outlined;
  final double horizontalPadding;
  final double verticalPadding;
  final TextInputType keyboardType;
  final MaskTextInputFormatter? mask;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  @override
  Widget build(BuildContext context) {
    const String fontName = 'JosefinSans';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding,
        vertical: widget.verticalPadding,
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: widget.mask != null ? [widget.mask!] : [],
        validator: widget.validator,
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          errorStyle: Theme.of(context).textTheme.labelSmall,
          labelText: widget.outlined,
          border: const OutlineInputBorder(),
          labelStyle: const TextStyle(
            fontFamily: fontName,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
