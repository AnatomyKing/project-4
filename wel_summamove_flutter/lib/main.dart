// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/language_provider.dart';
import 'pages/home_page.dart';
import 'pages/workout_page.dart';
import 'pages/performance_page.dart';
import 'pages/about_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Summa Move',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF2C3E50),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
        ),
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const _pages = [
    HomePage(),
    WorkoutPage(),
    PerformancePage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final texts = context.watch<LanguageProvider>().texts;
    final auth  = context.watch<AuthProvider>();

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          // intercept Performance tap when not logged in
          if (i == 2 && !auth.isLoggedIn) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(texts.pleaseLogIn)));
            setState(() => _selectedIndex = 0);
          } else {
            setState(() => _selectedIndex = i);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: texts.homeNav,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center),
            label: texts.workoutNav,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.flag),
            label: texts.performanceNav,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            label: texts.aboutNav,
          ),
        ],
      ),
    );
  }
}
