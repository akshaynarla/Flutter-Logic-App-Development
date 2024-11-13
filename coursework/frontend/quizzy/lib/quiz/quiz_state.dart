import 'package:quizzy/quiz/quiz.dart';

// QuizState manages the state of quiz for one session
// sessionScore     --> used for storing the user score in the current session
// sessionCount     --> for tracking the number of sessions
// currentTaskIndex --> for tracking the task position in the fetched tasks list
// selectedOptionIdx --> for getting the selected choice index during quiz
// currentUser      --> for getting the logged in user name
// taskStatus       --> Task ID to status mapping
// quizStatus       --> enum to manage question state
// quizMode         --> enum to manage the mode of quiz
// tasks            --> list of tasks for 1 session
// selectedOptionsList --> track all the answers given by the user in a session
class QuizState {
  final int sessionScore;
  final int? sessionCount;
  final int currentTaskIndex;
  final int? selectedOptionIndex;
  final String? currentUser;
  final Map<int, bool> taskStatus;
  final QuizStage quizStatus;
  final QuizMode quizMode;
  final List<Tasks>? tasks;
  final List<int?> selectedOptionsList;

  QuizState({
    required this.sessionScore,
    this.sessionCount,
    required this.currentTaskIndex,
    this.selectedOptionIndex,
    this.currentUser,
    required this.taskStatus,
    this.quizStatus = QuizStage.initial,
    this.quizMode = QuizMode.normal,
    this.tasks,
    required this.selectedOptionsList,
  });

  // init quiz state
  factory QuizState.initial() => QuizState(
        sessionScore: 0,
        currentTaskIndex: 0,
        selectedOptionIndex: 0,
        currentUser: null,
        taskStatus: {},
        tasks: [],
        selectedOptionsList: List.filled(10, 0, growable: false),
      );

  QuizState copyWith({
    int? sessionScore,
    int? sessionCount,
    Map<int, bool>? taskStatus,
    QuizStage? quizStatus,
    QuizMode? quizMode,
    int? currentTaskIndex,
    int? selectedOptionIndex,
    String? currentUser,
    List<Tasks>? tasks,
    List<int?>? selectedOptionsList,
  }) {
    return QuizState(
      sessionScore: sessionScore ?? this.sessionScore,
      sessionCount: sessionCount ?? this.sessionCount,
      taskStatus: taskStatus ?? this.taskStatus,
      quizStatus: quizStatus ?? this.quizStatus,
      quizMode: quizMode ?? this.quizMode,
      currentTaskIndex: currentTaskIndex ?? this.currentTaskIndex,
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      currentUser: currentUser ?? this.currentUser,
      tasks: tasks ?? this.tasks,
      selectedOptionsList: selectedOptionsList ?? this.selectedOptionsList,
    );
  }
}

enum QuizStage {
  initial,
  inProgress,
  completed,
}

enum QuizMode {
  timed,
  normal,
}
