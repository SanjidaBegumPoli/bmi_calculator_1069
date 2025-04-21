import 'package:flutter/material.dart';
import 'bmi_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo Image
        Image.asset(
          'assests/images/bmicalculator.png',
          width: 120,
          height: 120,
        ),
        const SizedBox(height: 20),

        // Welcome Text
        const Text(
          'Welcome to the BMI Calculator App!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'Tap the button below to calculate your BMI',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    const Center(
      child: Text(
        'Patient Profile\n(Name, Age, Gender, etc.)',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    ),
    const Center(
      child: Text(
        'Settings\n(Theme, Language, Notifications)',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openBMICalculator() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BmiCalculator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health App'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('BMI Calculator'),
              onTap: _openBMICalculator,
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About App'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('About'),
                    content: const Text('This is a simple BMI Calculator app.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openBMICalculator,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.calculate),
      ),
    );
  }
}
