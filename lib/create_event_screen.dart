import 'package:evently/Widgets/action_button.dart';
import 'package:evently/Widgets/default_elevated_button.dart';
import 'package:evently/Widgets/default_text_form_field.dart';
import 'package:evently/Widgets/ui_utils.dart';
import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/tabs/home/tab_itme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routName = '/CreateEventScreen';

  final EventModel? event;
  CreateEventScreen({this.event});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int currentIndex = 0;
  CategoryModel selectedCategory = CategoryModel.categorise.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');

  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      final event = widget.event!;
      titleController.text = event.title;
      descriptionController.text = event.description;
      selectedCategory = event.category;
      selectedDate = event.dateTime;
      selectedTime = TimeOfDay(
        hour: event.dateTime.hour,
        minute: event.dateTime.minute,
      );
      currentIndex = CategoryModel.categorise.indexOf(event.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: ActionButton(iconName: 'arrow_left'),
        title: Text('Add event'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.asset(
                  'assets/images/${settingsProvider.isDark ? selectedCategory.imageName + '_dark' : selectedCategory.imageName}.png',
                  height: MediaQuery.sizeOf(context).height * 0.23,
                  width: double.infinity,
                  fit: .fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: DefaultTabController(
                length: CategoryModel.categorise.length,
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: .start,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  labelPadding: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.only(left: 16),
                  tabs: CategoryModel.categorise
                      .map(
                        (category) => TabItme(
                          lable: category.name,
                          icon: category.icon,
                          isSelected:
                              currentIndex ==
                              CategoryModel.categorise.indexOf(category),
                        ),
                      )
                      .toList(),
                  onTap: (index) {
                    currentIndex = index;
                    selectedCategory = CategoryModel.categorise[currentIndex];
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('Title', style: textTheme.titleMedium),
                    SizedBox(height: 8),
                    DefaultTextFormField(
                      hintText: 'Event Title',
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title can not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text('Description', style: textTheme.titleMedium),
                    SizedBox(height: 8),
                    DefaultTextFormField(
                      hintText: 'Event Description',
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description can not be empty';
                        }
                        return null;
                      },
                      maxLines: 5,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/date.svg',
                          height: 24,
                          width: 24,
                          fit: .scaleDown,
                        ),
                        SizedBox(width: 4),
                        Text('Event date', style: textTheme.titleMedium),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                              initialDate: selectedDate,
                              initialEntryMode: .calendarOnly,
                            );
                            if (date != null) {
                              selectedDate = date;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedDate == null
                                ? 'Choose date'
                                : dateFormat.format(selectedDate!),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/time.svg',
                          height: 24,
                          width: 24,
                          fit: .scaleDown,
                        ),
                        SizedBox(width: 4),
                        Text('Event time', style: textTheme.titleMedium),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: selectedTime ?? TimeOfDay.now(),
                            );
                            if (time != null) {
                              selectedTime = time;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedTime?.format(context) ?? 'Select time',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DefaultElevatedButton(
                      label: widget.event == null
                          ? 'Add event'
                          : 'Update event',
                      onPressed: widget.event == null
                          ? createEvent
                          : updateEvent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createEvent() {
    if (formkey.currentState!.validate() &&
        selectedTime != null &&
        selectedDate != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      EventModel event = EventModel(
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
        creatorId: FirebaseAuth.instance.currentUser!.uid,
      );
      FirebaseService.createEvent(event)
          .then((_) async {
            await Provider.of<EventsProvider>(
              context,
              listen: false,
            ).getEvents();

            Navigator.of(context).pop();
            UiUtils.showSuccessMessage('Event created successfully');
          })
          .catchError((_) {
            UiUtils.showErrorMessage('Failed to create event');
          });
    }
  }

  void updateEvent() {
    if (formkey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      EventModel updatedEvent = EventModel(
        id: widget.event!.id,
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
        creatorId: widget.event!.creatorId,
      );

      FirebaseService.getEventsCollection()
          .doc(updatedEvent.id)
          .set(updatedEvent)
          .then((_) async {
            await Provider.of<EventsProvider>(
              context,
              listen: false,
            ).getEvents();
            Navigator.pop(context);
            Navigator.pop(context);
            UiUtils.showSuccessMessage('Event updated');
          });
    }
  }
}
