import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category_model.dart';

class EventModel {
  String id;
  CategoryModel category;
  String title;
  String description;
  DateTime dateTime;
  String creatorId;

  EventModel({
    this.id = '',
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.creatorId,
  });

  EventModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        category: CategoryModel.categorise.firstWhere(
          (category) => category.id == json['categoryId'],
        ),
        title: json['title'],
        description: json['description'],
        dateTime: (json['timestamp'] as Timestamp).toDate(),
        creatorId: json['creatorId'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': category.id,
    'title': title,
    'description': description,
    'timestamp': Timestamp.fromDate(dateTime),
    'creatorId': creatorId,
  };
}
