import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

void main() {
  // single-route entry point
  runApp(const MyApp());
}

// Define the App structure and theme. Here, we use MaterialApp as the backbone.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
            useMaterial3: true),
        // darkTheme: ThemeData.dark(useMaterial3: true),
        // home page would be a stateful "MyHomePage" widget
        home: const MyHomePage(title: 'Dicey!!'),
      ),
    );
  }
}

// MyAppState class replicates the dice class from week3.
// The structure of the code follows the "First Flutter Approach" and
// hence a similar structure is retained here as well.
// All interfaces related to the dice are defined here because the dice and
// it's related elements(its changes) decide the state of the app.
class MyAppState extends ChangeNotifier {
  int diceOne = 1;
  int diceTwo = 1;
  static int maxDie = 6;
  int numOfThrows = 0;
  bool equalDist = false;

  List<int> sumStatistics = List.filled((2 * maxDie) - 1, 0);
  List<List<int>> dieStatistics =
      List.generate(maxDie + 1, (i) => List<int>.filled(maxDie + 1, 0));

  void throwDice(bool equalD) {
    if (equalD) {
      // random selection of a sum from possible 2 to 12
      final selectedSum = Random().nextInt((2 * maxDie) - 1) + 2;

      // use the list to randomly select a die combination for the randomly selected sum.
      diceOne = Random().nextInt(maxDie) + 1;
      diceTwo = max(1, min(6, selectedSum - diceOne));
    } else {
      // generate random dice output on each dice.
      // switch works just fine. Tested with breakpoints
      diceOne = Random().nextInt(maxDie) + 1;
      diceTwo = Random().nextInt(maxDie) + 1;
    }
    int sum = diceOne + diceTwo;
    numOfThrows++;
    sumStatistics[sum - 2] += 1;
    dieStatistics[diceOne - 1][diceTwo - 1]++;
  }

  // reset all statistics
  void resetStatistics() {
    numOfThrows = 0;
    sumStatistics = List.filled((2 * maxDie) - 1, 0);
    dieStatistics =
        List.generate(maxDie + 1, (i) => List<int>.filled(maxDie + 1, 0));
  }

// make 1000 die throws
  void throwThousand() {
    for (int i = 0; i < 1000; i++) {
      throwDice(equalDist);
    }
  }
}

// Class/Widget defines the home page and its contents. It's a stateful widget
// since there can be change in the state of the dice and its statistics
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // Fields in a Widget subclass are always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Layouts could have been a different class or on different file altogether.
// But there are dependencies that do not allow to extract them as a widget.
// State handling widget. All state changes and other actions are handled here.
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // Layout builder for handling the portrait or landscape mode
    return LayoutBuilder(
      builder: (context, constraints) {
        // Landscape mode for phones. If you need to run on a PC,
        // probably use of width and height is much suitable.
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              centerTitle: true,
            ),
            body: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Enable Equal Distribution of Sum:'),
                              Switch(
                                value: appState.equalDist,
                                onChanged: (value) {
                                  setState(() {
                                    appState.equalDist = value;
                                  });
                                },
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                appState.throwDice(appState.equalDist);
                              });
                            },
                            child: DiceDisplay(
                                diceOne: appState.diceOne,
                                diceTwo: appState.diceTwo),
                          ),
                          Text(
                              'Number of Throws(since last reset): ${appState.numOfThrows}'),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      final snackBar = SnackBar(
                                        content: const Text(
                                            'Do you want to reset all stats?'),
                                        duration: Duration(seconds: 1),
                                        action: SnackBarAction(
                                          label: 'Confirm',
                                          onPressed: () {
                                            setState(() {
                                              appState.resetStatistics();
                                            });
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Text('Reset')),
                                // needs space
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        appState.throwThousand();
                                      });
                                    },
                                    child: Text('Make 1000 throws')),
                              ]),
                        ]),
                  ),
                  // Display sum statistics with hovering display on snackbox
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text('Sum Statistics of the thrown pair of dice:'),
                        DiceSumDisplay(appState: appState),
                        SizedBox(
                          height: 10,
                        ),
                        // displaying the 6x6 matrix
                        Text('Die Outcome Heatmap:'),
                        DiceMatrixDisplay(appState: appState),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox.square(
                        dimension: 2,
                      ),
                    ],
                  )
                ]),
          );
        }
        // portrait mode layout
        else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              centerTitle: true,
            ),
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Enable Equal Distribution of Sum:'),
                  Switch(
                    value: appState.equalDist,
                    onChanged: (value) {
                      setState(() {
                        appState.equalDist = value;
                      });
                    },
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    appState.throwDice(appState.equalDist);
                  });
                },
                child: DiceDisplay(
                    diceOne: appState.diceOne, diceTwo: appState.diceTwo),
              ),
              Text(
                  'Number of Throws(since last reset): ${appState.numOfThrows}'),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: const Text('Do you want to reset all stats?'),
                        duration: Duration(seconds: 1),
                        action: SnackBarAction(
                          label: 'Confirm',
                          onPressed: () {
                            setState(() {
                              appState.resetStatistics();
                            });
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text('Reset')),
                // needs space
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        appState.throwThousand();
                      });
                    },
                    child: Text('Make 1000 throws')),
              ]),
              // Display sum statistics with hovering display on snackbox
              Text('Sum Statistics of the thrown pair of dice:'),
              DiceSumDisplay(appState: appState),
              SizedBox(
                height: 10,
              ),
              // displaying the 6x6 matrix
              Text('Die Outcome Heatmap:'),
              DiceMatrixDisplay(appState: appState)
            ]),
          );
        }
      },
    );
  }
}

