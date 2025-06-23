import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/oefening.dart';
import '../providers/auth_provider.dart';
import 'exercise_detail_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late Future<List<Oefening>> _futureOefeningen;

  @override
  void initState() {
    super.initState();
    _futureOefeningen = fetchOefeningen();
  }

  Future<List<Oefening>> fetchOefeningen() async {
    final resp = await http.get(Uri.parse('http://10.0.2.2:8000/api/oefeningen'));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Oefening.fromJson(e)).toList();
    }
    throw Exception('Failed to load oefeningen');
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // If logged in, show indicator + logout
          if (auth.isLoggedIn)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logged in as ${auth.email}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () => auth.logout(),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Workouts', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ),

          // ... (search & subtitle as before) ...

          Expanded(
            child: FutureBuilder<List<Oefening>>(
              future: _futureOefeningen,
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('Error: ${snap.error}'));
                }
                final oefeningen = snap.data!;
                return ListView.builder(
                  itemCount: oefeningen.length,
                  itemBuilder: (_, i) {
                    final oef = oefeningen[i];
                    Widget thumb = oef.afbeeldingUrl.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(oef.afbeeldingUrl, width: 120, height: 90, fit: BoxFit.cover),
                    )
                        : CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.blueGrey,
                      child: Text(oef.naam[0], style: const TextStyle(fontSize: 32, color: Colors.white)),
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              thumb,
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(oef.naam, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(oef.beschrijvingNl, style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.play_circle_fill, size: 32, color: Colors.blue),
                                onPressed: auth.isLoggedIn
                                    ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ExerciseDetailPage(oefening: oef)),
                                )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
