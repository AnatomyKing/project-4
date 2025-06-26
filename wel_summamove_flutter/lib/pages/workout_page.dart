import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/oefening.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_header.dart';
import 'workout_detail_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Oefening> _all = [];
  List<Oefening> _filtered = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadOefeningen();
  }

  Future<void> _loadOefeningen() async {
    try {
      final resp = await http.get(Uri.parse('http://10.0.2.2:8000/api/oefeningen'));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body) as List;
        final list = data.map((e) => Oefening.fromJson(e)).toList();
        setState(() {
          _all = list;
          _filtered = list;
          _loading = false;
        });
      } else {
        throw Exception('Failed to load oefeningen');
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  void _onSearchChanged(String term) {
    term = term.toLowerCase();
    final matches = _all.where((o) => o.naam.toLowerCase().contains(term)).toList();
    final rest = _all.where((o) => !o.naam.toLowerCase().contains(term)).toList();
    matches.sort((a, b) => a.naam.compareTo(b.naam));
    rest.sort((a, b) => a.naam.compareTo(b.naam));
    setState(() => _filtered = [...matches, ...rest]);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final lang = context.watch<LanguageProvider>();
    final texts = lang.texts;
    final title = auth.isLoggedIn
        ? "${auth.name}'s ${texts.workoutNav}"
        : texts.workoutNav;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchHeader(
              hintText: texts.searchWorkoutsHint,
              titleText: texts.workoutsTitle,
              subtitleText: texts.workoutsSubtitle,
              onChanged: _onSearchChanged,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: (_, i) {
                  final oef = _filtered[i];
                  final thumb = oef.afbeeldingUrl.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      oef.afbeeldingUrl,
                      width: 120,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  )
                      : CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      oef.naam[0],
                      style: const TextStyle(
                          fontSize: 32, color: Colors.white),
                    ),
                  );

                  final desc = oef.description(isEnglish: lang.isEnglish);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ExerciseDetailPage(oefening: oef),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              thumb,
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(oef.naam,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(desc,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.play_circle_fill,
                                  size: 32, color: Color(0xFF42877E)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
