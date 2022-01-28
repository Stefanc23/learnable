import 'package:flutter/material.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';

class addMaterial extends StatefulWidget {
  addMaterial({Key? key}) : super(key: key);

  @override
  State<addMaterial> createState() => _addMaterialState();
}

class _addMaterialState extends State<addMaterial> {
  final TextEditingController titleMaterialController = TextEditingController();

  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {}, child: const Icon(Icons.arrow_back_sharp)),
        title: const Center(child: Text("Add New Material")),
        centerTitle: true,
        actions: const [SizedBox(width: 48)],
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        child: CustomTextFormField(
                            controller: titleMaterialController,
                            hintText: 'Material Title')),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Respond to button press
                      },
                      icon: Icon(Icons.add, size: 18, color: Color(0xFF000000)),
                      label: Text('Choose File',
                          style: Theme.of(context).textTheme.button),
                    ),
                    const SizedBox(height: 16),
                    Text('File Name',
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: const Text('SUBMIT'))
                      ],
                    )
                  ],
                )),
          ]))
        ],
      ),
    );
  }
}
