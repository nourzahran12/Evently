import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  IconData icon;
  String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageName,
  });

  static List<CategoryModel> categorise = [
    CategoryModel(
      id: '1',
      name: 'Sport',
      icon: Icons.sports_baseball_outlined,
      imageName: 'sport',
    ),
    CategoryModel(
      id: '2',
      name: 'Birthday',
      icon: Icons.cake_outlined,
      imageName: 'birthday',
    ),
    CategoryModel(
      id: '3',
      name: 'Bookclub',
      icon: Icons.menu_book_outlined,
      imageName: 'bookclub',
    ),
    CategoryModel(
      id: '4',
      name: 'Meeting',
      icon: Icons.laptop_mac_outlined,
      imageName: 'meeting',
    ),
    CategoryModel(
      id: '5',
      name: 'Exhibition',
      icon: Icons.museum_outlined,
      imageName: 'exhibition',
    ),
  ];
}
