import 'package:evently/app_theme.dart';
import 'package:evently/event_details_screen.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  EventModel event;
  EventItem(this.event);
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    bool isFavorite = userProvider.checkIsFavoriteEvent(event.id);
    Size screenSize = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              EventDetailsScreen.routeName,
              arguments: event,
            );
          },

          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: Image.asset(
              'assets/images/${settingsProvider.isDark ? event.category.imageName + '_dark' : event.category.imageName}.png',
              height: screenSize.height * 0.23,
              width: double.infinity,
              fit: .fill,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: settingsProvider.isDark
                ? AppTheme.navy
                : AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: settingsProvider.isDark
                  ? AppTheme.borderDark
                  : AppTheme.offWhite,
            ),
          ),
          child: Text(
            DateFormat('d MMM').format(event.dateTime),
            style: textTheme.titleMedium!.copyWith(
              fontWeight: .w600,
              color: primaryColor,
            ),
          ),
        ),
        Positioned(
          width: screenSize.width - 32,
          bottom: 8,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: settingsProvider.isDark
                  ? AppTheme.navy
                  : AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: settingsProvider.isDark
                    ? AppTheme.borderDark
                    : AppTheme.offWhite,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: textTheme.titleSmall!.copyWith(
                      color: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.black,
                      fontWeight: .w500,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    if (isFavorite) {
                      userProvider.removeEventToFavorite(event.id);
                      Provider.of<EventsProvider>(
                        context,
                        listen: false,
                      ).filterFavoriteEvents(
                        userProvider.currentUser!.favoriteEventsIds,
                      );
                    } else {
                      userProvider.addEventToFavorite(event.id);
                    }
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
