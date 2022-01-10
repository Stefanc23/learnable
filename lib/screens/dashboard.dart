import 'package:flutter/material.dart';
import 'package:learnable/constants.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/models/user.dart';
import 'package:learnable/screens/classroom_menu.dart';
import 'package:learnable/screens/createclass.dart';
import 'package:learnable/screens/profile.dart';
import 'package:learnable/services/user_service.dart';
import 'package:learnable/widgets/class_card.dart';
import 'package:learnable/widgets/todo_card.dart';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Dashboard> createState() => _DashboardState(user);
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  User user;

  _DashboardState(this.user);

  void _updateUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
      });
    }
  }

  void _profileOnTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Profile(user: user, updateUserDetails: _updateUser)));
  }

  @override
  Widget build(BuildContext context) {
    var classes = List.generate(
        user.classrooms!.length + 2,
        (i) => i == 0
            ? const SizedBox(width: 36)
            : i == user.classrooms!.length + 1
                ? Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: ClassCard(
                      isLastCard: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateClass(
                                    updateUserDetails: _updateUser)));
                      },
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: ClassCard(
                      className: user.classrooms![i - 1].name as String,
                      classThumbnail:
                          user.classrooms![i - 1].bannerImage as String,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClassroomMenu(
                                    user: user,
                                    classroom: user.classrooms![i - 1])));
                      },
                    ),
                  ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(194),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.only(
                left: 16, top: 69 - MediaQuery.of(context).padding.top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  '${user.name}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 130, right: 16),
              child: GestureDetector(
                onTap: _profileOnTap,
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: user.profileImage == ''
                      ? const AssetImage('assets/icons/icon-avatar.png')
                      : null,
                  child: user.profileImage != ''
                      ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    '$baseURL/${user.profileImage}')),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ],
          toolbarHeight: 194 + MediaQuery.of(context).padding.top,
          elevation: 0,
          flexibleSpace:
              Image.asset('assets/images/bg-appbar.png', fit: BoxFit.cover),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 69 - MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: classes,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('To-do',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black)),
                          const Icon(Icons.filter_list_sharp, size: 28),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: const TodoCard(
                                type: 'Assignment',
                                className: 'Class Name',
                                datetime: '21 October 2021 (23.59)',
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: const TodoCard(
                                type: 'Meet',
                                className: 'Class Name',
                                datetime: '23 October 2021 (14.00)',
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: const TodoCard(
                                type: 'Quiz',
                                className: 'Class Name',
                                datetime: '23 October 2021 (23.59)',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
