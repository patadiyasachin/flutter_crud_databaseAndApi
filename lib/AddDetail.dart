import 'package:crud_evaluation/MyDatabase.dart';
import 'package:flutter/material.dart';

class AddDetail extends StatefulWidget {
  Map<String,dynamic>? map={};
  AddDetail(this.map);

  @override
  State<AddDetail> createState() => _AddDetailState();
}

class _AddDetailState extends State<AddDetail> {
  var nameController=TextEditingController();

  @override
  void initState() {
    nameController.text=widget.map==null?"":widget.map!['name'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
          ),
          ElevatedButton(onPressed: () async {
            if(widget.map==null){
              await MyDatabase().insertStudent(nameController.text.toString()).then((value) {
                Navigator.of(context).pop();
              },);
            }else{
              await MyDatabase().editStudent(widget.map!['id'],nameController.text.toString()).then((value) {
                Navigator.of(context).pop();
              },);
            }
          }, child:Text("Submit")),
        ],
      ),
    );
  }
}
