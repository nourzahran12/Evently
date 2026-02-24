import 'package:evently/models/category_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/tab_itme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(
      context,
      listen: false,
    ).currentUser!;
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text('Welcome Back ✨', style: textTheme.titleSmall),
          SizedBox(height: 4),
          Text(currentUser.name, style: textTheme.titleLarge),
          DefaultTabController(
            length: CategoryModel.categorise.length + 1,
            child: TabBar(
              padding: EdgeInsets.symmetric(vertical: 24),
              isScrollable: true,
              tabAlignment: .start,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.only(right: 8),
              tabs: [
                TabItme(
                  lable: 'All',
                  icon: Icons.category_outlined,
                  isSelected: currentIndex == 0,
                ),
                ...CategoryModel.categorise
                    .map(
                      (Category) => TabItme(
                        lable: Category.name,
                        icon: Category.icon,
                        isSelected:
                            currentIndex ==
                            CategoryModel.categorise.indexOf(Category) + 1,
                      ),
                    )
                    .toList(),
              ],
              onTap: (index) {
                if (currentIndex == index) return;
                currentIndex = index;
                CategoryModel? selectedCategory = index == 0
                    ? null
                    : CategoryModel.categorise[index - 1];
                eventsProvider.filterEvents(selectedCategory);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
