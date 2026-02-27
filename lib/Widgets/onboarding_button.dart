import 'package:evently/app_theme.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OnboardingButton extends StatelessWidget {
  String? text;
  String? iconName;
  VoidCallback onTap;
  bool isChoice;
  OnboardingButton({
    this.text,
    this.iconName,
    required this.isChoice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: settingsProvider.isDark
                ? AppTheme.borderDark
                : Colors.transparent,
          ),
          color: settingsProvider.isDark
              ? isChoice
                    ? AppTheme.primaryDark
                    : AppTheme.navy
              : isChoice
              ? AppTheme.primaryLight
              : AppTheme.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: text != null
              ? Text(
                  text!,
                  style: textTheme.titleSmall!.copyWith(
                    color: settingsProvider.isDark
                        ? AppTheme.white
                        : isChoice
                        ? AppTheme.white
                        : AppTheme.primaryLight,
                    fontWeight: .w600,
                  ),
                )
              : SvgPicture.asset(
                  'assets/icons/$iconName.svg',
                  height: 24,
                  width: 24,
                  colorFilter: .mode(
                    settingsProvider.isDark
                        ? AppTheme.white
                        : isChoice
                        ? AppTheme.white
                        : AppTheme.primaryLight,
                    .srcIn,
                  ),
                ),
        ),
      ),
    );
  }
}
