import 'package:flutter/material.dart';
import 'package:learnable/models/user.dart';
import 'package:learnable/screens/profile.dart';
import 'package:learnable/widgets/class_card.dart';
import 'package:learnable/widgets/todo_card.dart';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({Key? key, required this.user}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _profileOnTap() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Profile()));
    }

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
                  '${widget.user.name}',
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
                child: const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/icons/icon-avatar.png'),
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
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 36),
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const ClassCard(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const ClassCard(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: const ClassCard(isLastCard: true),
                  ),
                ],
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
    );
  }
}
