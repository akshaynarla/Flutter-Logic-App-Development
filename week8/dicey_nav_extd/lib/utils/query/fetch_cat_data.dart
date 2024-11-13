import 'dart:convert';
import 'cat.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

// Function to fetch data from The Cat API and return Cat objects
Future<Cat> fetchCatData(FutureProviderRef<Cat> ref, int number) async {
  final response = await http.get(
    Uri.parse(
        'https://api.thecatapi.com/v1/images/search?limit=1&page=1&category_ids=$number'),
    headers: {HttpHeaders.authorizationHeader: apiKey},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    if (data.isNotEmpty) {
      return Cat.fromJson(data[0]);
    } else {
      // here add somehow, an error 404 kind of message or image from somewhere.
      return Cat(imageUrl: 'https://placekitten.com/200/300');
    }
  } else {
    return Cat(imageUrl: 'https://via.placeholder.com/150');
  }
}
