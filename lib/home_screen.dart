import 'package:evently/create_event_screen.dart';
import 'package:evently/nav_bar_icon.dart';
import 'package:evently/tabs/favorite/favorite_tab.dart';
import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomrScreenState();
}

class _HomrScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: tabs[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (currentIndex == index) return;
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'home'),
            activeIcon: NavBarIcon(iconName: 'home_active'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'favorite'),
            activeIcon: NavBarIcon(iconName: 'favorite_active'),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcon(iconName: 'profile'),
            activeIcon: NavBarIcon(iconName: 'profile_active'),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(CreateEventScreen.routName),
        child: Icon(Icons.add, size: 28),
      ),
    );
  }
}
