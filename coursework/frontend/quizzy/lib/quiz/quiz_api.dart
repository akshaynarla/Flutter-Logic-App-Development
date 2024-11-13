import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizzy/database/quiz_db.dart';

import 'quiz.dart';

// API method structure similar to week9/dicey/ --> fetch_cat_data.dart
// API architecture also inspired from:  https://github.com/zjhnb11/logic_quiz_App

// HttpService class now offers a singleton service like the database and manages the
// API communicatione effectively. This method was adopted for handling of cookies
// in a centralized and maintainable manner
// Reference: https://blog.logrocket.com/networking-flutter-using-http-package/
// Reference: https://stackoverflow.com/questions/52241089/how-do-i-make-an-http-request-using-cookies-on-flutter
// Reference: https://www.digitalocean.com/community/tutorials/flutter-flutter-http
class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  HttpService._internal();

  String? sessionCookie;

  // used to send get requests to server --> get data from server
  Future<dynamic> getRequest(String url) async {
    final response = await http
        .get(
          Uri.parse(url),
          headers: sessionCookie != null ? {'Cookie': sessionCookie!} : {},
        )
        .timeout(const Duration(seconds: 5))
        .catchError((error) {
      return http.Response("Timed out", 408);
    });
    _updateCookie(response);
    return _handleResponse(response);
  }

  // used to send post requests to server --> send data to server
  Future<dynamic> postRequest(String url, {dynamic body}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        ...sessionCookie != null ? {'Cookie': sessionCookie!} : {},
        'Content-Type': 'application/json',
      },
      body: body,
    );
    _updateCookie(response);
    return _handleResponse(response);
  }

  void _updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null && rawCookie.isNotEmpty) {
      sessionCookie = rawCookie.split(';').first;
    }
  }

  // all responses from server handled within the HTTP Service class
  // by handleResponse function --> private to class
  dynamic _handleResponse(http.Response response) {
    final contentType = response.headers['content-type'];
    debugPrint(
        "Handle response data: $contentType with code ${response.statusCode}");
    if (response.statusCode == 200) {
      if (contentType != null && contentType.contains('application/json')) {
        return json.decode(response.body);
      } else {
        return response;
      }
    } else {
      // in typical cases, exceptions are thrown. But in this app it
      // will be handled in UI as warnings, so the user can take appropriate action.
      debugPrint(
          'Failed to load data. Status Code: ${response.statusCode}. Response Body: ${response.body}');
      return response;
    }
  }
}

// check if the server is online, for fetching data from the server
Future<bool> isServerOnline() async {
  final httpService = HttpService();
  final response = await httpService.getRequest('http://10.0.2.2:8080/online');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

// same logic of fetching cat data in weekly tasks
// fetch quiz from the server
Future<List<Tasks>> fetchTasks() async {
  final httpService = HttpService();
  List<dynamic> jsonResponse =
      await httpService.getRequest('http://10.0.2.2:8080/tasks');
  if (jsonResponse.runtimeType == http.Response) {
    return [];
  }
  return (jsonResponse.map((json) => Tasks.fromJson(json)).toList());
}

// send quiz stats to the server
Future<void> sendStats(List<Map<String, dynamic>> stats) async {
  final httpService = HttpService();

  await httpService.postRequest('http://10.0.2.2:8080/stats',
      body: json.encode(stats));
}

// fetch stored stats of user in server database
// username would be fetched automatically based on the cookie at server end
Future<UserStatistics> fetchStats() async {
  final httpService = HttpService();
  final jsonResponse =
      await httpService.getRequest('http://10.0.2.2:8080/stats');
  return UserStatistics.fromJson(jsonResponse);
}

// login logic: send username and passcode to server to verify user
Future<bool> userLogin(String username, String passcode) async {
  final httpService = HttpService();
  // checking default user here in UI itself - no data storage for this user
  // in offline mode no stat persistence --> remove this before final push
  if (username == 'guest' && passcode == 'guest') {
    return true;
  }

  final response = await httpService.postRequest(
    'http://10.0.2.2:8080/login',
    body: jsonEncode({'username': username, 'passcode': passcode}),
  );

  // Simulating session token extraction from response
  String? sessionToken = response.headers['set-cookie'];
  if (sessionToken != null && response.statusCode == 200) {
    await QuizDatabaseProvider.instance.saveUserSession(username, sessionToken);
    return true;
  } else {
    return false;
  }
}

// user registration: send data to server to register new user and corresponding passcode
Future<bool> userRegistration(String username, String passcode) async {
  final httpService = HttpService();

  final response = await httpService.postRequest(
    'http://10.0.2.2:8080/register',
    body: jsonEncode({'username': username, 'passcode': passcode}),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

// reset passcode: used for resetting user passcode in the server database.
// existence of the username is also verified in the backend itself.
Future<bool> resetPasscode(String username, String passcode) async {
  final httpService = HttpService();

  final response = await httpService.postRequest(
    'http://10.0.2.2:8080/resetpasscode',
    body: jsonEncode({'username': username, 'passcode': passcode}),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

// user logout: send data to server to logout user if session not yet expired
// upon session expiry, automatically user is logged out / stats are not saved
Future<bool> userLogout(String? username) async {
  final httpService = HttpService();

  final response = await httpService.postRequest(
    'http://10.0.2.2:8080/signout',
    body: jsonEncode({'username': username}),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
