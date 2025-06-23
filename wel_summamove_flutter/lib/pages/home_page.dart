import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1) Full‐screen background
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),

        // 2) Dark overlay
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),

        // 3) Taller top bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 140, // ↑ increased from 120
          child: Container(
            color: Colors.grey[800],
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Text(
                  'Summa Move',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),

        // 4) Logo pushed further into the image
        Positioned(
          top: 90, // ↑ moved down from 60
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: const AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),

        // 5) Tagline moved up
        Positioned(
          bottom: 300, // ↑ moved from 200
          left: 16,
          child: const Text(
            'Basic equipment, better results',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),

        // 6) Headline moved up
        Positioned(
          bottom: 220, // ↑ moved from 160
          left: 16,
          right: 16,
          child: const Text(
            'NEXT-LEVEL UPPER-BODY STRENGTH',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 7) Login row lifted up
        Positioned(
          bottom: 75, // ↑ moved from 16
          left: 16,
          right: 16,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // TODO: your login logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  children: [
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Wachtwoord',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
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
