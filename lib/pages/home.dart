import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:google_calendar_synchronize/controller/controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();
  TextEditingController titleEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CalendarController.currentUser == null
                  ? Icon(Icons.person)
                  : Image.network(
                      CalendarController.currentUser!.picture as dynamic),
            ),
            Text(
              CalendarController.currentUser == null
                  ? "User2876534"
                  : CalendarController.currentUser!.name as dynamic,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: titleEditingController,
            ),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              onChanged: (val) {
                startDateTime = DateTime.parse(val as String);
              },
              onSaved: (val) {
                startDateTime = DateTime.parse(val as String);
              },
            ),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              onChanged: (val) {
                endDateTime = DateTime.parse(val as String);
              },
              onSaved: (val) {
                endDateTime = DateTime.parse(val as String);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  CalendarController.createClientId();
                  CalendarController.createEventObject(
                    summaryText: titleEditingController.text,
                    startTime: startDateTime,
                    endTime: endDateTime,
                  );
                  CalendarController.insertEvent(CalendarController.event);
                },
                child: Text("Add"))
          ],
        ),
      ),
    );
  }
}
