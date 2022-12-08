import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification_flutter_project/ui/screens/Notification/widgets/details_page.dart';

import 'services/notification_service.dart';
import 'widgets/action_buttons.dart';
import 'widgets/custom_day_picker.dart';
import 'widgets/date_field.dart';
import 'widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationService notificationService = NotificationService();

  final int maxTitleLength = 60;
  TextEditingController _textEditingController =
      TextEditingController(text: "Business meeting");

  int segmentedControlGroupValue = 0;

  DateTime currentDate = DateTime.now();
  DateTime? eventDate;

  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay? eventTime;

  Future<void> onCreate() async {
    // InkWell();
    await notificationService.showNotification(
      id: 0,
      title: _textEditingController.text,
      body: "A new event has been created.",
      payload: jsonEncode({
        "title": _textEditingController.text,
        "body": "A new event has been created.",
      }),
    );

    // await notificationService.scheduleNotification(
    //   1,
    //   _textEditingController.text,
    //   "Reminder for your scheduled event at ${eventTime!.format(context)}",
    //   eventDate!,
    //   eventTime!,
    //   jsonEncode({
    //     "title": _textEditingController.text,
    //   }),
    // getDateTimeComponents(),
    // );

    resetForm();
  }

  Future<void> cancelAllNotifications() async {
    await notificationService.cancelAllNotifications();
  }

  void resetForm() {
    segmentedControlGroupValue = 0;
    eventDate = null;
    eventTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminders App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsPage(payload: null),
                ),
              );
            },
            icon: Icon(Icons.library_books_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Header(),
                      TextField(
                        controller: _textEditingController,
                        maxLength: maxTitleLength,
                        decoration: InputDecoration(
                          counterText: "",
                          suffix: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.grey[200],
                            ),
                            child: Text((maxTitleLength -
                                    _textEditingController.text.length)
                                .toString()),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ActionButtons(
                        onCreate: onCreate,
                        onCancel: resetForm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelAllButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.indigo[100],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cancel all the reminders",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Icon(Icons.clear),
        ],
      ),
    );
  }

  DateTimeComponents? getDateTimeComponents() {
    if (segmentedControlGroupValue == 1) {
      return DateTimeComponents.time;
    } else if (segmentedControlGroupValue == 2) {
      return DateTimeComponents.dayOfWeekAndTime;
    }
  }

  void selectEventDate() async {
    final today =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    if (segmentedControlGroupValue == 0) {
      eventDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: today,
        lastDate: new DateTime(currentDate.year + 10),
      );
      setState(() {});
    } else if (segmentedControlGroupValue == 1) {
      eventDate = today;
    } else if (segmentedControlGroupValue == 2) {
      CustomDayPicker(
        onDaySelect: (val) {
          print("$val: ${CustomDayPicker.weekdays[val]}");
          eventDate = today.add(
              Duration(days: (val - today.weekday + 1) % DateTime.daysPerWeek));
        },
      ).show(context);
    }
  }
}
