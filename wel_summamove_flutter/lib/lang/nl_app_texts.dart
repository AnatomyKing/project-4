import 'app_texts.dart';

class NLAppTexts implements AppTexts {
  // navigation
  @override String get homeNav => 'Startpagina';
  @override String get workoutNav => 'Oefeningen';
  @override String get performanceNav => 'Prestaties';
  @override String get aboutNav => 'Informatie';
  @override String get pleaseLogIn => 'Log eerst in!';

  // home
  @override String get homeTitle => 'Summa Move';
  @override String get tagline   => 'Met een account houd je eenvoudig je prestaties bij!';
  @override String get headline  => 'TRACK JE VOORTGANG. BEWEEG JOUW SUMMA.';
  @override String get login     => 'Inloggen';
  @override String get logout    => 'Uitloggen';
  @override String get emailHint => 'E-mail';
  @override String get passwordHint => 'Wachtwoord';
  @override String get loginFailed => 'Login mislukt';
  @override String get loggedInAs  => 'Ingelogd als';

  // workout
  @override String get searchWorkoutsHint => 'Zoek oefeningen';
  @override String get workoutsTitle      => 'Oefeningen speciaal voor jou!';
  @override String get workoutsSubtitle   => 'Armen, schouders, borst, laat jou die summa maar voelen.';

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
  @override String get aboutTitle       => 'Over Summa Move';
  @override String get appName          => 'Summa Move';
  @override String get versionLabel     => 'Versie';
  @override String get version          => '1.0.0+1';
  @override String get sectionInleiding => 'Inleiding';
  @override String get textInleiding    => 'Summa Move is een initiatief om studenten van het Summa College meer te laten bewegen. Via de app kunnen studenten oefeningen doen op en rond school. Prestaties worden automatisch bijgehouden.';
  @override String get sectionBedrijf   => 'Het Bedrijf';
  @override String get textBedrijf      => 'Summa Move is een jonge startup met als doel hun beweeg-app eerst binnen Summa College uit te rollen en daarna ook aan andere scholen aan te bieden.';
  @override String get sectionProbleem  => 'Probleemstelling';
  @override String get textProbleem     => 'Er was nog geen systeem om studenten op een makkelijke manier oefeningen aan te bieden of prestaties bij te houden. Daarom is deze app en het beheersysteem ontwikkeld om dit proces te automatiseren.';
  @override String get sectionDoelgroepen => 'Doelgroepen';
  @override String get textDoelgroepen    => 'Summa Move is vooral bestemt voor Summa studenten om actief in beweging te blijven!';
  @override String get helpSupport      => 'Hulp & Support';
  @override String get helpSnackbar     => 'Stuur een e-mail naar support@summamove.nl';
}
