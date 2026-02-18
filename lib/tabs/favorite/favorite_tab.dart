import 'package:evently/Widgets/default_text_form_field.dart';
import 'package:evently/Widgets/event_item.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          DefaultTextFormField(
            hintText: 'Search for event',
            suffixIconImageName: 'search',
            onChanged: (query) {},
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) => EventItem(),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
