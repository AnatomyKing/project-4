import 'app_texts.dart';

class NLAppTexts implements AppTexts {
  // navigation
  @override String get homeNav => 'Home';
  @override String get workoutNav => 'Workouts';
  @override String get performanceNav => 'Prestaties';
  @override String get aboutNav => 'Over';
  @override String get pleaseLogIn => 'Log eerst in!';

  // home
  @override String get homeTitle => 'Summa Move';
  @override String get tagline   => 'Basic equipment, better results';
  @override String get headline  => 'NEXT-LEVEL UPPER-BODY STRENGTH';
  @override String get login     => 'Login';
  @override String get logout    => 'Logout';
  @override String get emailHint => 'E-mail';
  @override String get passwordHint => 'Wachtwoord';
  @override String get loginFailed => 'Login mislukt';
  @override String get loggedInAs  => 'Ingelogd als';

  // workout
  @override String get searchWorkoutsHint => 'Zoek workouts';
  @override String get workoutsTitle      => 'Altijd en overal bovenlichaam';
  @override String get workoutsSubtitle   => 'Armen, schouders, borst & rug—geen materiaal nodig.';

  // performance list
  @override String get searchPerformancesHint => 'Zoek prestaties';
  @override String get perfFilterSubtitle     => 'Filter op oefening';
  @override String get repsSuffix             => 'herhalingen';

  // exercise detail
  @override String get startTimer => 'Start timer';
  @override String get pauseTimer => 'Pauze';
  @override String get stopTimer  => 'Stop';
  @override String get repsDialogTitle => 'Aantal herhalingen';
  @override String get repsHint        => 'bijv. 10';
  @override String get cancel          => 'Annuleer';
  @override String get save            => 'Opslaan';
  @override String get saved           => 'Opgeslagen!';
  @override String get saveFailed      => 'Opslaan mislukt';

  // performance detail
  @override String get pickDate          => 'Kies datum';
  @override String get pickStartSeconds  => 'Startseconden';
  @override String get pickEndSeconds    => 'Eindseconden';
  @override String get durationLabel     => 'Duur:';
  @override String get repsLabel         => 'Aantal reps';
  @override String get saveChanges       => 'Wijzigingen opslaan';
  @override String get updateSuccess     => 'Bijgewerkt!';
  @override String get updateFailed      => 'Bijwerken mislukt';

  // about
  @override String get aboutTitle       => 'Over SummaMove';
  @override String get appName          => 'SummaMove';
  @override String get versionLabel     => 'Versie';
  @override String get version          => '1.0.0+1';
  @override String get sectionInleiding => 'Inleiding';
  @override String get textInleiding    => 'SummaMove is een compleet systeem …';
  @override String get sectionBedrijf   => 'Het Bedrijf';
  @override String get textBedrijf      => 'SummaMove is een jonge startup …';
  @override String get sectionProbleem  => 'Probleemstelling';
  @override String get textProbleem     => 'Momenteel ontbreekt …';
  @override String get sectionDoelgroepen => 'Doelgroepen';
  @override String get textDoelgroepen    => '• Beheerder • Gast • Student';
  @override String get helpSupport      => 'Help & Support';
  @override String get helpSnackbar     => 'Stuur een e-mail naar support@summamove.nl';
}
