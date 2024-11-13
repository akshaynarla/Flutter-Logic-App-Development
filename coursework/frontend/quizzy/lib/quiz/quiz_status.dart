import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/database/quiz_db.dart';
import 'package:quizzy/quiz/quiz.dart';
import 'package:quizzy/quiz/quiz_api.dart';

// structure inspired from: https://github.com/zjhnb11/ repository
// also from: https://github.com/zg0ul/Trivioso
// QuizStatus is the main controller for quiz and manages the quiz state,
// provides tasks and all necessary functionality of quiz
class QuizStatus extends StateNotifier<QuizState> {
  QuizStatus() : super(QuizState.initial());

  // checks if the username is already logged in and if logged in persists
  // the user's data
  Future<void> quizzyRestart() async {
    var userSessionData =
        await QuizDatabaseProvider.instance.getSavedUserSession();
    setCurrentUser(userSessionData['username']);
    HttpService().sessionCookie = userSessionData['session_token'];
  }

  // update the quiz state with logged in username
  // useful for maintaining user stats
  void setCurrentUser(String? username) {
    state = state.copyWith(currentUser: username);
  }

  // update task index for displaying tasks
  void updateCurrentTaskIndex(int newIndex) {
    state = state.copyWith(currentTaskIndex: newIndex);
  }

  void setSessionScore(int newSessionScore) {
    state = state.copyWith(sessionScore: newSessionScore);
  }

  // update mode of quiz (either Timed or Normal)
  void updateMode(QuizMode newMode) {
    state = state.copyWith(quizMode: newMode);
  }

  // calculate score for session by counting how many values are true in the taskStatus map
  int calculateSessionScore(Map<int, bool> taskStatus) {
    return taskStatus.values.where((status) => status).length;
  }

  // update QuizStatus to completed after the last question
  // increase user session count by 1 in quiz state, update the session score in database
  void updateQuizFin() {
    QuizDatabaseProvider.instance.addSessionScore(state.currentUser,
        state.sessionScore, state.quizMode.toString().split('.').last);
    state = state.copyWith(
      quizStatus: QuizStage.completed,
      sessionCount: (state.sessionCount ?? 0) + 1,
    );
  }

  // saves the option selected by user when "Next" button is pressed
  void selectedOption(int? index) {
    state = state.copyWith(selectedOptionIndex: index);
  }

  // method to update the options list for later evaluation
  void updateSelectedOptionsList() {
    // copy of existing state for safety
    List<int?> updatedOptionsList = List<int?>.from(state.selectedOptionsList);
    updatedOptionsList[state.currentTaskIndex] = state.selectedOptionIndex;
    state = state.copyWith(selectedOptionsList: updatedOptionsList);
  }

  // update the task status map. Helps in tracking user
  // answers and if it is correct or not
  void updateTaskStatus(int index, bool isCorrect) {
    state = state.copyWith(
      taskStatus: Map<int, bool>.from(state.taskStatus)
        ..update(index, (_) => isCorrect, ifAbsent: () => isCorrect),
    );
  }

  // reset quiz state to handle next session
  void resetQuiz() {
    state = state.copyWith(
      quizStatus: QuizStage.initial,
      sessionScore: 0,
      currentTaskIndex: 0,
      selectedOptionIndex: 0,
      taskStatus: {},
      tasks: [],
      selectedOptionsList: List.filled(10, 0, growable: false),
    );
  }

  // logout and remove user stats from local sqflite database
  Future<void> logout() async {
    await QuizDatabaseProvider.instance.clearUserSession(state.currentUser!);
    state = state.copyWith(currentUser: null);
    state = QuizState.initial();
  }

  // loadQuestions to the QuizState (this will have all necessary tasks for 1 session)
  void loadQuestions() async {
    var db = QuizDatabaseProvider.instance;
    List<Tasks> tasks = await db.getTasks();
    state = state.copyWith(tasks: tasks);
  }
}
