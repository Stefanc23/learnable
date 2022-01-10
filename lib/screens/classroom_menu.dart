import 'package:flutter/material.dart';
import 'package:learnable/constants.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/models/classroom.dart';
import 'package:learnable/models/user.dart';
import 'package:learnable/screens/assignment.dart';
import 'package:learnable/screens/material.dart';
import 'package:learnable/services/classroom_service.dart';

class ClassroomMenu extends StatefulWidget {
  final User user;
  final Classroom classroom;
  const ClassroomMenu({Key? key, required this.user, required this.classroom})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ClassroomMenuState createState() => _ClassroomMenuState(user, classroom);
}

class _ClassroomMenuState extends State<ClassroomMenu> {
  User user;
  Classroom classroom;

  _ClassroomMenuState(this.user, this.classroom);

  List<User> attendees = [];

  void _fetchAttendees() async {
    ApiResponse response = await getAttendees(classroom.id as String);
    if (response.error == null) {
      setState(() {
        attendees = response.data as List<User>;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    _fetchAttendees();
    super.initState();
  }

  void _backOnTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(163),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: _backOnTap,
              child: const Icon(
                Icons.arrow_back_sharp,
              )),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${classroom.name}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${classroom.role}',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                  const Icon(Icons.settings, color: Colors.white),
                ],
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 72 - MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('People',
                          style: Theme.of(context).textTheme.overline),
                      TextButton.icon(
                        onPressed: () {
                          // Respond to button press
                        },
                        icon:
                            Icon(Icons.add, size: 18, color: Color(0xFF000000)),
                        label: Text('Invite',
                            style: Theme.of(context).textTheme.button),
                      )
                    ]),
              ),
              const SizedBox(height: 17),
              SizedBox(
                height: 92,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      attendees.length + 1,
                      (i) => i == 0
                          ? const SizedBox(width: 36)
                          : Container(
                              margin: const EdgeInsets.only(right: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage:
                                        attendees[i - 1].profileImage == ''
                                            ? const AssetImage(
                                                'assets/icons/icon-avatar.png')
                                            : null,
                                    child: attendees[i - 1].profileImage != ''
                                        ? Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      '$baseURL/${attendees[i - 1].profileImage}')),
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(height: 6),
                                  Text('${attendees[i - 1].name}',
                                      style:
                                          Theme.of(context).textTheme.caption),
                                  const SizedBox(height: 4),
                                  Text('${attendees[i - 1].role}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline!
                                          .copyWith(
                                              fontWeight: FontWeight.w300)),
                                ],
                              ),
                            )),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 24,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 25),
                    children: [
                      MenuCard(
                          icon: Icons.backpack,
                          label: 'Assignment',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Assignment(
                                        className: classroom.name as String)));
                          }),
                      MenuCard(
                          icon: Icons.voice_chat, label: 'Meet', onTap: () {}),
                      MenuCard(icon: Icons.quiz, label: 'Quiz', onTap: () {}),
                      MenuCard(
                          icon: Icons.menu_book, label: 'Exam', onTap: () {}),
                      MenuCard(
                          icon: Icons.library_books,
                          label: 'Materials',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MaterialScreen(
                                        className: classroom.name as String)));
                          }),
                      MenuCard(
                          icon: Icons.message, label: 'Forum', onTap: () {}),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final icon;
  final String label;
  final VoidCallback onTap;

  const MenuCard(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 1,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Icon(icon,
                    size: 96, color: Theme.of(context).primaryColor)),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(label, style: Theme.of(context).textTheme.subtitle2),
            ),
          ],
        ),
      ),
    );
  }
}
