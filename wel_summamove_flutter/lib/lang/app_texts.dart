/// Keys for all translatable UI strings.
abstract class AppTexts {
  // navigation
  String get homeNav;
  String get workoutNav;
  String get performanceNav;
  String get aboutNav;
  String get pleaseLogIn;

  // home page
  String get homeTitle;
  String get tagline;
  String get headline;
  String get login;
  String get logout;
  String get emailHint;
  String get passwordHint;
  String get loginFailed;
  String get loggedInAs;

  // workout page
  String get searchWorkoutsHint;
  String get workoutsTitle;
  String get workoutsSubtitle;

  // performance page
  String get searchPerformancesHint;
  String get perfFilterSubtitle;
  String get repsSuffix;          // “reps”

  // exercise detail
  String get startTimer;
  String get pauseTimer;
  String get stopTimer;
  String get repsDialogTitle;
  String get repsHint;
  String get cancel;
  String get save;
  String get saved;
  String get saveFailed;

  // performance detail
  String get pickDate;
  String get pickStartSeconds;
  String get pickEndSeconds;
  String get durationLabel;
  String get repsLabel;
  String get saveChanges;
  String get updateSuccess;
  String get updateFailed;

  // about page
  String get aboutTitle;
  String get appName;
  String get versionLabel;
  String get version;
  String get sectionInleiding;
  String get textInleiding;
  String get sectionBedrijf;
  String get textBedrijf;
  String get sectionProbleem;
  String get textProbleem;
  String get sectionDoelgroepen;
  String get textDoelgroepen;
  String get helpSupport;
  String get helpSnackbar;
}
