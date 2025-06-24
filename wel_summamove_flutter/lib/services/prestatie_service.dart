import 'dart:convert';
import 'package:http/http.dart' as http;

class PrestatieService {
  static const _baseUrl = 'http://10.0.2.2:8000/api';

  /// Save a new prestatie via POST /prestaties
  static Future<bool> savePrestatie({
    required String token,
    required int oefeningId,
    required DateTime start,
    required DateTime end,
    required int aantal,
  }) async {
    final url = Uri.parse('$_baseUrl/prestaties');
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

  /// Update an existing prestatie completely via PUT /prestaties/{id}
  static Future<bool> updatePrestatieFull({
    required String token,
    required int prestatieId,
    required String datum,
    required String starttijd,
    required String eindtijd,
    required int aantal,
  }) async {
    final url = Uri.parse('$_baseUrl/prestaties/$prestatieId');
    final resp = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'datum': datum,
        'starttijd': starttijd,
        'eindtijd': eindtijd,
        'aantal': aantal,
      }),
    );
    return resp.statusCode == 200;
  }

  /// Delete a prestatie
  static Future<bool> deletePrestatie({
    required String token,
    required int prestatieId,
  }) async {
    final url = Uri.parse('$_baseUrl/prestaties/$prestatieId');
    final resp = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    return resp.statusCode == 204;
  }

  static String _formatHms(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}
