import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity user;
  const ProfilePage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: [
          // profile image
          CachedNetworkImage(
            imageUrl: '',
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(backgroundImage: imageProvider);
            },
            errorWidget: (context, url, error) {
              return CircleAvatar(child: Icon(Icons.error));
            },
          ),
          // name
          Text(user.name),

          // appointments

          // upcoming appointments

          // past appointments
        ],
      ),
    );
  }
}
