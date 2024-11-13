# quizzy

A Flutter project for a propositional logic quiz application. This page provides necessary information for running the frontend for the quizzy app. The frontend or UI is written in Flutter framework using Dart language. Mostly, the concepts used during weekly tasks have been reused. New concepts include - Nested Navigation, Stateful Shell Routing, widget binding at app start with provider scope and providing API with HttpService class. Comments are also provided in code for better understanding. The frontend architecture is inspired from several apps as well as internet resources which are mentioned in the references section. The code from these sources are modified to match the current specifications. App layout images are available in the folder [imgs](/coursework/frontend/imgs/)
- The UI has been developed with Flutter>3.1.1 and tested on an Android Emulator (Pixel4a with API 34 (latest or atleast 2023 version)).
- In the following context, offline indicates server is not running. The app is independent of internet connectivity and depends only on if the server is running or not.

<figure>
    <img src="/coursework/frontend/imgs/app_init.png" width="100" height="200">
</figure>
<figure>
    <img src="/coursework/frontend/imgs/login_page.png" width="100" height="200">
</figure>
<figure>
    <img src="/coursework/frontend/imgs/home_page.png" width="100" height="200">
</figure>
<figure>
    <img src="/coursework/frontend/imgs/timed_quiz.png" width="100" height="200">
</figure>
<figure>
    <img src="/coursework/frontend/imgs/quiz_review.png" width="100" height="200">
</figure>
<figure>
    <img src="/coursework/frontend/imgs/stats_page.png" width="100" height="200">
</figure>

# Quiz Format
- A session contains 10 tasks.
    - Offline/Guest mode: 10 propositional logic equivalence question
    - Server mode: 10 tasks fetched from backend --> Boolean logic equivalence questions
        - Here, all questions are assumed to be of 4 variables- P, Q, R and S
        - Truth table of 4 variables must be equivalent for the correct choice and the question
- After the session ends, user can choose to review the quiz.
    - User answer and the correct answer would be displayed along with the session score.

# Functionality
The main functionality of the UI is to display tasks, manage the quiz and show users various data. It is a rather simple and easy-to-use user interface. The goal was to provide maximal functionality with minimal logical complexity.

