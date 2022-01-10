import 'package:flutter/material.dart';
import 'package:learnable/widgets/materials_card.dart';

class MaterialScreen extends StatelessWidget {
  final String className;

  const MaterialScreen({Key? key, required this.className}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _backOnTap() {
      Navigator.pop(context);
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: _backOnTap, child: const Icon(Icons.arrow_back_sharp)),
          title: Align(
              alignment: Alignment.topRight,
              child: Text(
                className,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
              )),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(64),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    child: Text(
                      'Materials',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                )),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextButton.icon(
                          onPressed: () {
                            // Respond to button press
                          },
                          icon: Icon(Icons.add,
                              size: 18, color: Color(0xFF000000)),
                          label: Text('Add New Material',
                              style: Theme.of(context).textTheme.button),
                        ))),
                const SizedBox(height: 8),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const MaterialCard(
                        materialName: 'Introduction to R',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const MaterialCard(
                        materialName: 'Introduction to R',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const MaterialCard(
                        materialName: 'Introduction to R',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const MaterialCard(
                        materialName: 'Introduction to R',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const MaterialCard(
                        materialName: 'Introduction to R',
                      ),
                    ),
                  ],
                )),
              ]),
        ));
  }
}
