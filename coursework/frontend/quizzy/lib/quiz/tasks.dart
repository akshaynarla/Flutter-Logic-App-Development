class Tasks {
  final int taskId;
  final String question;
  final List<String> choices;
  final int correctAns;

  Tasks({
    required this.taskId,
    required this.question,
    required this.choices,
    required this.correctAns,
  });

  // constructor for extracting data from JSON key-value pairs and create a new Tasks object.
  factory Tasks.fromJson(Map<String, dynamic> json) {
    List<String> parsedChoices;
    if (json['choices'] is String) {
      parsedChoices = (json['choices'] as String).split(',');
    } else if (json['choices'] is List) {
      parsedChoices =
          List<String>.from(json['choices'].map((choice) => choice.toString()));
    } else {
      parsedChoices = [];
    }
    return Tasks(
      taskId: json['task_id'],
      question: json['question'] ?? '',
      choices: parsedChoices,
      correctAns: json['correctAns'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'question': question,
      'choices': choices.join(','),
      'correctAns': correctAns,
    };
  }
}
