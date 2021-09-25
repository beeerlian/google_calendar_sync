import 'dart:developer';
import 'dart:io';

import 'package:google_calendar_synchronize/const/const_key.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarController {
  static const _scopes = [scopeUrl];
  static var credentials;

  static Event event = Event();
  static EventDateTime end = EventDateTime();
  static EventDateTime start = EventDateTime();

  static void createClientId() {
    if (Platform.isAndroid) {
      credentials = ClientId(
          client_credential_key,
          "");
    } else if (Platform.isIOS) {
      credentials = ClientId(
          client_credential_key,
          "");
    }
  }

  static void createEventObject(
      {required String summaryText, required startTime, required endTime}) {
    // Create object of event
    event.summary = summaryText; //Setting summary of object

    //Setting start time
    start.dateTime = startTime;
    start.timeZone = "GMT+07:00";
    event.start = start;

    //setting end time
    end.timeZone = "GMT+07:00";
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
