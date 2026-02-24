import 'package:evently/Widgets/default_elevated_button.dart';
import 'package:evently/Widgets/default_text_form_field.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routName = '/RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
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
                Text('Create your account', style: textTheme.headlineSmall),
                SizedBox(height: 24),
                DefaultTextFormField(
                  hintText: 'Enter your name',
                  prefixIconImageName: 'name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.length < 2) {
                      return 'Invalid name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DefaultTextFormField(
                  hintText: 'Enter your email',
                  prefixIconImageName: 'email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DefaultTextFormField(
                  hintText: 'Enter your password',
                  prefixIconImageName: 'password',
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Invalid password';
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                SizedBox(height: screenHeight * 0.04),
                DefaultElevatedButton(label: 'Register', onPressed: register),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(LoginScreen.routName);
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formkey.currentState!.validate()) {
      FirebaseService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ).then((user) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
      });
    }
  }
}
