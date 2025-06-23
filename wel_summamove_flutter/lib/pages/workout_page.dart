import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/oefening.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}): super(key: key);

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
    // Android emulator → host’s localhost
    final url = 'http://10.0.2.2:8000/api/oefeningen';
    // iOS Simulator → 'http://127.0.0.1:8000/api/oefeningen'
    // Physical device → use your LAN IP

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Oefening.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load oefeningen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Workouts',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Any time, anywhere upper body',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Arms, shoulders, chest & back—no equipment needed.',
              style: TextStyle(color: Colors.grey),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Oefening>>(
              future: _futureOefeningen,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final oefeningen = snapshot.data!;
                  return ListView.builder(
                    itemCount: oefeningen.length,
                    itemBuilder: (context, index) {
                      final oef = oefeningen[index];

                      // Thumbnail or avatar fallback
                      Widget thumbnail;
                      if (oef.afbeeldingUrl.isNotEmpty) {
                        thumbnail = ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            oef.afbeeldingUrl,
                            width: 120,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        thumbnail = CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            oef.naam[0],
                            style: const TextStyle(fontSize: 32, color: Colors.white),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                thumbnail,
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        oef.naam,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        oef.beschrijvingNl,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.bookmark_border, size: 28),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

