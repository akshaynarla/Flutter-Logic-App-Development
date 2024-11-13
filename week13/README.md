# Building an HTTP app with Golang
An application that listens to HTTP requests and responds to them. In the following documentation, a stepwise understanding of the application development is provided. A test-driven development is done here, where test functions are written and tested and improvised to handle general cases. Comments are also present in the code for better understanding.

- STEP 0: Create a directory for your go app and run `go mod init`.

- STEP 0.5: To run tests, run `./server_test.go` from terminal and the VS code will then allow you to run the tests from VS Code editor. A new Test Results tab will open and run your tests.

- STEP 1: Creating a `server_test.go` file with hard-coded values for necessary functions.
Code from the tutorial mimics a server that responds to requests. Here, `TestGETPlayers` takes 2 arguments initially but the function `PlayerServer` is not defined.
Output of STEP 1: You get `undefined: PlayerServer` error while development. --> defining the `PlayerServer`

- STEP 1.5: A new `server.go` with `PlayerServer` which has no arguments is defined.
Output of STEP 1.5: too many arguments in call to PlayerServer. --> fix or add necessary parameter to function definition
If function body is not provided, you will also get no return error --> add function body to have a return

- STEP 2: Once the missing arguments are added and the function body is written, tests will pass and you see a PASS status on the Test Results tab.

- STEP 3: Writing the main program and developing the application.
Use `go build` to take all `.go` files and builds you a program, which can be then run with `./myprogram` or generates an executable version of your developed app.

- STEP 4: Write a new test for getting data of the 2nd player Floyd now. Refactor the function for getting the player score.
Here, now Floyd's test will fail, since the current server provides only 20 while Floyd needs 10. You get `got "20", want "10"` failure message. --> Fixed by updating the server function to now return 10 when the player is Floyd. This is done by reading the URL. Still naive approach and not generalized. Step-by-step building here.

- STEP 5: Generalize and avoid redo-ing similar code. Refactor it for better handling.

- STEP 6: Refactoring the server to avoid it already knowing the score. It has to fetch data now for each player.
Too many positional arguments for PlayerServer in the test --> fix by creating a new instance of PlayerServer and call its method `ServeHTTP`.
You get an error in the `main.go` that PlayerServer is not an expression --> also same as above.

- STEP 6.5: All compilation is fine but test run gives `panic: runtime error: invalid memory address or nil pointer dereference.`
The above error is obtained after following steps until 6 in the Test Results. --> fixed with the new code in `server_test.go`
Now the test run passes and all data is correct.  We're telling the reader that because we have this data in a PlayerStore that when you use it with a PlayerServer you should get the following responses.

- STEP 7: Run your app by building its executable and running it. By running `http_app.exe` created after building, the server starts. But now the server page doesn't respond and returns no data. This is because we have not passed a PlayerStore yet.
--> Dummy function created in main file.
Now rebuild the app and run it and go to the link: http://localhost:5000/players/Pepper this hits the server and should return 123 now. It always returns 123 since we have not yet stored any data.

- STEP 8: Handling missing data. Now a new test for a person that is not in the list is added. returns got status 200 want 404. i.e., you were supposed to get a 404 error but got something else in return since we have 123 being returned. Add conditional checks to handle the http response as per the stored data. (See code for more info)

- STEP 9: Storing the scores. Basic test approach. A dummy function is writter to test the post operation of http. When STEP 9 test is run, you get "did not get correct status, got 404, want 202" --> can be fixed with an if statement now in the server, which will set header to accept status when something is posted.

- STEP 9.5: Code refactoring to allow better understanding of post and get methods

- STEP 10: Extending the test further to record wins now (Refer STEP 10)
You get the following compiler error: "too few values in struct literal of type StubPlayerStore" --> Add the struct element/field wherever it is being referenced.
Output of STEP 10: got 0 calls to RecordWin want 1.
To make it pass: add RecordWin in PlayerStore and call it where necessary. (run the individual test. The small run test above the sub-test run)

- STEP 11: make changes to the post test, to see how storing works currently.
You get error: did not store correct winner got "bob" instead of "pepper" --> because the record win is hard-coded currently with Bob. Has to update it to be the actual player.

- STEP 12: Refactor code to avoid duplicates. Code optimization.

This is the end of technical implementation based on the HTTP server tutorial in quii gitbook.

Running the integration test: Run the test script created. You will get --> response body is wrong, got "123" want "3". Now everything works well and the tests pass.

## Takeaways
- `http.Handler` --> allows creation of web servers now.
- `httptest.NewRecorder` --> to pass in as a ResponseWriter to let you spy on the responses from handler
- TDD is a proven approach in efficient and error-free Golang coding.

# Extending the code with JSON, Routing and Embedding
Here, an extension to the above app is made. A new endpoint called `/league` is to be added, which returns a list of all players stored as JSON. Also, acts as a model for the coursework Quizzy app.

- STEP 1: To the above code, add a new test. TestLeague. Initially, you get a 404 error because there is no league. No hit for /league and getting an OK back. Here, the current program considers league to be an unknown player (Only Pepper and Floyd known now) --> fixed by a built-in routing mechanism called `ServeMux` which attaches handler to particular request paths. Routing wrapped in the server and the test passes now.

- STEP 2: Refactoring of the `ServeHTTP` function in the `server.go` for better readability. The NewServer function now allows HTTP handling in an easier manner. Embedding of `PlayerServer` now allows it to have all the properties or functionalities of the `http.Handler`. This particularly allows the admin to add routes and not the players. In case ServeMux was used like shown in the `server.go` file (commented part), each PlayerServer would be able to add new routes since it will be public. Embedding the handler avoids this problem.

- STEP 3: Returning some JSON. Need to parse JSON data and decode it for our data model to process it.
By looking at the code and running the created test, "Unable to parse response from server "" into slice of Player, 'EOF'" error is obtained. --> endpoint doesn't return a body to be parsed into JSON. --> fixed by encoding the data to be entered on the JSON file.

- STEP 4: Asserting the league table with few number of players and verifying. Update the stub in test and run a test run. 
`got [{Chris 20}] want [{Cleo 32} {Chris 20} {Tiest 14}]`--> error fixed by updating the data struct so anyone passing us in a PlayerStore can provide us with the data for leagues. After all the updates and new helpers in test, all tests passed now. (Test individual tests)

- STEP 5: Ensuring content-type header is returned in the response for the machines to recognize the JSON.
After initial test you get "response did not have and so on" --> fix by updating the leagueHandler.

These 2 turorials provide an overview of setting up a server with a TDD approach. Allows in manipulating the server side for extracting user data by means of URL (parse user as URL and get corresponding data)

# Code

- Go from `main.go` to understand the entire concept. Follow it thread-by-thread.
- Has a lot of comments, commented code, which allows tracking the step-by-step approach and helps in better understanding of the code although cluttered.
- When the executable is executed, the server will be up and running and responds to the URL/http requests.
- Once the logic of http server functions, the code is relatively easy to understand.
- The written test-runs test the written server. The test-runs requests server for services and based on the responses, provides pass or fail. So, by running the tests written you can verify server functionality.

# References
- [Learn Go with Tests - HTTP Server](https://quii.gitbook.io/learn-go-with-tests/build-an-application/http-server)
- [Learn Go with Tests - JSON](https://quii.gitbook.io/learn-go-with-tests/build-an-application/json)