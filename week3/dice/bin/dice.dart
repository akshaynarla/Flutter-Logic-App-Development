import 'package:dice/dice.dart' as dice;
import 'dart:io';

void main() {
  stdout.write("How many times do you want to throw the dice?:");
  var n = int.parse(stdin.readLineSync()!);
  var myDice = dice.Dice(n, false);

  // First case: throwing dice 'n' times and printing sum statistics
  for (int idx = 1; idx <= myDice.numberOfThrows; idx++) {
    myDice.throwDice();
    print("Throw value: ${myDice.die}");
  }
  print("Sum Statistics in first case: ${myDice.sumStatistics}");
  // print(myDice.dieStatistics); tests of die statistics prints correctly or not.

  // reset call
  myDice.resetStatistics();
  print("Sum statistics is reset: ${myDice.sumStatistics}");

  // Second case: after reset of statistics
  myDice.equalDistr = true;
  for (int idx = 1; idx <= myDice.numberOfThrows; idx++) {
    myDice.throwDice();
    print("Throw value: ${myDice.die}");
  }
  print("Sum Statistics in 2nd case: ${myDice.sumStatistics}");
}
