# dicey_extended

An extended Flutter project for rolling a pair of dice at random. This is based on the requirements from Exercise Sheet-6. Refer the app images and video clip added in the folder [imgs](/week6/imgs/)

NOTE: It is recommended to run the `dicey_extended` separately and not from the parent `assignments` or `week6` folder.

## Riverpod

The app reuses the dice class from week5 with modifications as per Riverpod state management package. A new `dice.dart` file is created, similar to the first exercise sheet and used here to provide dice functionalities. The main goal of the task is to refactor the app into appropriate widgets and use the Riverpod state management system.
After the refactoring, the entire app was modified with `Riverpod` state management instead of the traditional `provider` state management used in `week5`. 
- Easy state management since the classes are declared globally and can be easily referenced (using various available `Providers`) wherever needed by using `ConsumerWidget` (Combination of Consumer and StatelessWidget)
- Only necessary rebuilds during change --> app is faster now.

## Implementation of requirements in the app

### Basic Requirements
- [x] Refactor flutter app from `week5` --> refactored into various widgets and each widget is a new file now. (all mandatory requirements from `week5` are now refactored and working fine)
- [x] App runs on Chrome as well as Android emulator.
- [x] Relies only on stateless widgets --> only stateless widgets used and state management by Riverpod. (use of `ChangeNotifier` for the dice class and `StateNotifier` for use of dice states for undo and redo)
- [x] no failures in any screen size --> if goes beyond a range, overflow by small amounts of pixels. Most standard size --> works well.

### Functional requirements
- [x] Undo functionality --> undo functions correctly as expected. Used list of dice objects to store state (use of `StateNotifier`). Although, the deactivation of the button did not work as expected (logic as comments in the respective widget). 

### Optional requirements
- [x] Redo functionality, which undoes last undo action --> implemented redo functionality, which redoes everything except the last possible redo. (i.e., if there are 10 undoes, you can redo 9 time. Couldn't debug why it is going wrong)

## App Layout images
In Android Emulator: probably Landscape mode could've been better.
<p>
<img src='/week6/imgs/week6_android_landscape.png' >
<img src='/week6/imgs/week6_android_portrait.png'>
</p>

In Chrome: 
<p>
<img src='/week6/imgs/week6_chrome_landscape.png' >
<img src='/week6/imgs/week6_chrome_portrait.png'>
</p>

## Improvement points
- More on Riverpod --> particularly on Async related things.
- Better code structure --> reuasability
- Better and efficient state management
- Adopting light and dark mode

## Sources referred: 
- [Riverpod Documentation](https://riverpod.dev/docs/introduction/why_riverpod)
- [Diving into Riverpod](https://www.youtube.com/watch?v=BJtQ0dfI-RA&t=3165s)
- [Riverpod State Management](https://www.youtube.com/watch?v=UyepBhIY5Bo&t=524s)
- [Undo/Redo Mechanism with Riverpod](https://itnext.io/undo-redo-mechanism-with-riverpod-in-flutter-6fc15ef87b1a)
