import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// by default, dart main() function.
// Therefore, flutter also has these.
// runApp creates the widget "MyApp" on the widget tree root.
void main() {
  runApp(MyApp());
}

// UI done via Widgets.
// Every widget has build method --> tells what the app contains
class MyApp extends StatelessWidget {
  // by using "super" you are calling the constructor of StatelessWidget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return type of the widget
    return ChangeNotifierProvider(
      create: (context) =>
          MyAppState(), // create initial state for the entire app as defined in the MyAppState class.
      child: MaterialApp(
        title: 'My Namer App',
        theme: ThemeData(
          useMaterial3:
              true, // for visualizing the buttons/UI or basically color theme selection
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        ),
        home: MyHomePage(), // home page of the app
      ),
    );
  }
}

// manages state of the app using "ChangeNotifier".
// Here any changes are notified to the user and
// can be used to update the app or other listeners.
class MyAppState extends ChangeNotifier {
  // random word selection at the start of the app
  var current = WordPair.random();

  void getNext() {
    // generates a random word
    current = WordPair.random();
    notifyListeners();
  }

  // to add favorites tab and list of favorite words
  var favorites = <WordPair>[];
  // hold history elements
  var history = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      // add if liked
      favorites.add(current);
    }
    notifyListeners();
  }

  void addHistory() {
    history.add(current);
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}

// watches the MyAppState and catches any changes
// rebuilds every time the MyAppState changes
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  // Widget --> adds it to the tree
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // app's font theme copied here
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    Widget page;
    switch (selectedIndex) {
      case 0:
        // if home button pressed --> display GeneratorPage()
        page = GeneratorPage();
      case 1:
        // if like button pressed --> Placeholder() page initially
        // then developed new page
        page = FavoritesPage();
      case 2:
        // if history button pressed --> go to history page
        page = HistoryPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          // 2 children now - SafeArea (hosts the navigation tab) and Expanded (hosts the main page)
          // row = safearea + expanded, on the window
          // safearea takes only the necessary space, while expanded takes as much space as possible
          children: [
            SafeArea(
              // navigation rail on the left side of the screen by default
              child: NavigationRail(
                // if the navigation bar has to be extended or not. Extends only if width of the screen is greater than 600
                // makes the UI responsive
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorite Words'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.history),
                    label: Text('History tab'),
                  ),
                ],
                selectedIndex: selectedIndex,
                // based on the click, what must happen
                onDestinationSelected: (value) {
                  // currently prints the value of the navigation rail selected
                  // This has to be changed to display the new tab, maybe here state has to be changed
                  // print('selected: $value'); here output was in debug console
                  setState(() {
                    // this changes the box in UI, since the state is now being changed based on the value
                    selectedIndex =
                        value; // only selection done here --> has to be modified to create a new layout, therefore new widget
                  });
                },
              ),
            ),
            Expanded(
              // now a container box holding the previous home page widget i.e., GeneratorPage
              child: Container(
                color: theme.colorScheme.primaryContainer,
                // displays the selected page based on the switch statement
                child: page,
              ),
            ),
          ],
        ),
        appBar: AppBar(
          // better option is to use it in a class that doesn't have
          // to be recompiled, since this doesn't change
          centerTitle: true,
          title: Text(
            'Random WordGen',
            style: style,
            softWrap: true,
            textScaleFactor: 0.5,
          ),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.green,
      );
    });
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // watch the state and catch the changes and rebuilds the code
    var appState = context.watch<MyAppState>();
    // return list of all words generated so far
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text('You have generated ${appState.history.length} words')),
        for (var pair in appState.history)
          ListTile(
            leading: Icon(Icons.history),
            title: Text(pair.asPascalCase),
          )
      ],
    );
  }
}

// Widget for Favorite tab
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // watch the state and catch the changes and rebuilds the code
    var appState = context.watch<MyAppState>();
    // return list of favorite words based on change of the appState
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text('You have ${appState.favorites.length} favorites:')),
        for (var pair in appState.favorites)
          ListTile(
            // leading the list would be an icon button, which has remove favorite option
            leading: IconButton(
              icon: Icon(
                Icons.delete_outline,
                semanticLabel: 'Delete',
              ),
              color: Colors.green,
              onPressed: () {
                appState.removeFavorite(pair);
              },
            ),
            title: Text(pair.asPascalCase),
          )
      ],
    );
  }
}

// basically a new class derived for home page.
// The previous MyHomePage has this structure and now it is replaced by new UI layout
class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // watch the state and catch the changes and rebuilds the code
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    // to add icons use this
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      // wrapping everything with center, centers all widgets below it
      child: Column(
        // moves the children down to center of the column
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('A random word:'),
          // displays the generated random word
          PlacardDisplay(pair: pair),
          // Widget adds space in between
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Adding a button and defining what to do with the button press
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like!!'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // print('button pressed!');
                  // when button is pressed, next random word is generated and
                  // changes can be observed
                  appState.getNext();
                  appState.addHistory();
                },
                child: Text('Press Me!!'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// auto-generated class body after refactoring a widget to extract this widget
// use refactor --> wrap with a widget or so on to make design changes in the UI.
// easier to refactor and manipulate, than type. Design Layout becomes very important.
class PlacardDisplay extends StatelessWidget {
  const PlacardDisplay({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    // app's current theme data (from the tree)
    final theme = Theme.of(context);
    // app's font theme copied here
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    // Widget returns the center card with text
    return Card(
      color: theme.colorScheme.inversePrimary,
      // adds elevation to the card, can be seen as shadow
      elevation: 54,
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Text(
          pair.asPascalCase,
          style: style,
        ),
      ),
    );
  }
}
