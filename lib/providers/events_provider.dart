import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favoriteEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }
    notifyListeners();
  }

  void filterFavoriteEvents(List<String> favoriteEventsIds) {
    favoriteEvents = allEvents
        .where((event) => favoriteEventsIds.contains(event.id))
        .toList();
    notifyListeners();
  }
}
