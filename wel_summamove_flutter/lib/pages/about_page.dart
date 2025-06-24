import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  static const _version = '1.0.0+1';

  @override
  Widget build(BuildContext context) {
    final texts = context.watch<LanguageProvider>().texts;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar(title: texts.aboutTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Text(texts.appName,
                style: theme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text('${texts.versionLabel} $_version',
                style: theme.titleSmall?.copyWith(color: Colors.grey[700])),
          ),
          const SizedBox(height: 24),
          _section(context, texts.sectionInleiding, texts.textInleiding),
          _section(context, texts.sectionBedrijf,   texts.textBedrijf),
          _section(context, texts.sectionProbleem,  texts.textProbleem),
          _section(context, texts.sectionDoelgroepen, texts.textDoelgroepen),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.help_outline),
              label: Text(texts.helpSupport),
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(texts.helpSnackbar))),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _section(BuildContext ctx, String title, String body) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(ctx)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(body),
      ],
    ),
  );
}
