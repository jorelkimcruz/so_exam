import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  const TextFieldPasswordWidget(
      {Key? key,
      required this.placeholder,
      required this.controller,
      this.editable = true,
      this.hint = '',
      this.helperText,
      this.onTap,
      this.prefix,
      this.validator})
      : super(key: key);

  final String placeholder;
  final TextEditingController controller;
  final String hint;
  final String? helperText;
  final void Function()? onTap;
  final bool editable;
  final FormFieldValidator? validator;
  final Widget? prefix;
  @override
  _TextFieldPasswordState createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPasswordWidget> {
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autocorrect: false,
      validator: widget.validator,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        enabledBorder: const OutlineInputBorder(),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withAlpha(150),
          ),
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),

        labelText: widget.placeholder.tr,
        helperMaxLines: 3,
        helperText: widget.helperText,
        // helperStyle: AppMaterialTheme.helperTextStyle(),
        hintText: widget.hint,
        // hintStyle: AppMaterialTheme.subtitleTextStyle(
        //     color: Colors.white.withOpacity(0.5))
      ),
      // style: AppMaterialTheme.subtitleTextStyle(),
      enabled: widget.editable,
      onTap: widget.onTap,
    );
  }
}
