import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:the_salon/features/appointments/presentation/pages/book_appointment_page.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_event.dart';

class HomePage extends StatefulWidget {
  final UserEntity currUser;
  const HomePage({super.key, required this.currUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // tabs
  late final Map<String, Map<String, dynamic>> tabs;

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    tabs = {
      'home': {
        'icon': Icon(Icons.home),
        'page': BookAppointmentPage(currUser: widget.currUser),
      },
      // 'profile': {
      //   'icon': Icon(FontAwesomeIcons.person),
      //   'page': ProfilePage(uid: widget.currUid),
      // },
    };
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      body:
      // TABS VIEW
      TabBarView(
        controller: _tabController,
        children:
            tabs.entries
                .map((entry) => (entry.value['page'] as Widget))
                .toList(),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          tabs:
              tabs.entries
                  .map((entry) => Tab(icon: entry.value['icon']))
                  .toList(),
        ),
      ),
    );
  }
}
// class HomePage extends StatelessWidget {
//   final UserEntity currUser;
//   const HomePage({super.key, required this.currUser});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
//             icon: Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text('home'),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<AppointmentBloc>().add(
//                   AppointmentBookAppointment(
//                     appointment: Appointment(
//                       id: '1111',
//                       customerId: '9999',
//                       barberId: '00000',
//                       date: DateTime.now(),
//                       time: '09:00',
//                       status: AppointmentStatus.booked,
//                     ),
//                   ),
//                 );
//               },
//               child: Text('Add Appointment'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<AppointmentBloc>().add(
//                   AppointmentGetAvailableSlots(barberId: '00000'),
//                 );
//               },
//               child: Text('Add Appointment'),
//             ),
//             BookAppointmentPage(currUser: currUser),
//           ],
//         ),
//       ),
//     );
//   }
// }
