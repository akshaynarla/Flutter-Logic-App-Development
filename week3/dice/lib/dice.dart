import 'dart:math' as math;

// class for randomly rolling 2 dice
class Dice {
  static int minDie = 1;
  static int maxDie = 6;

  // for making dice independent or dependent
  bool equalDistr;
  // list for the latest dice throw values i.e., [Dice 1, Dice 2], [1,6]. Init = [0,0]
  var die = List<int>.filled(2, 0);
  // number of throws of two dices. Ensure safety by matching numOfThrows
  int numberOfThrows;
  // array for storing sum statistics. i.e., [1,2] => 3 ==> [0,1,0.....]
  List<int> sumStatistics = List.filled((2 * maxDie) - 1, 0);
  // stores the number of occurences of die output as a 2D matrix of size maxDie x maxDie
  // maxDie+1 => so that correct number of rows is printed.
  List<List<int>> dieStatistics =
      List.generate(maxDie + 1, (i) => List<int>.filled(maxDie + 1, 0));

  Dice(this.numberOfThrows, this.equalDistr);

  void throwDice() {
    //
    if (equalDistr) {
      // distibuting sums equally
      // Local fields for calculation of possible sum from the dice
      final possibleSums =
          List.generate((2 * maxDie) - 1, (index) => index + 2);
      // random selection of a sum
      final selectedSum = possibleSums[math.Random().nextInt((2 * maxDie) - 1)];

      // List of dice combinations for a given sum value
      final combiSum = <List<int>>[];
      for (int i = 1; i <= maxDie; i++) {
        for (int j = 1; j <= maxDie; j++) {
          if (i + j == selectedSum) {
            // add all possible combinations for a given sum onto a temporary list
            combiSum.add([i, j]);
          }
        }
      }
      // use the list to randomly select a die combination for the randomly selected sum.
      die = combiSum[math.Random().nextInt(combiSum.length)];
    } else {
      // generate random dice output on each dice.
      // (Random + 1) is used. For ex: [0,6) and therefore +1 makes it [1,6]
      die[0] = math.Random().nextInt(maxDie) + 1;
      die[1] = math.Random().nextInt(maxDie) + 1;
    }
    // take the sum of the die output
    int sum = die[0] + die[1];
    // update the statistics based on the sum. [sum-2] position indicates the value.
    // i.e., for 2 6 faced die -> sum ranges between 2 to 12 [2,12];
    // sumStatistics = [Sum=2, Sum=3, Sum=4, ......, Sum=12]
    // sum is within the maxDie range, since it acts as the upper limit
    sumStatistics[sum - 2] += 1;
    // update the 2D matrix position based on the die outcome
    dieStatistics[die[0]][die[1]]++;
  }

  void resetStatistics() {
    // replace list elements with 0's
    sumStatistics = List.filled((2 * maxDie) - 1, 0);
    dieStatistics =
        List.generate(maxDie + 1, (i) => List<int>.filled(maxDie + 1, 0));
  }
}
