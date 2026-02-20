import 'package:evently/Widgets/arrow_back.dart';
import 'package:evently/Widgets/default_elevated_button.dart';
import 'package:evently/Widgets/default_text_form_field.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/tabs/home/tab_itme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routName = '/CreateEventScreen';

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
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(leading: ArrowBack(), title: Text('Add event')),
      body: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${selectedCategory.imageName}.png',
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
                    label: 'Add event',
                    onPressed: createEvent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createEvent() {
    if (formkey.currentState!.validate()) {}
  }
}
