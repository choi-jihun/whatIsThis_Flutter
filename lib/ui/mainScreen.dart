import 'package:flutter/material.dart';
import 'package:whatisthis/ui/adventure/adventure_page.dart';
import 'package:whatisthis/ui/dictionary/dictionary_page.dart';
import 'package:whatisthis/ui/home/home_page.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const DictionaryPage(),
    const AdventurePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '도감'),
            BottomNavigationBarItem(
                icon: Icon(Icons.workspace_premium), label: '탐험일지'),
          ]),
    );
  }
}
