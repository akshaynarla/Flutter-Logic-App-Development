# Description of developed software for week3 exercise
A command-line application called "dice" with an entrypoint (main function that executes Q2 from the exercise sheet) in `bin/`, library code (class definition as per Q1 of the exercise sheet) in `lib/`.

The class "Dice" is defined in `lib/` folder within the `dice/` directory.
The use of maxDie in all the calculations allow the program to run without need of change of any code lines (except, ofcourse maxDie value). The main function in the `bin/` folder runs the program sequence specified in Q2. A sample output is shown below.
<p>
 <img src="/week3/img/ouptut.png" width=400 height=300>
</p>

Once `dart run` is given from the directory, the app is built.
The command line displays a message `How many times do you want to throw the dice?` and waits for user input.
Once the integer input is provided, the program generates random die throws and the corresponding value is provided as `Throw value:` on the console. Then the sumStatistics is calculated and displayed as a list. Each value on the list corresponds to sum of the 2 dice from 2 to 2*maxDie. i.e., count of throws with sum=2, count of throws with sum=3 ..... count of throws with sum = 2 times maxDie.

Comments are provided in the code as well for ease of use.





