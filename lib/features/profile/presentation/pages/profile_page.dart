import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/appointments/presentation/components/appointment_tile.dart';
import 'package:the_salon/features/appointments/presentation/components/appointments_list.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_event.dart';
import 'package:the_salon/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:the_salon/features/profile/presentation/bloc/profile_event.dart';
import 'package:the_salon/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  final UserEntity user;
  final int tabIndex; // 👈 Pass the current tab index
  const ProfilePage({required this.user, required this.tabIndex, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  late ProfileBloc profileBloc;
  late AuthBloc authBloc;

  int? previousTabIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    profileBloc = context.read<ProfileBloc>();
    authBloc = context.read<AuthBloc>();

    previousTabIndex = widget.tabIndex;
  }

  @override
  void didUpdateWidget(covariant ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex && widget.tabIndex == 1) {
      // Re-fetch only when Profile tab becomes active again
      getAppointments();
    }
  }

  void getAppointments() {
    profileBloc.add(ProfileGetAppointments(userId: widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // For keep-alive

    // text style
    final listTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
        actions: [
          IconButton(
            onPressed: () => authBloc.add(AuthLogout()),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          CachedNetworkImage(
            imageUrl: widget.user.profileImageUrl,
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(backgroundImage: imageProvider, radius: 80);
            },
            errorWidget:
                (context, url, error) =>
                    const CircleAvatar(child: Icon(Icons.error)),
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
          ),
          Text(widget.user.name),
          BlocConsumer<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProfileLoaded) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // upcoming appointments
                        Text('Upcoming Appointments', style: listTitle),
                        SizedBox(height: 10),
                        // loading
                        (state.isLoadingAppointments)
                            ? Center(child: CircularProgressIndicator())
                            // loaded
                            : (state.upcomingAppointments.isNotEmpty)
                            ? AppointmentsList(
                              appointments: state.upcomingAppointments,
                            )
                            : Text('No Upcoming Appointments'),

                        SizedBox(height: 20),

                        // past appointments
                        Text('Past Appointments', style: listTitle),
                        SizedBox(height: 10),
                        // loading
                        (state.isLoadingAppointments)
                            ? Center(child: CircularProgressIndicator())
                            :
                            // loaded
                            (state.pastAppointments.isNotEmpty)
                            ? AppointmentsList(
                              appointments: state.pastAppointments,
                            )
                            : Text('No Upcoming Appointments'),
                      ],
                    ),
                  ),
                );
              }

              return Container();
            },
            listener: (context, state) {},
          ),
        ],
      ),
    );
  }
}
