# dicey_nav_extd

An extended project from `week7` with an extended tab which fetches random cat images based on the sum of the random dice throw, as per the requirements in `week8` exercise sheet.
A working video with all features tested in the app is available in [imgs](/week8/imgs/)

NOTE: To run with Chrome, normal debug and run will not fetch data from internet. This is because the chrome, by default, opens with CanvasKit. Therefore, from the terminal run `flutter run --debug -d chrome --web-renderer=html` so that chrome runs in html mode. No problem is observed with mobile emulator, because mobile apps are rendered in html by default.

## Fetching data from the internet

- Making a network request: `fetchCatData` is used to make the necessary request. Calls the necessary URL based on the dice throw sum.
- The response from the API is recorded using a `Cat` object. (Similar/Identical to the example provided in the flutter documentation)
- The `catImageProvider` is dependent on the sum of the dice throws, as can be seen in the observer. A change in sum, provides a new image while maintaining the state of the suggestion screen --> maybe improved by implementing it differently.
- The fetched image is displayed on the `suggest_screen`
- The app reuses the code from `week7` with a new screen that fetches data from internet.
- Here, `Cat API` is used to fetch random cat images based on the sum of dice. The private API key already available in the code.

Improvement points: more robust use of the api data. Including complex data items in the app.

## Implementation of the requirements in the app

- [x] Mandatory requirements from week3, 5, 6 and y --> only undo button deactivation has been a problem, all other requirements has been satisfied in the app.
- [x] Improved routing --> removed the unnecessary providers and now go_router parsing is used to pass necessary data between screens.
- [x] Timer --> shows time since last throw on the home screen, other timing detail (min time b/w throw or throw actions, max time b/w throw or throw actions, time b/w the last two throws). Precision of timer upto 100ms and in the format MM:SS:C.
- [x] New Tab --> Shows the sum of the current dice throw, fetches a cat image using `Cat API` based on the sum.

## Sources Referred
- [Fetching data from the internet](https://docs.flutter.dev/cookbook/networking/fetch-data)
- [Cat API Documentation](https://developers.thecatapi.com/view-account/ylX4blBYT9FaoVd6OhvR?report=bOoHBz-8t)
- [Web Renderers](https://docs.flutter.dev/platform-integration/web/renderers)
- [Sample Timer App](https://github.com/Henrydykee/timer_app/tree/master)
