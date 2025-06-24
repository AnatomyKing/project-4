class Prestatie {
  final int id;
  final int oefeningId;
  final String datum;
  final String starttijd;
  final String eindtijd;
  final int aantal;

  Prestatie({
    required this.id,
    required this.oefeningId,
    required this.datum,
    required this.starttijd,
    required this.eindtijd,
    required this.aantal,
  });

  factory Prestatie.fromJson(Map<String, dynamic> json) {
    return Prestatie(
      id: json['id'],
      oefeningId: json['oefening_id'],
      datum: json['datum'],
      starttijd: json['starttijd'] ?? '',
      eindtijd: json['eindtijd'] ?? '',
      aantal: json['aantal'],
    );
  }
}
