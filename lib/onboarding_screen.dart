import 'package:evently/Widgets/arrow_back.dart';
import 'package:evently/Widgets/custom_indicator.dart';
import 'package:evently/Widgets/default_elevated_button.dart';
import 'package:evently/Widgets/onboarding_button.dart';
import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routName = '/OnboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> title = [
    'Find Events That Inspire You',
    'Effortless Event Planning',
    'Connect with Friends & Share Moments',
  ];
  List<String> description = [
    'Dive into a world of events crafted to fit your unique interests. Whether youre into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.',
    'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
    'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
  ];
  PageController controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  index == 0
                      ? SizedBox(width: 50, height: 50)
                      : ArrowBack(
                          onPressed: () {
                            index--;
                            setState(() {});
                          },
                        ),
                  Image.asset(
                    'assets/images/${settingsProvider.isDark ? 'logo_dark.png' : 'logo.png'}',
                    height: 27,
                  ),
                  index == 2
                      ? SizedBox(width: 62, height: 48)
                      : OnboardingButton(
                          isChoice: false,
                          text: 'Skip',
                          onTap: () {
                            index = 2;
                            setState(() {});
                          },
                        ),
                ],
              ),
              SizedBox(height: 24),
              Container(
                height: heightSize * 0.44,
                child: PageView.builder(
                  itemBuilder: (_, _) => Image.asset(
                    'assets/images/${settingsProvider.isDark ? 'Onboarding_Dark_${index}' : 'Onboarding_${index}'}.png',
                  ),
                  itemCount: 3,
                  controller: controller,
                  onPageChanged: (value) {
                    index = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: .center,
                children: [
                  CustomIndicator(active: index == 0),
                  CustomIndicator(active: index == 1),
                  CustomIndicator(active: index == 2),
                ],
              ),
              SizedBox(height: 16),
              Text(title[index], style: textTheme.titleLarge),
              SizedBox(height: 8),
              Text(
                description[index],
                style: textTheme.titleMedium!.copyWith(
                  color: AppTheme.darkGrey,
                ),
              ),
              Spacer(),
              DefaultElevatedButton(
                label: index == 2 ? 'Get started' : 'Next',
                onPressed: () async {
                  index++;
                  if (index == 2) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('onboarding_seen', true);
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(LoginScreen.routName);
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