// Widget for displaying the sum statistics. If a container is clicked here,
// then a snackbar is displayed with corresponding sum count.
class DiceSumDisplay extends StatelessWidget {
  const DiceSumDisplay({
    super.key,
    required this.appState,
  });

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 0.05 * MediaQuery.of(context).size.height),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: appState.sumStatistics.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${appState.sumStatistics[index]}'),
                duration: Duration(seconds: 1),
              ));
            },
            child: Container(
              color: Color.fromARGB(
                  255,
                  (255 *
                          appState.sumStatistics[index] ~/
                          (appState.numOfThrows + 1))
                      .clamp(0, 255),
                  255 -
                      (255 *
                              appState.sumStatistics[index] ~/
                              (appState.numOfThrows + 1))
                          .clamp(0, 255),
                  150),
              padding: EdgeInsets.all(6),
              // child: Text('${appState.sumStatistics[index]}'),
            ),
          );
        },
      ),
    );
  }
}

// Widget for displaying the Dice
class DiceDisplay extends StatelessWidget {
  const DiceDisplay({
    super.key,
    required this.diceOne,
    required this.diceTwo,
  });

  final int diceOne;
  final int diceTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      // display dice in the home page
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 0.24 * MediaQuery.of(context).size.width,
          height: 0.24 * MediaQuery.of(context).size.height,
          child: FittedBox(
            child: Image.asset(
              'images/dice$diceOne.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 0.1 * MediaQuery.of(context).size.height,
          height: 0.1 * MediaQuery.of(context).size.height,
        ),
        SizedBox(
          width: 0.24 * MediaQuery.of(context).size.width,
          height: 0.24 * MediaQuery.of(context).size.height,
          child: FittedBox(
            child: Image.asset(
              'images/dice$diceTwo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

// Widget for displaying the dieStatistics matrix on the app.
// With use of ListView.builder, the hovering option can be implemented, but
// requires significant changes to the current (initial) approach.
// Room for improvement
class DiceMatrixDisplay extends StatelessWidget {
  const DiceMatrixDisplay({
    super.key,
    required this.appState,
  });

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.7 * MediaQuery.of(context).size.width,
      height: 0.3 * MediaQuery.of(context).size.height,
      // Generate a table with 6 rows and each row then taking 6 columns
      // (containers here) using List.generate. Containers are colored based
      // on the dieStatistics value.
      child: Table(
          children: List.generate(
              6,
              (rowIndex) => TableRow(
                  children: List.generate(
                      6,
                      (colIndex) => Container(
                            color: Color.fromARGB(
                                255,
                                (255 *
                                        appState.dieStatistics[rowIndex]
                                            [colIndex] ~/
                                        (appState.numOfThrows + 1))
                                    .clamp(0, 255),
                                255 -
                                    (255 *
                                            appState.dieStatistics[rowIndex]
                                                [colIndex] ~/
                                            (appState.numOfThrows + 1))
                                        .clamp(0, 255),
                                150),
                            padding: EdgeInsets.all(6),
                            child: Text(
                                '${appState.dieStatistics[rowIndex][colIndex]}'),
                          ))))),
    );
  }
}
