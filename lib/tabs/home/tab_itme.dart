import 'package:evently/app_theme.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabItme extends StatelessWidget {
  bool isSelected;
  String lable;
  IconData icon;
  TabItme({required this.lable, required this.icon, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? null
            : Border.all(
                color: settingsProvider.isDark
                    ? AppTheme.borderDark
                    : AppTheme.offWhite,
              ),
        color: isSelected
            ? primaryColor
            : settingsProvider.isDark
            ? AppTheme.navy
            : AppTheme.white,
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
              color: isSelected
                  ? AppTheme.white
                  : settingsProvider.isDark
                  ? AppTheme.white
                  : AppTheme.black,
            ),
          ),
        ],
      ),
    );
  }
}
