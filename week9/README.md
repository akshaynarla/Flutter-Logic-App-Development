# dicey

An extended project from `week8` with persistence of the app state using database, as per the requirements in `week9` exercise sheet. This `dicey` app has been run as a standalone app in the android emulator with all functionalities working as per the mandatory requirements.
A working video with all features tested in the app is available in [imgs](/week9/imgs/)

NOTE: The app is tested only on an android phone, since Windows required a different package for managing databases.

## Persisitng the state of the app
- Init 3 different databases --> used to store sum statistics, throw statistics and the number of throws. 
- querying and loading of data in the dice class. 
- `saveStatistics`: method to save statistics onto the 3 database.
- `loadStatistics`: method to load saved data from database onto the app.
- Use of async-await for databases.
Improvement points: more robust use of the api data. Including complex data items in the app.

## Implementation of the requirements in the app and learnings

- [x] Mandatory requirements from week3, 5, 6, 7 and 8 --> only undo button deactivation has been a problem, all other requirements has been satisfied in the app.
- [x] Improved state persistence --> currently if the undo is the last action before closing the app, the state of undo is not persisted when the app is opened again. (i.e, whatever stats was before the undo, will be persisted)
- Tried to debug this bug, but could not.(Approach: tried to saveStatistics during undo action, but not possible here)

## Sources Referred
- [Persisting data with SQLite](https://docs.flutter.dev/cookbook/persistence/sqlite)
- [Flutter SQFlite Guide](https://blog.devgenius.io/flutter-sqflite-the-complete-guide-88ee2ae999f2)
- [sqflite-github](https://github.com/tekartik/sqflite)
- [sqflite-example](https://github.com/alextekartik/flutter_app_example/tree/master/notepad_sqflite)