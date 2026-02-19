import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? prefixIconImageName;
  String? suffixIconImageName;
  bool isPassword;

  DefaultTextFormField({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.prefixIconImageName,
    this.suffixIconImageName,
    this.isPassword = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIconImageName == null
            ? null
            : Padding(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/${widget.prefixIconImageName}.svg',
                ),
              ),
        suffixIcon: widget.suffixIconImageName == null && widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppTheme.grey,
                ),
              )
            : Padding(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/${widget.suffixIconImageName}.svg',
                ),
              ),
      ),
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: isObscure,
      autovalidateMode: .onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
