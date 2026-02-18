import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? prefixIconImageName;
  String? suffixIconImageName;

  DefaultTextFormField({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.prefixIconImageName,
    this.suffixIconImageName,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIconImageName == null
            ? null
            : SvgPicture.asset('assets/icons/$prefixIconImageName.svg'),
        suffixIcon: suffixIconImageName == null
            ? null
            : Padding(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/$suffixIconImageName.svg',
                ),
              ),
      ),
      controller: controller,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
