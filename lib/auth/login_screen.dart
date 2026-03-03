import 'package:evently/Widgets/default_elevated_button.dart';
import 'package:evently/Widgets/default_text_form_field.dart';
import 'package:evently/Widgets/ui_utils.dart';
import 'package:evently/app_theme.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routName = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 24),
                Center(
                  child: Image.asset('assets/images/logo.png', height: 27),
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  appLocalizations.loginTitle,
                  style: textTheme.headlineSmall,
                ),
                SizedBox(height: 24),
                DefaultTextFormField(
                  hintText: appLocalizations.enterEmail,
                  prefixIconImageName: 'email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      return appLocalizations.invalidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DefaultTextFormField(
                  hintText: appLocalizations.enterPassword,
                  prefixIconImageName: 'password',
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return appLocalizations.invalidPassword;
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                SizedBox(height: screenHeight * 0.06),
                DefaultElevatedButton(
                  label: appLocalizations.login,
                  onPressed: login,
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      appLocalizations.dontHaveAccount,
                      style: textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(RegisterScreen.routName);
                      },
                      child: Text(appLocalizations.register),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                  onPressed: signInWithGoogle,
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/google.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 16),
                      Text(appLocalizations.loginWithGoogle),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    textStyle: textTheme.titleLarge,
                    backgroundColor: AppTheme.white,
                    foregroundColor: AppTheme.primaryLight,
                    fixedSize: Size(MediaQuery.sizeOf(context).width, 48),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formkey.currentState!.validate()) {
      FirebaseService.login(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((user) {
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            UiUtils.showErrorMessage(errorMessage);
          });
    }
  }

  void signInWithGoogle() {
    FirebaseService.signInWithGoogle()
        .then((user) {
          Provider.of<UserProvider>(
            context,
            listen: false,
          ).updateCurrentUser(user);

          Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
        })
        .catchError((error) {
          String? errorMessage;
          if (error is FirebaseAuthException) {
            errorMessage = error.message;
          }
          UiUtils.showErrorMessage(errorMessage);
        });
  }
}
