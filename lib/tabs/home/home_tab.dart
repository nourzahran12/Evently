import 'package:evently/Widgets/event_item.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> events = [];
  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      getEvents();
    }
    return Column(
      children: [
        HomeHeader(),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) => EventItem(events[index]),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: events.length,
          ),
        ),
      ],
    );
  }

  Future<void> getEvents() async {
    events = await FirebaseService.getEvents();
    setState(() {});
  }
}
