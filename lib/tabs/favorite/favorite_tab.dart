import 'package:evently/Widgets/default_text_form_field.dart';
import 'package:evently/Widgets/event_item.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late EventsProvider eventsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserProvider userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      eventsProvider.filterFavoriteEvents(
        userProvider.currentUser!.favoriteEventsIds,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    eventsProvider = Provider.of<EventsProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          DefaultTextFormField(
            hintText: appLocalizations.searchEvent,
            suffixIconImageName: 'search',
            onChanged: (query) {},
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) =>
                  EventItem(eventsProvider.favoriteEvents[index]),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: eventsProvider.favoriteEvents.length,
            ),
          ),
        ],
      ),
    );
  }
}
