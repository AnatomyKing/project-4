import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/oefening.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../services/prestatie_service.dart';
import '../widgets/custom_app_bar.dart';

class ExerciseDetailPage extends StatefulWidget {
  final Oefening oefening;
  const ExerciseDetailPage({Key? key, required this.oefening}) : super(key: key);

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  Timer? _timer;
  DateTime? _startTime;
  int _elapsed = 0;
  bool _running = false;

  void _start() {
    _timer?.cancel();
    _startTime = DateTime.now();
    setState(() => _running = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed++);
    });
  }

  void _pause() => _timer?.cancel();

  Future<void> _stop() async {
    _timer?.cancel();
    final end = DateTime.now();
    setState(() => _running = false);

    final lang  = context.read<LanguageProvider>();
    final texts = lang.texts;
    final auth  = context.read<AuthProvider>();

    if (auth.token == null) return; // guest → just stop

    final repsCtl = TextEditingController();
    final sure = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(texts.repsDialogTitle),
        content: TextField(
          controller: repsCtl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: texts.repsHint),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(texts.cancel)),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text(texts.save)),
        ],
      ),
    );

    if (sure == true && _startTime != null) {
      final reps = int.tryParse(repsCtl.text) ?? 0;
      final ok = await PrestatieService.savePrestatie(
        token: auth.token!,
        oefeningId: widget.oefening.id,
        start: _startTime!,
        end: end,
        aantal: reps,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ok ? texts.saved : texts.saveFailed)),
      );
    }
  }

  String _fmt(int sec) =>
      '${(sec ~/ 60).toString().padLeft(2, '0')}:${(sec % 60).toString().padLeft(2, '0')}';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang  = context.watch<LanguageProvider>();
    final texts = lang.texts;
    final oef   = widget.oefening;

    return Scaffold(
      appBar: CustomAppBar(title: oef.naam),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (oef.afbeeldingUrl.isNotEmpty)
              Image.network(oef.afbeeldingUrl,
                  width: double.infinity, height: 240, fit: BoxFit.cover)
            else
              Container(
                width: double.infinity,
                height: 240,
                color: Colors.grey,
                child: Center(
                  child: Text(oef.naam[0],
                      style: const TextStyle(fontSize: 64, color: Colors.white)),
                ),
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(oef.description(isEnglish: lang.isEnglish),
                  style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            if (!_running)
              ElevatedButton(onPressed: _start, child: Text(texts.startTimer))
            else ...[
              Text(_fmt(_elapsed),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: _pause, child: Text(texts.pauseTimer)),
                  const SizedBox(width: 16),
                  ElevatedButton(onPressed: _stop,  child: Text(texts.stopTimer)),
                ],
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
