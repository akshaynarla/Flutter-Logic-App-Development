# Golang Server for Quizzy
This page provides necessary information for running the backend server for the quizzy app.
The backend is written in Golang with MySQL database for storage. Mostly, the concepts used during weekly tasks have been reused. New concepts include - session cookie management, database management and json handling. Only the new concpets have some new package requirements else, mostly golang base packages are used. Comments are also provided in code for better understanding. The server architecture is majorly inspired from [this reference](https://github.com/zjhnb11/logic_quiz_App) and modified to match the current specifications.

- The server has been developed with golang 1.21.5 and tested on a Windows local machine.

# Functionality
The main functionality of the developed serverside is to provide tasks to the Quizzy frontend. Additionally, it also handles the user management (login, register, signout handling), admin functionalities (via a HTML page - reset user passcode, remove user add or remove tasks, anonymous data tracking) and data storage (in the form of MySQL database for user data and stats storage).

Main features of the server:
- JSON REST based API endpoints, mainly for providing tasks to frontend.
- Unique usernames only allowed (i.e, no duplicate usernames possible) --> also handled in server
- User management included.
- Admin functionalities included --> can view top users, anonymous tracking of who is logged in at any given moment.
- MySQL used for data persistence and all necessary database handling included. (ofcourse, database has to be setup before this)

In the following sections, details about the implementation of the server features are provided.

## Server
Here, the specifications specified during the beginning of the project and the implementation is cross-verified.
### Base handlers
> - [x] *The server shall provide the quiz questions or tasks to the UI using a Golang API server.* 
>> Server provides the generated questions using the generator program to the Quizzy UI using API endpoints as defined. The tasks from the JSON file is fed into the MySQL database and will be available in the `tasks` table.

> - [x] *JSON-based REST API shall be used for communication between UI and the server.*
>> Server sends data by encoding in JSON format before sending it to the UI on `GET` requests. The received `POST` requests are also in JSON format and allows for easy data structure handling. 

> - [x] *The server shall also collect information from UI and provide it to the admin via a HTML interface.*
>> In the current server, the admin HTML provides user session tracking(with session token info and the expiry time) and top users for the admin.

> - [x] *A local database based on sqflite package (SQLite) shall be used for storing and persisting user data.*
>> For data storage, a MySQL database is used. Although SQLite database exists, this was written initially with Flutter in mind. Provided the resources available for MySQL, it was easier to use that as database. Hence, MySQL is used here for the above specification.

### User Manager
> - [x] *A new server backend based on REST API shall be implemented for login and registering users using Golang for synchronizing across devices.*
>> User management is implemented with the help of MySQL. Login is handled by comparing stored hashed passcodes for a given username and access allowed. For synchronization across devices and to manage same data for multiple logins, a session token is generated at login for the user ([Reference](https://www.sohamkamani.com/golang/session-cookie-authentication)), which allows user to get stats and tasks from the server as long as the session is valid. Since username is the primary key here, all data remains consistent as username remains same even when logging in from multiple devices. Therefore, data can be fetched in a consistent manner.

> - [x] *The admin shall be able to delete users and reset passwords.*
>> Through the admin HTML that is accessible via [localhost:8080/admin](http://localhost:8080/admin) when the server is running, the admin can delete users or reset user passcodes directly.

### Admin related
> - [x] *The server shall provide an interface to the admin to remove or add tasks/quiz questions without stopping the server.*
>> The HTML provides separate sections for the admin to add or remove tasks directly from the database without having to stop the server.

#### Details about external packages used:
- go-sql-driver/mysql --> driver for the database/sql package that allows to connect the created database in MySQL to the server. Used in `main.go` to connect to database. [Official Documentation](https://github.com/go-sql-driver/mysql)
- google/uuid --> used based on the suggestion from [this](https://www.sohamkamani.com/golang/session-cookie-authentication) reference. Mainly used to generate session tokens that is used to authenticate user communicating with the server. [Official Documentation](https://pkg.go.dev/github.com/google/uuid)

## Database
The database is created with MySQL. The setting up of database was as per this [installation guide](https://allthings.how/how-to-install-mysql-on-windows-11/). Following this, the database and tables were setup according to this [reference](https://www.mysqltutorial.org/mysql-basics/mysql-commands/). Mostly, the default configurations are retained. A new user other than the root was setup using the MySQL Workbench configuration and used to connect the server to database. But the visualization can be done via the root user as well.

- Database name: quizzy_server
- Tables created: with column details and PK is primary key.
    - user: username (PK), passcode -> in hashed form
    - user_stats: username (PK) - composite with user 'PK', mode(PK), score, sessions
    - tasks: task_id (PK), Question, Choice1, Choice2, Choice3, AnswerIndex
    - sessions: username, token (PK), expiresAt --> unique token allows same users to login from multiple devices with different session tokens
The database schemas should be available with the repository in the [quizzy_db](/coursework/quizzy_db/) location.

# Running the server
Provided the integrity of these files are retained and the database is setup correctly, the server can be run from the cmd folder by running `go run main.go`. In case an executable file is available, you can run it also provided the preconditions are met. Comments are retained on the golang program since it will be easy to debug in case of any errors in the backend. 

# What's not in the server?
- Automatic task generation is a seperate program and has to be run separately to obtain the JSON file. It has to be placed in the correct location with the same name `tasks_backend.json` for server to run without any user intervention.
- Creation of MySQL database is not handled in the server. It has to be done separately by the user. (Basic setting up details of a database are provided in the Database section above)
- The time.Now() package has some issues as it is inconsistent in the time output provided. Sometimes it provides time with UTC 0000, sometimes with UTC+0100. Hence, a session time is 80 minutes provided here, so that user will have atleast 20 minutes session.

# Some References
References are also mentioned within the code itself. There might be some missing references here that might have been mentioned in the code.
- [Golang official documentation](https://pkg.go.dev/)
- Project layout inspired from: [Medium: Getting Started with Go Project](https://medium.com/evendyne/getting-started-with-go-project-structure-ab8814ded9c3)
- [Markdown documentation](https://www.markdownguide.org/)
- [Go and databases](https://go.dev/doc/tutorial/database-access)
- [MySQL installation](https://allthings.how/how-to-install-mysql-on-windows-11/)
- [MySQL Basics](https://www.mysqltutorial.org/mysql-basics/mysql-commands/)
- [MySQL with VSCode](https://www.geeksforgeeks.org/how-to-connect-to-mysql-server-using-vs-code-and-fix-errors/)
- [MySQL Composite Primary Key](https://hevodata.com/learn/mysql-composite-primary-key/)
- [Exception Handling in Golang]( https://www.honeybadger.io/blog/go-exception-handling/)
- [Authenticating multiple logins from same user](https://dev.to/theghostmac/understanding-and-building-authentication-sessions-in-golang-1c9k)
- [Session Handling: Multiple login from same user](https://www.sohamkamani.com/golang/session-cookie-authentication)
- [Hashing of passwords](https://gobyexample.com/sha256-hashes)
- [Logic Quiz App reference](https://github.com/zjhnb11/logic_quiz_App)