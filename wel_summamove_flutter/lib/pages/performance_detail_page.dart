import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/oefening.dart';
import '../models/prestatie.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../services/prestatie_service.dart';
import '../widgets/custom_app_bar.dart';

class PerformanceDetailPage extends StatefulWidget {
  final Prestatie prestatie;
  final Oefening oefening;
  const PerformanceDetailPage({
    Key? key,
    required this.prestatie,
    required this.oefening,
  }) : super(key: key);

  @override
  State<PerformanceDetailPage> createState() => _PerformanceDetailPageState();
}

class _PerformanceDetailPageState extends State<PerformanceDetailPage> {
  late DateTime _selectedDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late int _startSecond;
  late int _endSecond;
  late TextEditingController _aantalCtl;

  @override
  void initState() {
    super.initState();

    _selectedDate = DateTime.parse(widget.prestatie.datum);

    // starttijd
    final s = widget.prestatie.starttijd.split(':');
    _startTime    = TimeOfDay(hour: int.parse(s[0]), minute: int.parse(s[1]));
    _startSecond  = s.length > 2 ? int.parse(s[2]) : 0;

    // eindtijd
    final e = widget.prestatie.eindtijd.split(':');
    _endTime   = TimeOfDay(hour: int.parse(e[0]), minute: int.parse(e[1]));
    _endSecond = e.length > 2 ? int.parse(e[2]) : 0;

    _aantalCtl = TextEditingController(text: widget.prestatie.aantal.toString());
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (d != null) setState(() => _selectedDate = d);
  }

  Future<void> _pickTime({required bool isStart}) async {
    final texts = context.read<LanguageProvider>().texts;

    // pick hh:mm
    final t = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (t == null) return;

    // then seconds
    final secCtl = TextEditingController(
      text: (isStart ? _startSecond : _endSecond).toString().padLeft(2, '0'),
    );
    final sec = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isStart ? texts.pickStartSeconds : texts.pickEndSeconds),
        content: TextField(
          controller: secCtl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: '00–59'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text(texts.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final v = int.tryParse(secCtl.text) ?? 0;
              Navigator.pop(context, v.clamp(0, 59));
            },
            child: Text(texts.save),
          ),
        ],
      ),
    );
    if (sec == null) return;

    setState(() {
      if (isStart) {
        _startTime = t;
        _startSecond = sec;
      } else {
        _endTime = t;
        _endSecond = sec;
      }
    });
  }

  // helpers
  String _two(int v) => v.toString().padLeft(2, '0');
  String get _formattedDate =>
      '${_selectedDate.year}-${_two(_selectedDate.month)}-${_two(_selectedDate.day)}';
  String get _formattedStart =>
      '${_two(_startTime.hour)}:${_two(_startTime.minute)}:${_two(_startSecond)}';
  String get _formattedEnd =>
      '${_two(_endTime.hour)}:${_two(_endTime.minute)}:${_two(_endSecond)}';

  String get _duration {
    final startDt = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _startTime.hour, _startTime.minute, _startSecond);
    final endDt = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _endTime.hour, _endTime.minute, _endSecond);
    final diff = endDt.difference(startDt);
    final m = diff.inMinutes.toString().padLeft(2, '0');
    final s = (diff.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _save() async {
    final texts = context.read<LanguageProvider>().texts;
    final auth  = context.read<AuthProvider>();

    final ok = await PrestatieService.updatePrestatieFull(
      token: auth.token!,
      prestatieId: widget.prestatie.id,
      datum: _formattedDate,
      starttijd: _formattedStart,
      eindtijd: _formattedEnd,
      aantal: int.tryParse(_aantalCtl.text) ?? widget.prestatie.aantal,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? texts.updateSuccess : texts.updateFailed)),
    );
    if (ok) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final texts = context.watch<LanguageProvider>().texts;

    return Scaffold(
      appBar: CustomAppBar(title: widget.oefening.naam),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // date
            TextButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(_formattedDate),
            ),
            const SizedBox(height: 8),

            // start time
            TextButton.icon(
              onPressed: () => _pickTime(isStart: true),
              icon: const Icon(Icons.play_arrow),
              label: Text(_formattedStart),
            ),
            const SizedBox(height: 8),

            // end time
            TextButton.icon(
              onPressed: () => _pickTime(isStart: false),
              icon: const Icon(Icons.stop),
              label: Text(_formattedEnd),
            ),
            const SizedBox(height: 16),

            // duration
            Center(
              child: Text(
                '${texts.durationLabel} $_duration',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            // reps
            TextField(
              controller: _aantalCtl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: texts.repsLabel),
            ),
            const SizedBox(height: 24),

            // save
            Center(
              child: ElevatedButton(
                onPressed: _save,
                child: Text(texts.saveChanges),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
