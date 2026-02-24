import 'package:evently/app_theme.dart';
import 'package:evently/models/language_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).currentUser!;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/route_logo.png'),
            radius: 58,
          ),
          SizedBox(height: 16),
          Text(
            currentUser.name,
            style: textTheme.titleLarge!.copyWith(fontWeight: .w600),
          ),
          SizedBox(height: 4),
          Text(currentUser.email, style: textTheme.titleSmall),
          SizedBox(height: 32),
          SwitchListTile(
            value: false,
            onChanged: (value) {},
            title: Text('Dark Mode'),
            activeTrackColor: Theme.of(context).primaryColor,
            inactiveTrackColor: AppTheme.lightGrey,
            thumbColor: WidgetStatePropertyAll(AppTheme.white),
            trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Language'),
            trailing: DropdownButton(
              value: 'en',
              items: LanguageModel.languages
                  .map(
                    (language) => DropdownMenuItem(
                      value: language.code,
                      child: Text(language.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {},
              dropdownColor: AppTheme.white,
              borderRadius: BorderRadius.circular(16),
              underline: SizedBox(),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Logout'),
            trailing: SvgPicture.asset('assets/icons/logout.svg'),
          ),
        ],
      ),
    );
  }
}
