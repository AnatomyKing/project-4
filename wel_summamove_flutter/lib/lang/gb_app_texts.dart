import 'app_texts.dart';

class GBAppTexts implements AppTexts {
  // navigation
  @override String get homeNav => 'Home';
  @override String get workoutNav => 'Workouts';
  @override String get performanceNav => 'Performance';
  @override String get aboutNav => 'About';
  @override String get pleaseLogIn => 'Please log in!';

// home
  @override String get homeTitle     => 'Summa Move';
  @override String get tagline       => 'With an account, you can easily track your performance!';
  @override String get headline      => 'TRACK YOUR PROGRESS. MOVE YOUR SUMMA.';
  @override String get login         => 'Login';
  @override String get logout        => 'Logout';
  @override String get emailHint     => 'Email';
  @override String get passwordHint  => 'Password';
  @override String get loginFailed   => 'Login failed';
  @override String get loggedInAs    => 'Logged in as';


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
  @override String get aboutTitle       => 'About Summa Move';
  @override String get appName          => 'Summa Move';
  @override String get versionLabel     => 'Version';
  @override String get version          => '1.0.0+1';
  @override String get sectionInleiding => 'Introduction';
  @override String get textInleiding    => 'Summa Move is an initiative to get students from Summa College to move more. Through the app, students can perform exercises in and around school. Performances are tracked automatically.';
  @override String get sectionBedrijf   => 'The Company';
  @override String get textBedrijf      => 'Summa Move is a young startup aiming to first roll out their fitness app within Summa College, and later offer it to other schools.';
  @override String get sectionProbleem  => 'Problem Statement';
  @override String get textProbleem     => 'There was no system yet to easily offer exercises to students or track their performance. That’s why this app and the management system were developed to automate the process.';
  @override String get sectionDoelgroepen => 'Target Audience';
  @override String get textDoelgroepen    => 'Summa Move is primarily intended for Summa students to help them stay active!';
  @override String get helpSupport      => 'Help & Support';
  @override String get helpSnackbar     => 'Send an email to support@summamove.nl';
}
