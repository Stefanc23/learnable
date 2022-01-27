import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:learnable/models/user.dart';

class AttendeeAvatar extends StatefulWidget {
  const AttendeeAvatar({
    Key? key,
    required this.attendee,
  }) : super(key: key);

  final User attendee;

  @override
  State<AttendeeAvatar> createState() => _AttendeeAvatarState();
}

class _AttendeeAvatarState extends State<AttendeeAvatar> {
  String profileImageUrl = '';

  void _getProfileImageUrl() async {
    String url = await firebase_storage.FirebaseStorage.instance
        .ref(widget.attendee.profileImage)
        .getDownloadURL();
    setState(() {
      profileImageUrl = url;
    });
  }

  @override
  void initState() {
    if (widget.attendee.profileImage != '') _getProfileImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundImage: profileImageUrl == ''
          ? const AssetImage('assets/icons/icon-avatar.png')
          : null,
      child: profileImageUrl != ''
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(profileImageUrl)),
              ),
            )
          : null,
    );
  }
}
