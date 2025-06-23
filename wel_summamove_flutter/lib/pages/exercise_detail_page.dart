import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/oefening.dart';
import '../providers/auth_provider.dart';
import '../services/prestatie_service.dart';

class ExerciseDetailPage extends StatefulWidget {
  final Oefening oefening;
  const ExerciseDetailPage({super.key, required this.oefening});

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
    setState(() { _running = true; _elapsed = 0; });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed++);
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  Future<void> _stop() async {
    _timer?.cancel();
    final end = DateTime.now();
    setState(() { _running = false; });
    final repsCtl = TextEditingController();
    final auth = context.read<AuthProvider>();

    final sure = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Aantal herhalingen'),
        content: TextField(controller: repsCtl, keyboardType: TextInputType.number),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );

    if (sure == true && auth.token != null && _startTime != null) {
      final reps = int.tryParse(repsCtl.text) ?? 0;
      final ok = await PrestatieService.savePrestatie(
        token: auth.token!,
        oefeningId: widget.oefening.id,
        start: _startTime!,
        end: end,
        aantal: reps,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ok ? 'Saved!' : 'Failed to save')),
      );
    }
  }

  String _fmt(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final oef = widget.oefening;
    return Scaffold(
      appBar: AppBar(title: Text(oef.naam), backgroundColor: Colors.grey[800]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (oef.afbeeldingUrl.isNotEmpty)
              Image.network(oef.afbeeldingUrl, width: double.infinity, height: 240, fit: BoxFit.cover)
            else
              Container(
                width: double.infinity,
                height: 240,
                color: Colors.grey,
                child: Center(child: Text(oef.naam[0], style: const TextStyle(fontSize: 64, color: Colors.white))),
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(oef.beschrijvingNl, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            if (!_running)
              ElevatedButton(onPressed: _start, child: const Text('Start Timer'))
            else ...[
              Text(_fmt(_elapsed), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: _pause, child: const Text('Pause')),
                  const SizedBox(width: 16),
                  ElevatedButton(onPressed: _stop, child: const Text('Stop')),
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
