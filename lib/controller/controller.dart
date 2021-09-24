import 'dart:developer';
import 'dart:io';

import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarController {
  static const _scopes = ["https://www.googleapis.com/auth/calendar"];
  static var credentials;

  static Event event = Event();
  static EventDateTime end = EventDateTime();
  static EventDateTime start = EventDateTime();

  static void createClientId() {
    if (Platform.isAndroid) {
      credentials = ClientId(
          "957984339321-5v211cci6sb4focih7eio7ogjqndligf.apps.googleusercontent.com",
          "");
    } else if (Platform.isIOS) {
      credentials = ClientId(
          "957984339321-5v211cci6sb4focih7eio7ogjqndligf.apps.googleusercontent.com",
          "");
    }
  }

  static void createEventObject(
      {required String summaryText, required startTime, required endTime}) {
    // Create object of event
    event.summary = summaryText; //Setting summary of object

    //Setting start time
    start.dateTime = startTime;
    start.timeZone = "GMT+05:00";
    event.start = start;

    //setting end time
    end.timeZone = "GMT+05:00";
    end.dateTime = endTime;
    event.end = end;
  }

  static insertEvent(event) {
    try {
      clientViaUserConsent(credentials, _scopes, prompt)
          .then((AuthClient client) {
        var calendar = CalendarApi(client);
        String calendarId = "primary";
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      });
    } catch (e) {
      log('Error creating event $e');
    }
  }

  static void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
