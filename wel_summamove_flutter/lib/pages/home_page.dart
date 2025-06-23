import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

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
    final auth = context.watch<AuthProvider>();

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),

        // Top bar
        Positioned(
          top: 0, left: 0, right: 0, height: 140,
          child: Container(
            color: Colors.grey[800],
            child: SafeArea(
              bottom: false,
              child: const Center(
                child: Text(
                  'Summa Move',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),

        // Logo
        const Positioned(
          top: 90, left: 0, right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),

        // Tagline
        const Positioned(
          bottom: 300, left: 16,
          child: Text(
            'Basic equipment, better results',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),

        // Headline
        const Positioned(
          bottom: 220, left: 16, right: 16,
          child: Text(
            'NEXT-LEVEL UPPER-BODY STRENGTH',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        // Login / Logout row
        Positioned(
          bottom: 75, left: 16, right: 16,
          child: _loading
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : auth.isLoggedIn
              ? Row(
            children: [
              Expanded(
                child: Text(
                  'Logged in as ${auth.email}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () async => await auth.logout(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Logout', style: TextStyle(color: Colors.black)),
              ),
            ],
          )
              : Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  setState(() => _loading = true);
                  final ok = await auth.login(_emailCtl.text, _pwCtl.text);
                  setState(() => _loading = false);
                  if (!ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login failed')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Login', style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _emailCtl,
                      decoration: const InputDecoration(
                        hintText: 'E-mail', filled: true, fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _pwCtl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Wachtwoord', filled: true, fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide.none),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
