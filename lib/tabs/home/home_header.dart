import 'package:evently/models/category_model.dart';
import 'package:evently/tabs/home/tab_itme.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text('Welcome Back ✨', style: textTheme.titleSmall),
          SizedBox(height: 4),
          Text('User Name', style: textTheme.titleLarge),
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
                CategoryModel selectedCategory =
                    CategoryModel.categorise[index - 1];
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
