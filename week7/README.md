# dicey_navigation

An extended project from `week6` with added navigation routes as per the requirements in `week7` exercise sheet.
The sample UI image and a working video of the app is available in [imgs](/week7/imgs/)

## go_router

go_router is a package used for allowing context/route switches in the UI. With go_router flexible UI navigation of the app is smooth.
Like Dart's approach, go_router also adopts declarative coding. Although, go_router offers customizable transitions between app screens, it is not yet experimented here. Combined with Riverpod, go_router enhances UX.

- The app reuses the dice class from week5 with modifications as per Riverpod state management package.
- The routes are provided globally using Riverpod state notifier.
- A new folder `screens` has the relevant changes necessary for adding multiple screens.
- Most code has been reused with slight extended versions of previous code.
- App is relatively faster also.

Improvement points: probably better use of riverpod to avoid reading too many parameters within `Widget build ...` operations.

## Implementation of the requirements in the app

- [x] Mandatory requirements from week3, 5 and 6 --> only undo button deactivation has been a problem, all other requirements has been satisfied in the app.
- [x] No stateful widgets used for navigation --> use of riverpod for state management and go_router for navigation between screens.
- [x] 1st screen - Dice, 1000 throws, total number of throws and current mode (not switch).
- [x] 2nd screen - Visualization of statistics, total number of throws and current mode (not switch).
- [x] 3rd screen - Settings - Reset button and mode switch, total number of throws: snackbar still enabled for reset.
- [x] 4th screen - detailed statistical info about a throw (click on one of the squares in the 6x6 matrix, corresponding data and the maximum thrown pair and other detail displayed) : was not able to centre the data on screen (because of parent widget property mostly).
- [x] 5th screen - same as 4th screen but for sum statistics data.
- [x] Bottom navigation bar --> controls switching between screens
- [x] Undo button also provided in the bottom navigation bar. Does not change screens when pressed, but undoes previous action. (deactivation of button when there is nothing to undo: not done)
- [x] New screen for 4th and 5th screens mentioned above. Back button provided on top. When pressed, takes back to the visualization page.

## App Layout images
<p>
<img src='/week7/imgs/week7_por_home.png' width=150 height=300>
<img src='/week7/imgs/week7_por_vis.png' width=150 height=300>
<img src='/week7/imgs/week7_por_settings.png' width=150 height=300>
<img src='/week7/imgs/week7_por_sum.png' width=150 height=300>
<img src='/week7/imgs/week7_por_matrix.png' width=150 height=300>
</p>

## Sources Referred
- [go_router](https://docs.page/csells/go_router)
- [go_router in official flutter github repo](https://github.com/flutter/packages/tree/main/packages/go_router)
- [go_router: The essential guide](https://medium.com/@antonio.tioypedro1234/flutter-go-router-the-essential-guide-349ef39ec5b3)
- [go_router_riverpod](https://github.com/lucavenir/go_router_riverpod)
- [A beginner's guide to go_router in Flutter](https://dev.to/codemagicio/a-beginners-guide-to-gorouter-in-flutter-24ec)
