import 'package:flutter/material.dart';
import 'package:the_salon/features/appointments/presentation/pages/book_appointment_page.dart';
import 'package:the_salon/features/profile/presentation/pages/profile_page.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

class HomePage extends StatefulWidget {
  final UserEntity currUser;

  const HomePage({super.key, required this.currUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      BookAppointmentPage(currUser: widget.currUser),
      ProfilePage(user: widget.currUser),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:
            (index) => setState(() {
              _currentIndex = index;
            }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
