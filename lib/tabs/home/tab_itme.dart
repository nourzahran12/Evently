import 'package:evently/app_theme.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';

class TabItme extends StatelessWidget {
  bool isSelected;
  String lable;
  IconData icon;
  TabItme({required this.lable, required this.icon, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? primaryColor : AppTheme.white,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? AppTheme.white : primaryColor,
          ),
          SizedBox(width: 8),
          Text(
            lable,
            style: textTheme.titleMedium!.copyWith(
              color: isSelected ? AppTheme.white : AppTheme.black,
            ),
          ),
        ],
      ),
    );
  }
}
