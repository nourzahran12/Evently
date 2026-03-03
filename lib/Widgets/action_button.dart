import 'package:evently/app_theme.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ActionButton extends StatelessWidget {
  String iconName;
  VoidCallback? onPressed;
  ActionButton({required this.iconName, this.onPressed});
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return IconButton(
      onPressed:
          onPressed ??
          () {
            Navigator.of(context).pop();
          },
      icon: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: settingsProvider.isDark ? AppTheme.navy : AppTheme.white,
          border: Border.all(
            color: settingsProvider.isDark
                ? AppTheme.borderDark
                : AppTheme.offWhite,
          ),
        ),
        child: SvgPicture.asset(
          'assets/icons/$iconName.svg',
          height: 24,
          width: 24,
          fit: .scaleDown,
          colorFilter: .mode(
            settingsProvider.isDark ? AppTheme.white : AppTheme.primaryLight,
            .srcIn,
          ),
        ),
      ),
    );
  }
}
