// ignore_for_file: prefer_final_locals
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _emailCtl = TextEditingController();
  final _pwCtl = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final auth  = context.watch<AuthProvider>();
    final texts = context.watch<LanguageProvider>().texts;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
        ),
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.3))),

        // top bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 140,
          child: Container(
            color: const Color(0xFF707070),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Text(texts.homeTitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),

        // logo
        const Positioned(
          top: 90,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),

        // tagline & headline
        Positioned(
          bottom: 300,
          left: 16,
          child: Text(texts.tagline,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ),
        Positioned(
          bottom: 220,
          left: 16,
          right: 16,
          child: Text(texts.headline,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),

        // login block
        Positioned(
          bottom: 75,
          left: 16,
          right: 16,
          child: _loading
              ? const Center(
              child: CircularProgressIndicator(color: Colors.white))
              : auth.isLoggedIn
              ? Row(children: [
            Expanded(
                child: Text('${texts.loggedInAs} ${auth.email}',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16))),
            ElevatedButton(
                onPressed: () async => await auth.logout(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white),
                child: Text(texts.logout,
                    style: const TextStyle(color: Colors.black))),
          ])
              : Row(children: [
            ElevatedButton(
                onPressed: () async {
                  setState(() => _loading = true);
                  final ok = await auth
                      .login(_emailCtl.text, _pwCtl.text);
                  setState(() => _loading = false);
                  if (!ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(texts.loginFailed)));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white),
                child: Text(texts.login,
                    style: const TextStyle(color: Colors.black))),
            const SizedBox(width: 16),
            Expanded(
              child: Column(children: [
                TextField(
                  controller: _emailCtl,
                  decoration: InputDecoration(
                    hintText: texts.emailHint,
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _pwCtl,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: texts.passwordHint,
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none),
                  ),
                ),
              ]),
            )
          ]),
        ),
      ],
    );
  }
}
