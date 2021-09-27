import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_calendar_synchronize/const/const_key.dart';
import 'package:google_calendar_synchronize/model/user_profile.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:url_launcher/url_launcher.dart';

class CalendarController {
  static const scopes = [calendarScope, authProfileScope];
  static var credentials;
  static auth.AuthClient? client;
  static UserFromGoogle? currentUser;

  static Event event = Event();
  static EventDateTime end = EventDateTime();
  static EventDateTime start = EventDateTime();

  static void createClientId() {
    if (Platform.isAndroid) {
      credentials = auth.ClientId(client_credential_key, "");
    } else if (Platform.isIOS) {
      credentials = auth.ClientId(client_credential_key, "");
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
      var calendar = CalendarApi(client as dynamic);
      String calendarId = "primary";
      calendar.events.insert(event, calendarId).then((value) {
        print("ADDEDDD_________________${value.status}");
        if (value.status == "confirmed") {
          log('Event added in google calendar');
        } else {
          log("Unable to add event in google calendar");
        }
      });
    } catch (e) {
      log('Error creating event $e');
    }
  }

  static loginWithGoogle(BuildContext context) {
    createClientId();
    try {
      auth
          .clientViaUserConsent(credentials, scopes, prompt)
          .then((auth.AuthClient authClient) async {
        currentUser = await getGoogleUserData(authClient);
        client = authClient;

        log("LOGIN SUCCESS");

        Navigator.pushReplacementNamed(context, "/home");
      });
    } catch (e) {
      log("LOGIN FAILED");
    }
  }

  static getGoogleUserData(auth.AuthClient authClient) async {
    final response = await authClient.get(
        Uri.parse("https://www.googleapis.com/oauth2/v1/userinfo?alt=json"),
        headers: {
          "Authorization": authClient.credentials.accessToken.toString()
        });

    var jsonData = jsonDecode(response.body);
    log("res : ${jsonData}");
    return UserFromGoogle.fromJson(jsonData);
  }

  static void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
