import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  bool active;
  CustomIndicator({required this.active});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(left: 6),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active ? AppTheme.primaryLight : AppTheme.grey,
      ),
      width: active ? 20 : 8,
      height: 8,
    );
  }
}
