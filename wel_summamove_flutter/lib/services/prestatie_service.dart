import 'dart:convert';
import 'package:http/http.dart' as http;

class PrestatieService {
  /// Save a performance via POST /prestaties
  static Future<bool> savePrestatie({
    required String token,
    required int oefeningId,
    required DateTime start,
    required DateTime end,
    required int aantal,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/prestaties');
    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'oefening_id': oefeningId,
        'datum': start.toIso8601String().split('T')[0],
        'starttijd': _formatHms(start),
        'eindtijd': _formatHms(end),
        'aantal': aantal,
      }),
    );
    return resp.statusCode == 201;
  }

  static String _formatHms(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}
