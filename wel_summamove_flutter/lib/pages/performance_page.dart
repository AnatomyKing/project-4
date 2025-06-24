// lib/pages/performance_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/oefening.dart';
import '../models/prestatie.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../services/prestatie_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_header.dart';
import 'performance_detail_page.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({Key? key}) : super(key: key);
  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  final List<Prestatie> _all = [];
  List<Prestatie> _filtered = [];
  final Map<int, Oefening> _map = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final token = context.read<AuthProvider>().token!;
    try {
      final oefResp = await http.get(Uri.parse('http://10.0.2.2:8000/api/oefeningen'));
      final prestResp = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/prestaties'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final oefList = (jsonDecode(oefResp.body) as List)
          .map((e) => Oefening.fromJson(e))
          .toList();
      final prestList = (jsonDecode(prestResp.body) as List)
          .map((e) => Prestatie.fromJson(e))
          .toList();

      setState(() {
        _map
          ..clear()
          ..addEntries(oefList.map((o) => MapEntry(o.id, o)));
        _all
          ..clear()
          ..addAll(prestList);
        _filtered = List.from(_all);
        _loading = false;
      });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  void _onSearchChanged(String term) {
    term = term.toLowerCase();
    final matches = _all
        .where((p) =>
        (_map[p.oefeningId]?.naam.toLowerCase() ?? '').contains(term))
        .toList();
    final rest = _all
        .where((p) =>
    !(_map[p.oefeningId]?.naam.toLowerCase() ?? '').contains(term))
        .toList()
      ..sort((a, b) =>
          _map[a.oefeningId]!.naam.compareTo(_map[b.oefeningId]!.naam));
    matches.sort((a, b) =>
        _map[a.oefeningId]!.naam.compareTo(_map[b.oefeningId]!.naam));
    setState(() => _filtered = [...matches, ...rest]);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final lang = context.watch<LanguageProvider>();
    final texts = lang.texts;
    final title = auth.isLoggedIn
        ? "${auth.name}'s ${texts.performanceNav}"
        : texts.performanceNav;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      floatingActionButton: RawMaterialButton(
        onPressed: () {}, // add-dialog later
        fillColor: const Color(0xFF42877E),
        shape: const CircleBorder(),
        constraints: const BoxConstraints.tightFor(width: 56, height: 56),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            SearchHeader(
              hintText: texts.searchPerformancesHint,
              titleText: '',
              subtitleText: texts.perfFilterSubtitle,
              onChanged: _onSearchChanged,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: (_, i) {
                  final p = _filtered[i];
                  final oef = _map[p.oefeningId]!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${oef.naam} — ${p.aantal} ${texts.repsSuffix}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${p.datum} ${p.starttijd}–${p.eindtijd}',
                                    style: const TextStyle(
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings),
                              color: const Color(0xFF42877E),
                              onPressed: () async {
                                final updated =
                                await Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PerformanceDetailPage(
                                            prestatie: p, oefening: oef),
                                  ),
                                );
                                if (updated == true) _loadData();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: const Color(0xFF42877E),
                              onPressed: () async {
                                final ok =
                                await PrestatieService.deletePrestatie(
                                  token: auth.token!,
                                  prestatieId: p.id,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(ok
                                        ? texts.updateSuccess
                                        : texts.updateFailed),
                                  ),
                                );
                                if (ok) _loadData();
                              },
                            ),
                          ],
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
