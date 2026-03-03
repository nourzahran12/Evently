import 'package:evently/Widgets/action_button.dart';
import 'package:evently/app_theme.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = '/EventDetails';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final EventModel event =
        ModalRoute.of(context)!.settings.arguments as EventModel;

    final currentUser = Provider.of<UserProvider>(context).currentUser!;

    bool isOwner = currentUser.id == event.creatorId;

    DateFormat dateFormat = DateFormat('d MMMM ');
    DateFormat timeFormat = DateFormat('h:mm a');

    return Scaffold(
      appBar: AppBar(
        leading: ActionButton(iconName: 'arrow_left'),
        title: Text('Event details'),
        actions: isOwner
            ? [
                ActionButton(
                  iconName: 'edit',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreateEventScreen(event: event),
                      ),
                    );
                  },
                ),
                ActionButton(
                  iconName: 'delete',
                  onPressed: () async {
                    await FirebaseService.getEventsCollection()
                        .doc(event.id)
                        .delete();
                    await Provider.of<EventsProvider>(
                      context,
                      listen: false,
                    ).getEvents();

                    Navigator.pop(context);
                  },
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(
                'assets/images/${settingsProvider.isDark ? event.category.imageName + '_dark' : event.category.imageName}.png',
                height: MediaQuery.sizeOf(context).height * 0.23,
                width: double.infinity,
                fit: .fill,
              ),
            ),
            SizedBox(height: 16),
            Text(
              event.title,
              style: textTheme.titleLarge!.copyWith(fontSize: 18),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: settingsProvider.isDark ? AppTheme.navy : AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: settingsProvider.isDark
                      ? AppTheme.borderDark
                      : AppTheme.offWhite,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: settingsProvider.isDark
                          ? AppTheme.navy
                          : AppTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: settingsProvider.isDark
                            ? AppTheme.borderDark
                            : AppTheme.offWhite,
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/date.svg',
                      colorFilter: settingsProvider.isDark
                          ? .mode(AppTheme.primaryDark, .srcIn)
                          : null,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    children: [
                      Text(
                        dateFormat.format(event.dateTime),
                        style: textTheme.titleMedium!.copyWith(
                          color: settingsProvider.isDark
                              ? AppTheme.primaryDark
                              : AppTheme.black,
                        ),
                      ),
                      Text(
                        timeFormat.format(event.dateTime),
                        style: textTheme.titleMedium!.copyWith(
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text('Description', style: textTheme.titleMedium),
            SizedBox(height: 8),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: settingsProvider.isDark
                      ? AppTheme.navy
                      : AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: settingsProvider.isDark
                        ? AppTheme.borderDark
                        : AppTheme.offWhite,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        event.description,
                        style: textTheme.titleSmall!.copyWith(
                          color: settingsProvider.isDark
                              ? AppTheme.grey
                              : AppTheme.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
