# Golang Generator for Quizzy
This page provides necessary information for running the automatic task generation for the quizzy app. This provides an equivalence tasks where the user has to select the equivalent choice for the generated logic. The generator is written in Golang using basic logic. Mostly, the concepts used during weekly tasks have been reused. Comments are also provided in code for better understanding.

- The server has been developed with golang 1.21.5 and tested on a Windows local machine.

# Functionality
The main functionality of the developed generator is to automatically generate tasks that will be used in the server to provide for the Quizzy frontend. The equivalent expression evaluation has to be always done as P, Q, R and S truth table and not just the values written in the question.
For example, if the expression is (P || S), then the equivalence is decided based on the P, Q, R, S or 4-variable truth table itself and not on just P-S truth table/2-variable truth table. Therefore, the quiz might be a bit time-consuming and not so straightforward.

In the following section, details about the implementation of the generator features are provided.

## Generator
Here, the specifications specified during the beginning of the project and the implementation is cross-verified.

> - [x] *The propositional logic quiz questions shall be generated automatically using Golang.*
>> A random variable/s selection is done and then they are combined with the && or || operators. 8 variables are defined with 2 operators which gives us 112 possible 2 variable combinations. Additionally, random negation of the complete expressions is also possible => 224 possible unique expressions now. The 224 unique expressions can be combined to generate more expressions. Then to generate propositions, the program combines the expressions generated based on a random number generated (1 or 2). Therefore, this program can generate a logic with 4 variables at max. This can be changed by increasing the proposition length. 

> - [x] *The multiple choices shall also be automatically generated along with the questions.*
>> For generating the choices, first a truth table for the generated proposition is created. Since, only 4 variables(P, Q, R and S and its negation make up 4 more) are used, a truth table for 4 variable(i.e, TTTT, TTTF, TTFT, TTFF ....) is created. The generated expression would then be evaluated with this truth table. i.e. in case (P || Q) is to be evaluated, it will be given the truth table for evaluation and then the corresponding truth table for the expression is obtained. After this another proposition is to be picked which produces the same truth table => logically equivalent, which will be the correct choice. Programming is done to avoid same expressions being picked and in case the truth table is not equivalent, we keep on generating new expression until an equivalent expression is found. Similar logic is applied for generating not equivalent choices as well. Shuffle the choices while keeping track of answerIndex.

> - [x] *The generated tasks shall be fetched from the server to the UI using JSON-based APIs.*
>> Structure the generated tasks onto correct data structure and provide it as a JSON file. A JSON file will be generated and is ready to be used with the server.

## Details about external packages used:
- maja42/goval --> package for expression evaluation in golang. Used for evaluating logical expessions to generate boolean logic and also the multiple choices with one correct/equivalent choice.

# Running the generator
Running the generator is fairly straight forward. Just go to the cmd folder and run `go run main.go` from the terminal (provided golang is correctly configured).

# What's not in the generator?
- An executable file. Can be generated by the user by running `go build`. This is not provided since cross platform support needs changing environment setup (i.e, exe file created in Windows might not be suitable for Linux environment). Therefore, in case the user wants to run the program, he/she can run it by `go run main.go`.

# Some References
References are mentioned within the code itself.