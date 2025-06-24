import 'app_texts.dart';

class GBAppTexts implements AppTexts {
  // navigation
  @override String get homeNav => 'Home';
  @override String get workoutNav => 'Workouts';
  @override String get performanceNav => 'Performance';
  @override String get aboutNav => 'About';
  @override String get pleaseLogIn => 'Please log in!';

  // home
  @override String get homeTitle => 'Summa Move';
  @override String get tagline   => 'Basic equipment, better results';
  @override String get headline  => 'NEXT-LEVEL UPPER-BODY STRENGTH';
  @override String get login     => 'Login';
  @override String get logout    => 'Logout';
  @override String get emailHint => 'E-mail';
  @override String get passwordHint => 'Password';
  @override String get loginFailed => 'Login failed';
  @override String get loggedInAs  => 'Logged in as';

  // workout
  @override String get searchWorkoutsHint => 'Search workouts';
  @override String get workoutsTitle      => 'Any time, anywhere upper body';
  @override String get workoutsSubtitle   => 'Arms, shoulders, chest & back—no equipment needed.';

  // performance list
  @override String get searchPerformancesHint => 'Search performances';
  @override String get perfFilterSubtitle     => 'Filter by exercise';
  @override String get repsSuffix             => 'reps';

  // exercise detail
  @override String get startTimer => 'Start Timer';
  @override String get pauseTimer => 'Pause';
  @override String get stopTimer  => 'Stop';
  @override String get repsDialogTitle => 'Number of reps';
  @override String get repsHint        => 'e.g. 10';
  @override String get cancel          => 'Cancel';
  @override String get save            => 'Save';
  @override String get saved           => 'Saved!';
  @override String get saveFailed      => 'Save failed';

  // performance detail
  @override String get pickDate          => 'Select date';
  @override String get pickStartSeconds  => 'Start seconds';
  @override String get pickEndSeconds    => 'End seconds';
  @override String get durationLabel     => 'Duration:';
  @override String get repsLabel         => 'Number of reps';
  @override String get saveChanges       => 'Save Changes';
  @override String get updateSuccess     => 'Updated!';
  @override String get updateFailed      => 'Update failed';

  // about
  @override String get aboutTitle       => 'About SummaMove';
  @override String get appName          => 'SummaMove';
  @override String get versionLabel     => 'Version';
  @override String get version          => '1.0.0+1';
  @override String get sectionInleiding => 'Introduction';
  @override String get textInleiding    => 'SummaMove is a complete system …';
  @override String get sectionBedrijf   => 'The Company';
  @override String get textBedrijf      => 'SummaMove is a young startup …';
  @override String get sectionProbleem  => 'Problem Statement';
  @override String get textProbleem     => 'Currently there is no automated …';
  @override String get sectionDoelgroepen => 'Target groups';
  @override String get textDoelgroepen    => '• Admin • Guest • Registered student';
  @override String get helpSupport      => 'Help & Support';
  @override String get helpSnackbar     => 'Send an e-mail to support@summamove.nl';
}
