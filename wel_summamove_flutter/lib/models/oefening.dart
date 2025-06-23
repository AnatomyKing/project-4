class Oefening {
  final int id;
  final String naam;
  final String beschrijvingNl;
  final String beschrijvingEn;
  final String afbeeldingUrl;

  Oefening({
    required this.id,
    required this.naam,
    required this.beschrijvingNl,
    required this.beschrijvingEn,
    required this.afbeeldingUrl,
  });

  factory Oefening.fromJson(Map<String, dynamic> json) {
    return Oefening(
      id: json['id'],
      naam: json['naam'],
      beschrijvingNl: json['beschrijving_nl'],
      beschrijvingEn: json['beschrijving_en'] ?? '',
      afbeeldingUrl: json['afbeelding_url'] ?? '',
    );
  }
}
