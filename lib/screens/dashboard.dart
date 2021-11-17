import 'package:flutter/material.dart';
import 'package:learnable/widgets/class_card.dart';
import 'package:learnable/widgets/todo_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(194),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
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
                  'Name',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 130, right: 16),
              child: GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/icons/icon-avatar.png'),
                ),
              ),
            ),
          ],
          toolbarHeight: 194,
          elevation: 0,
          flexibleSpace:
              Image.asset('assets/images/bg-appbar.png', fit: BoxFit.cover),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
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
                        Container(
                            child: Text('To-do',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.black))),
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
