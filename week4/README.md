## my_namer_app

A basic flutter app based on the flutter codelab(https://codelabs.developers.google.com/codelabs/flutter-codelab-first#0).

Here, the learnings from the codelab and other information shall be documented.

- Everything in Flutter is Widgets. Designing the layout beforehand becomes necessary to avoid too much trial and error.
- By creating the project from View --> Command Palette --> Create new flutter project, all necessary requirements for running your application either on the emulator or as a PC app is set on its own from VS Code.
- Widgets are usually having 3 functionalities:
a. StatelessWidget --> Immutable and generally fixed layout here. State changes can be defined but layout remains fixed.
b. StatefulWidget --> UI can be changed i.e. mutable (mutation i.e, can change), with response to input. Different states are to be defined.
- Most commonly used Basic Widgets --> Row, Column, Text, Container, Scaffold, ElevatedButton
- There are other widgets to make the app UI more visual, structural and interactive. Refer to the links below.
- Refactor is a cool option from flutter, allowing you to make changes on the go and easily without having to write classes from scratch. You can also easily wrap widgets with other widgets without having to worry about brackets.
- Use of "outline" tab allows you to understand the structure of your code.
- Use "widget inspector" and related dart dev tools to visualize how the widgets are positioned on the screen, based on the code written.
- OBSERVATION: The code is easy to run from the native device rather than on an emulator. Emulator requires high-performing computers, since it is now a device on its own. Nevertheless, testing is easier on the native platform and then can be tested with android emulator. 


In the current "my_namer_app" --> instructions as per codelab is followed with small experiments in design here and there.
- The developed app has an UI as shown in the figures below. The UI has been tested on windows as well as an android emulator.
# App home page in the emulator
<p>
    <img src="/week4/imgs/app_home.png">
</p>

# App favorites page
<p>
    <img src="/week4/imgs/app_fav.png">
</p>

# App history page
<p>
    <img src="/week4/imgs/app_history.png ">
</p>

A demo of the app's usage is presented in the video available in [this folder](/week4/imgs/)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
