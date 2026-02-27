import 'package:evently/Widgets/default_elevated_button.dart';
import 'package:evently/Widgets/onboarding_button.dart';
import 'package:evently/app_theme.dart';
import 'package:evently/onboarding_screen.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingSetupScreen extends StatelessWidget {
  static const String routName = '/OnboardingSetupScreen';
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/${settingsProvider.isDark ? 'logo_dark.png' : 'logo.png'}',
                  height: 27,
                ),
              ),
              SizedBox(height: 24),
              Image.asset(
                'assets/images/${settingsProvider.isDark ? 'Onboarding_Dark_Setup' : 'Onboarding_Setup'}.png',
                fit: .fill,
                width: double.infinity,
              ),
              SizedBox(height: 24),
              Text('Personalize Your Experience', style: textTheme.titleLarge),
              SizedBox(height: 8),
              Text(
                'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                style: textTheme.titleMedium!.copyWith(
                  color: AppTheme.darkGrey,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Language',
                    style: textTheme.headlineSmall!.copyWith(fontSize: 18),
                  ),
                  Spacer(),
                  OnboardingButton(
                    text: 'English',
                    isChoice: settingsProvider.languageCode != 'ar',
                    onTap: () {
                      settingsProvider.changeLanguage('en');
                    },
                  ),
                  SizedBox(width: 8),
                  OnboardingButton(
                    text: 'Arabic',
                    isChoice: settingsProvider.languageCode == 'ar',
                    onTap: () {
                      settingsProvider.changeLanguage('ar');
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Theme',
                    style: textTheme.headlineSmall!.copyWith(fontSize: 18),
                  ),
                  Spacer(),
                  OnboardingButton(
                    iconName: 'sun',
                    isChoice: !settingsProvider.isDark,
                    onTap: () {
                      settingsProvider.changeTheme(.light);
                    },
                  ),
                  SizedBox(width: 8),
                  OnboardingButton(
                    iconName: 'moon',
                    isChoice: settingsProvider.isDark,
                    onTap: () {
                      settingsProvider.changeTheme(.dark);
                    },
                  ),
                ],
              ),
              Spacer(),
              DefaultElevatedButton(
                label: 'Let’s start',
                onPressed: () {
                  Navigator.of(context).pushNamed(OnboardingScreen.routName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