This was achieved via -
- Clean architecture as possible with minimal providers as well.
- State management with Flutter Riverpod. [Official Documentation](https://riverpod.dev/docs/introduction/why_riverpod)
- Routing within the app using go_router and the concept of StatefulShellRoute and Branch.[Reference](https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/)
- sqflite as the standalone local app database. Use of singleton approach to ensure only 1 database is available throughout the app lifecycle [Singleton: sqflite reference](https://nyonggodwill11.medium.com/flutter-sqflite-323c035dcffe)
- override at main to check if any user was logged in before app was closed
- Simpler API handling by creating a HTTPService class, inspired from [this](https://www.digitalocean.com/community/tutorials/flutter-flutter-http).
- Entire quiz state management using StateNotifier and riverpod provider for easier management of quiz. Inspired from a similar quiz app, [Trivioso](https://github.com/zg0ul/Trivioso)
- User statistic management also taken from the good practices section of official [documentation](https://pub.dev/packages/state_notifier). 

## Main features of the UI:
- Can perform in offline mode as well. No user data is stored or persisted if the user wants to login in offline mode-- Guest mode
- When connected to server, complete features of app are available:
    - New quiz everytime
    - 2 different modes - Timed and Normal
    - Persisted stats
    - Multiple sessions for a user possible (different session tokens - although not tested)
- User persistence -> can close the app and come back to see all data persisted
    - cannot do the same in middle of a quiz --> then all data is lost.
- In case the user is logged in and the server goes offline then, the data is persisted in app database and will be sent to server (as long as session is valid, else data lost). Session expiry verified while app testing.

In the following sections, details about the implementation of the UI features are provided.

## Specification comparison
Here, the specifications specified during the beginning of the project and the implementation is cross-verified.

> - [x] *Flutter framework shall be used to develop the user interface(UI).*
> - [x] *The UI shall contain a “login” screen which allows users to log onto the quizzy app home screen.*
>> User login is now possible through the developed `quiz_api.dart` or a default guest mode if app is started in offline.

> - [x] *The home screen shall provide users with the option to start a new quiz session, look at the user statistics and app user guide.*
>> Implemented as planned and as the sample image.

> - [x] *Upon “New quiz session” selection, a new screen with quiz shall be displayed. An individual session would provide 10 quiz questions/tasks.*
>> Same feature has been implemented with an added step now between mode selection and quiz screen. A "Tap to start quiz" button allows the app to fetch tasks from backend (in case server is connected) and effectively acts as a quiz prep screen for the app database.

> - [x] *The app shall run on 2 modes: timed and non-timed quiz. The mode selection shall be possible after the new quiz session selection.*
>> 2 modes provided with the selection screen after the "New Session" option.

> - [x] *The quiz screen shall provide the questions in a multiple choice format and shall be automatically generated from the back-end.*
>> The quiz is indeed MCQ with question and 3 choices --> user has to select the expression that produces the equivalent truth table of 4 variables to the provided question. More details already in Quiz Format section.

> - [x] *A countdown timer shall start when a new question is displayed, if timed quiz mode is selected. If the question is not answered before timed out, a new question shall be generated.*
>> Handled in the UI. The only new package used in the project is `timer_count_down` used for countdown of the timer. This is an easy to use package allowing user actions at the end of the countdown and robust restart or pause options.

> - [x] *Once an answer is provided, the correct answer shall be highlighted in green while the incorrect options in red.*
>> This is implemented in a slightly different manner. Instead of displaying the correct answer after the answer is provided, the quiz review is available at the end of the quiz where user can review his/her session.

> - [x] *Upon “User statistics” selection, quiz statistics of the user from previous sessions shall be displayed. This data shall be persistent.*
>> Upon stats button press, stats of the current user will be displayed. This data is persistent and can be verified by restarting the app. Provided the session is valid, this persisted data can be sent to the server upon completion of a online quiz session. Else, data is lost if the session expires.

> - [x] *The app user guide shall provide users instructions for app usage.*
>> Provided to guide the user.

> - [x] *The app shall provide a different layout for portrait and landscape mode.*
>> Implemented and tested successfully. Although layouts has been tested only on the emulator mentioned above, it should work fine on other devices as well.

> - [x] *To run the quiz offline, a set of 10 defualt quiz questions shall be used and built-in to the UI.*
>> Provided offline tasks for Guest mode.

> - [x] *The developed app shall run both online as well as offline.*
>> From the context of the developed app, online refers to when the server is running. Offline mode is provided but there are certain pre-conditions for running this. In offline mode, the 10 fixed questions would be displayed always.

> - [x] *The developed app shall be tested on android emulator.*
>> Tested only on android emulator.

> - [x] *The validity of the generated quiz shall be ensured in the server-side.*
>> Handled in backend.

> - [x] *The app shall depend on “flutter_riverpod” for state management and “go_router” for navigation between screens.*
>> Implemented as planned. Please look into `pubspec.yaml` for more details.

## Details about special packages used:
- timer_count_down -> super easy to use, customizable widget for countdown timer.
No other special packages used. All other packages are used in weekly tasks.

## sqflite for persistence

- Tables created in app local database: with column details and PK is primary key.
    - user_stats: username (PK), mode(PK), score, sessions --> 2 primary keys allows unique username-mode combination 
    - quiz: task_id (PK), question, choices, correctAns --> for holding tasks for the session, only 1 session
    - user_session: username (PK), session_token --> useful for verifying if previously user was logged in during app startup

# Running the app
The app can be run by running the unmodified code from this repo. 
The debug apk or compiled version of the frontend files should be available in the git repo of the quizzy frontend in the build/app/outputs folder.

# What's not in the UI?
- Flexibility to change countdown timer in timer mode.
- Setting difficulty level of the questions.
- Check user session validity at app restart. (This is done only with post requests from the app)
- Leaderboard or any other user's data.
- No data saved without registering. i.e, guest mode is predominantly for offline cases.
- In case, admin changes the user passcode, that is not reflected if that user is logged in i.e., doesn't logout automatically --> Reflected only on next login.
- In case of session expired, no automatic logout --> User has to signout and login again.

# Some References other than the official documentation
References are also mentioned within the code itself. There might be some missing references here that might have been mentioned in the code.
- Weekly Flutter assignments
- [Logic Quiz App reference](https://github.com/zjhnb11/logic_quiz_App)
- [Trivioso App]( https://github.com/zg0ul/Trivioso)
- [Nested Navigation/Stateful Shell Navigation](https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/)
- [Riverpod Documentation](https://riverpod.dev/docs/introduction/why_riverpod)
- [Riverpod: Code with Andrea](https://codewithandrea.com/articles/flutter-state-management-riverpod/)
- [Singleton: sqflite reference](https://nyonggodwill11.medium.com/flutter-sqflite-323c035dcffe)
- [HttpService inspiration](https://www.digitalocean.com/community/tutorials/flutter-flutter-http)
- [timer_count_down package](https://pub.dev/packages/timer_count_down)