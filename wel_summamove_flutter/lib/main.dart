import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workouts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}): super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  static final List<Widget> _pages = <Widget>[
    const Center(child: Text('Home Screen')),
    const WorkoutsScreen(),
    const AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}

class Oefening {
  final int id;
  final String naam;
  final String beschrijvingNl;
  final String beschrijvingEn;

  Oefening({
    required this.id,
    required this.naam,
    required this.beschrijvingNl,
    required this.beschrijvingEn,
  });

  factory Oefening.fromJson(Map<String, dynamic> json) {
    return Oefening(
      id: json['id'],
      naam: json['naam'],
      beschrijvingNl: json['beschrijving_nl'],
      beschrijvingEn: json['beschrijving_en'] ?? '',
    );
  }
}

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late Future<List<Oefening>> _futureOefeningen;

  @override
  void initState() {
    super.initState();
    _futureOefeningen = fetchOefeningen();
  }

  Future<List<Oefening>> fetchOefeningen() async {
    // Android emulator → host’s localhost:
    final url = 'http://10.0.2.2:8000/api/oefeningen';
    // iOS Simulator → localhost is fine:
    // final url = 'http://127.0.0.1:8000/api/oefeningen';
    // Physical device → replace with your machine’s LAN IP:
    // final url = 'http://192.168.1.42:8000/api/oefeningen';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Oefening.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load oefeningen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Workouts',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Any time, anywhere upper body',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Arms, shoulders, chest & back—no equipment needed.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Oefening>>(
              future: _futureOefeningen,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final oefeningen = snapshot.data!;
                  return ListView.builder(
                    itemCount: oefeningen.length,
                    itemBuilder: (context, index) {
                      final oef = oefeningen[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Text(oef.naam[0]),
                              radius: 28,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    oef.naam,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    oef.beschrijvingNl,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.bookmark_border),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'This is your About page.\n\nPut any info you like here.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
