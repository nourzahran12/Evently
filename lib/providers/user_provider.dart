import 'package:evently/firebase_service.dart';
import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  bool checkIsFavoriteEvent(String eventId) {
    return currentUser!.favoriteEventsIds.contains(eventId);
  }

  void addEventToFavorite(String eventId) {
    FirebaseService.addEventToFavorites(eventId);
    currentUser!.favoriteEventsIds.add(eventId);
    notifyListeners();
  }

  void removeEventToFavorite(String eventId) {
    FirebaseService.removeEventFromFavorites(eventId);
    currentUser!.favoriteEventsIds.remove(eventId);
    notifyListeners();
  }
}
