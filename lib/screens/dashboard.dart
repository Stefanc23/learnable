import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/icons/icon-avatar.png'),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, ',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
                Text('Username Placeholder',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white))
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(16, 8, 16, 0)),
          ],
        ),
        toolbarHeight: 178,
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg-appbar.png'),
                fit: BoxFit.fitWidth),
          ),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            padding: EdgeInsets.only(left: 16.0),
            width: double.infinity,
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 1.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          'assets/images/class-thumbnail.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text('Class Name')),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 1.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          'assets/images/class-thumbnail.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text('Class Name')),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 1.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          'assets/images/class-thumbnail.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text('Class Name')),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          'assets/images/class-thumbnail.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text('Class Name')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text('To-do',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black))),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.filter_list_sharp, size: 28),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
              padding: EdgeInsets.all(4.0),
              width: double.infinity,
              height: 200,
              child: ListView(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(8.0),
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.5,
                            spreadRadius: 0.1,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('Assignment',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.black)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('Class Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline!
                                            .copyWith(color: Colors.black)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('21 October 2021 (23.59)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline!
                                            .copyWith(color: Colors.black)),
                                  )),
                            ],
                          ),
                          Icon(
                            Icons.navigate_next_sharp,
                            size: 32,
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(8.0),
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.5,
                            spreadRadius: 0.1,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('Assignment',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.black)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('Class Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline!
                                            .copyWith(color: Colors.black)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('21 October 2021 (23.59)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline!
                                            .copyWith(color: Colors.black)),
                                  )),
                            ],
                          ),
                          Icon(
                            Icons.navigate_next_sharp,
                            size: 32,
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(8.0),
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.5,
                            spreadRadius: 0.1,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('Assignment',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.black)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('Class Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline!
                                            .copyWith(color: Colors.black)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Text('21 October 2021 (23.59)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline!
                                            .copyWith(color: Colors.black)),
                                  )),
                            ],
                          ),
                          Icon(
                            Icons.navigate_next_sharp,
                            size: 32,
                          ),
                        ],
                      )),
                ],
              )),
        ],
      )),
    );
  }
}
