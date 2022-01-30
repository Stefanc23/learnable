import 'package:flutter/material.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/models/class_material.dart';
import 'package:learnable/models/classroom.dart';
import 'package:learnable/screens/add_material.dart';
import 'package:learnable/services/material_service.dart';
import 'package:learnable/widgets/materials_card.dart';

class MaterialScreen extends StatefulWidget {
  final Classroom classroom;

  const MaterialScreen({Key? key, required this.classroom}) : super(key: key);

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  List<ClassMaterial> materials = [];
  bool loading = true;

  void _getMaterials() async {
    ApiResponse response = await getMaterials(widget.classroom.id as String);

    if (response.error == null) {
      setState(() {
        materials = response.data as List<ClassMaterial>;
      });
    }
    setState(() {
      loading = false;
    });
  }

  void _deleteMaterial(String materialId) async {
    setState(() {
      loading = true;
    });

    ApiResponse response = await deleteMaterial(materialId);

    if (response.error == null) {
      _getMaterials();
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    _getMaterials();
    super.initState();
  }

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
                widget.classroom.name as String,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
              )),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(64),
            child: Padding(
                padding: const EdgeInsets.all(16),
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
                if (widget.classroom.role == 'Instructor')
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddMaterial(
                                          classroomId:
                                              widget.classroom.id as String,
                                          onSubmit: _getMaterials)));
                            },
                            icon: const Icon(Icons.add,
                                size: 18, color: Color(0xFF000000)),
                            label: Text('Add New Material',
                                style: Theme.of(context).textTheme.button),
                          ))),
                const SizedBox(height: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : materials.isNotEmpty
                            ? ListView.builder(
                                itemCount: materials.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: MaterialCard(
                                        userRole:
                                            widget.classroom.role as String,
                                        material: materials[index],
                                        onDelete: _deleteMaterial),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('Nothing here yet.'),
                              ),
                  ),
                ),
              ]),
        ));
  }
}
