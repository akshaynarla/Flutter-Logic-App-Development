# dicey

A Flutter project for rolling a pair of dice at random. This is based on the requirements from Exercise Sheet-5. Refer the app images and video clip added in the folder [imgs](/week5/imgs/)

## Implementation of requirements in the app

The app reuses the created dice class from week3, although it's contents are copied here. (Possibility of reusing the same file from week3 instead of copying?)

### Basic Requirements
- [x] Single-route flutter app --> implemented with a single runApp entry point.
- [x] Offline --> developed app makes use of locally stored [dice images](/week5/dicey/images/)
- [x] Intuitive --> from the perspective of developer, it looks like it. User feedback would be important
- [x] Relies only on stateless or stateful widgets
- [x] mostly uses the basic widgets available in the flutter library. No particular widget added from pub.dev

### Functional requirements
- [x] 2 dice in a row with current throw --> each covers about 25% of the width (in portrait mode) and 10% space in between them
- [x] User can click on the dice or in the vicinity to trigger a new throw --> implemented with `InkWell` widget. Initially `GestureDetector` was used, but it is particular to the widget defined in its child. Does not allow dynamic touches in the vicinity. Not a button also.
- [x] Number of throws since last reset shown
- [x] Switch implemented for enabling or disabling equal distribution of sum --> use of `Switch` widget (tested on an android emulator --> hence only this widget tested)
- [x] Reset statistics button (using `ElevatedButton`) --> `SnackBar` for 2 seconds asking confirmation of reset 
- [x] Red and Green not used. Used the theme color --> here Green color. Therefore gradients of green used to represent the count statistics. Used a primitive method based on sum of the throws and number of throws, there might be a better way of getting those colors.
- [x] Horizontal squares representing the SumStatistics --> gets updated with each throw of the dice and the color change can be noticed. (Darker the shade of green, higher the count) --> implemented with `ListView.builder` widget and recursively getting the sum values.
- [x] 6x6 grid of squares with die outcome statistics --> implemented with a primitive recursive method and normal `Table` and `TableRow` widget. Tried to improve with `ListView` but had some errors and had to switch back to primitive method.

### Optional requirements
- [ ] Organizing project in different files and directories --> followed the architecture from previous week and hence faced difficulty in refactoring a lot of classes. Tried to run all dice related aspects from a different file, but had errors again.
- [ ] Switch implementation for Android or iOS --> currently only suitable for Android. (Possibly using MediaQuery, this could be implemented)
- [ ] Dark and light mode implementation --> suitable for only light mode.
- [x] 2 different layouts implemented --> Portrait and Landscape --> using `LayoutBuilder` and using `MediaQuery`. Possible improvement by defining the widgets for portrait and landscape mode
- [x] User can click on the SumStatistics area and a snack bar pops up indicating the count for the corresponding sum position i.e., between 2 and 12. For DieStatistics, a bit complicated here as the widget is already complex.
- [ ] No images used in the app layout, other than the die images.

## App Layout images
<p>
<img src='/week5/imgs/week5_1.png'>
<img src='/week5/imgs/week5_2.png'>
</p>

Dice image source: From one of the tutorial videos [here](https://www.youtube.com/@theforgottenprogrammer7842).
Also, layout related: [Codelab](https://codelabs.developers.google.com/codelabs/flutter-boring-to-beautiful#2)
