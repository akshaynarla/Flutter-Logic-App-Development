const String apiKey =
    'live_SPcQjRvZ5gWcxcSR6DkSlYrZwLEyBicGMQ1Ey1VhDqrvd9g50TOzEMg4nAYHJmiy'; // Replace 'YOUR_API_KEY' with your actual API key

class Cat {
  final String imageUrl;

  Cat({required this.imageUrl});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      imageUrl: json['url'] as String,
    );
  }
}
