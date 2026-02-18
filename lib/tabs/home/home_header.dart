import 'package:evently/models/category_model.dart';
import 'package:evently/tabs/home/tab_itme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
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
                    isSelected: true,
                  ),
                  ...CategoryModel.categorise
                      .map(
                        (Category) => TabItme(
                          lable: Category.name,
                          icon: Category.icon,
                          isSelected: false,
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
