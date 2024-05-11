import 'package:flutter/material.dart';
import 'package:forest_fire/screens/contact_us.dart';
import 'package:forest_fire/screens/home_page.dart';
import 'package:forest_fire/screens/logs.dart';

import 'my_predictor.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const LogsScreen(),
      MyWidget(),
      const ContactUsScreen(),// Add MyWidget to the list of pages
    ];

    return Scaffold(
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.restore_sharp),
              label: 'Logs'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), // Choose an appropriate icon
              label: 'Predictor' // Choose an appropriate label
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.call_sharp),
              label: 'Contact Us'
          ),
        ],
      ),
    );
  }
}
