// lib/pages/about_page.dart

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../widgets/custom_app_bar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${info.version}+${info.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CustomAppBar(title: 'About SummaMove'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App title
            Center(
              child: Text(
                'SummaMove',
                style: theme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (_version.isNotEmpty) ...[
              const SizedBox(height: 4),
              Center(
                child: Text(
                  'Version $_version',
                  style: theme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Author
            Text(
              'Author',
              style: theme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Joan van Duren'),
            const SizedBox(height: 24),

            // Sections
            _buildSectionTitle(context, 'Inleiding'),
            const Text(
              'SummaMove is een compleet systeem om studenten van het Summa College '
                  'aan te moedigen meer te bewegen. De kern is een smartphone-app waarmee '
                  'gebruikers oefeningen kunnen starten, timen en hun prestaties vastleggen.',
            ),
            const SizedBox(height: 16),

            _buildSectionTitle(context, 'Het Bedrijf'),
            const Text(
              'SummaMove is een jonge startup die als eerste stap de app binnen Summa College uitrolt, '
                  'met de ambitie later ook andere scholen te bereiken.',
            ),
            const SizedBox(height: 16),

            _buildSectionTitle(context, 'Probleemstelling'),
            const Text(
              'Momenteel ontbreekt een geautomatiseerd systeem om oefeningen bij te houden. '
                  'Deze app biedt een overzicht van oefeningen en laat (geregistreerde) gebruikers '
                  'hun eigen prestaties vastleggen.',
            ),
            const SizedBox(height: 16),

            _buildSectionTitle(context, 'Doelgroepen'),
            const Text(
              '• Beheerder (admin)\n'
                  '• Gastgebruiker (anoniem)\n'
                  '• Geregistreerde gebruiker (student)',
            ),
            const SizedBox(height: 16),

            _buildSectionTitle(context, 'Vormgeving'),
            const Text(
              'De app heeft een frisse, overzichtelijke look:\n'
                  '- Duidelijke navigatie\n'
                  '- Donker-grijze header met wit accent\n'
                  '- Eenvoudige knoppen en lijsten',
            ),
            const SizedBox(height: 16),

            _buildSectionTitle(context, 'Informatie'),
            const Text(
              '• Gebruiker: oefeningsoverzicht, beschrijvingen, foto’s\n'
                  '• Geregistreerde gebruiker: plus prestatie-historie\n'
                  '• Beheerder (later via web): beheren van gebruikers, oefeningen en prestaties',
            ),
            const SizedBox(height: 32),

            // Help & Support button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.help_outline),
                label: const Text('Help & Support'),
                onPressed: () {
                  // e.g. launch mailto:support@summamove.nl
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                      Text('Stuur een e-mail naar support@summamove.nl'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
